#!/bin/bash
# =============================================================================
# run_vco.sh - symulacja VCO (PVT + sweep Vin) i przygotowanie danych do R/C
# =============================================================================
#
# CO JEST MIERZONE I JAK (skrot; pelne wzory w plot_vco.py)
# -----------------------------------------------------------------------------
# Dla kazdej kombinacji corner/temp/vp oraz kazdego Vin z VIN_SWEEP uruchamiane
# sa DWIE analizy ngspice na tej samej (regenerowanej) netliscie:
#
#  A) TRANSIENT: tran 200p 20u
#     Zapis (wrdata): v(out_pb) v(out) i(v2) v(x2.pgt)
#       - v(out)    : przebieg wyjscia pierscienia -> f_out, v_osc (pk-pk)
#       - i(v2)     : prad zasilania rdzenia (V2) -> i_osc = -mean(i(v2))
#                     (V2I zasilane osobno z V4, wiec i(v2) to czysty prad rdzenia)
#       - v(x2.pgt) : wezel lustra pradowego (referencja/debug)
#     Parametry liczone sa w oknie ustalonym (ostatnie 30% czasu symulacji).
#
#  B) AC (tylko -meas): ac lin 1 1meg 1meg  (jeden punkt, f = 1 MHz)
#     Zrodlo V1 ma 'ac 1'. Zapis: real(i(v1)) imag(i(v1)).
#     Pojemnosc wejsciowa wezla 'in':  C = |Im(i(v1))| / (2*pi*f)  @ 1 MHz.
#
# WZMOCNIENIA (liczone w plot_vco.py jako roznice skonczone po sweepie Vin):
#   K      = d f_out / d Vin     [Hz/V]   (K_VCO)
#   gm_vco = d i_osc / d Vin     [A/V]
#   K_CCO  = d f_out / d i_osc   [Hz/A]   (K_VCO = gm_vco * K_CCO)
#   r_vco  = d v_osc / d i_osc   [Ohm]
#
# UWAGA dot. '.save': netlista moze zawierac '.save i(v1)' (potrzebne do .ac).
# Jawne '.save' powoduje ze ngspice zapisuje TYLKO wymienione wektory, przez co
# transient zwracalby puste (zero-length) out/out_pb/i(v2). Dlatego skrypt
# USUWA linie '.save' z regenerowanej netlisty, a kazdy blok .control sam
# deklaruje 'save' z potrzebnymi sygnalami.
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Znajdz korzen projektu (katalog zawierajacy configs/corner_data), idac w gore
# drzewa od polozenia skryptu. Dzieki temu skrypt dziala niezaleznie od tego,
# ile poziomow katalogow dzieli go od korzenia projektu.
PROJECT_DIR=""
_dir="$SCRIPT_DIR"
while [[ "$_dir" != "/" ]]; do
    if [[ -f "$_dir/configs/corner_data" ]]; then
        PROJECT_DIR="$_dir"
        break
    fi
    _dir="$(dirname "$_dir")"
done

if [[ -z "$PROJECT_DIR" ]]; then
    echo "Blad: nie znaleziono configs/corner_data w zadnym katalogu nadrzednym"
    echo "      wzgledem skryptu ($SCRIPT_DIR)."
    exit 1
fi

source "$PROJECT_DIR/configs/corner_data"

# Presety (-c <preset lub corner>)
# Dostepne presety:
#   typ   -> mos_tt,  t_nom,        vp_nom        (typowe warunki)
#   hot   -> mos_ss,  t_max,        vp_min        (najgorsze warunki gorace)
#   cold  -> mos_ff,  t_min,        vp_max        (najgorsze warunki zimne)
#
# Mozna tez podac nazwy cornerow bezposrednio: -c tt ss ff
# Bez argumentow: symulowane sa wszystkie cornery i wszystkie PVT
#
# -ext : symulacja post-layout. Skrypt sprawdza, ktore komorki (.subckt)
#        z netlisty maja plik ekstrakcji <cell>.pex.spice w katalogu
#        ekstrakcji i podmienia je w kopii netlisty. Komorki bez ekstrakcji
#        pozostaja schematyczne. Jesli komorka nadrzedna ma ekstrakcje, jej
#        komorki podrzedne sa pomijane (sa juz zawarte w ekstrakcji rodzica).
#
# -meas : pomiar KVCO. Zamiast domyslnych dwoch punktow Vin (0.4 0.8) robi
#         gesty sweep Vin (0.4 ... 1.0) i liczy KVCO (nachylenie f vs Vin)
#         oraz krzywe strojenia. Dodatkowo w tym trybie liczone sa parametry
#         maloosygnalowe/duzosygnalowe VCO: C (z analizy .ac na wezle in),
#         gm_vco, K (df/dVin), K_CCO (df/di_osc) oraz r_vco (dv_osc/di_osc).
#         Bez tej flagi nic z tego nie jest liczone.
#
# -debug : tryb debugowania. Nie ukrywa wyjscia ngspice, wypisuje polecenia,
#          sciezki plikow, surowe wartosci AC (1 MHz) oraz posrednie wyniki
#          roznic skonczonych. Dziala razem z -meas. Wymusza -j 1 (logi
#          z wielu watkow bylyby poprzeplatane).
#
# -cores [N ...] : symuluje kolejno warianty rdzenia vco_core_N (domyslnie
#          0 1 2 3 4, albo tylko wskazane, np. -cores 1 3). Dla kazdego N:
#            1) w netliscie instancja rdzenia (np. 'x2 vdd 0 out in vco_core_0')
#               jest przebudowywana pod vco_core_N: lista pinow bierze sie
#               z naglowka .subckt w vco_core_N.pex.spice, a kazdy pin jest
#               laczony z siecia testbenchu o tej samej nazwie (vp->vdd,
#               gnd->0; mapowanie mozna rozszerzyc w CORE_PORT_MAP),
#            2) netlista jest podmieniana na post-layout (-ext wlaczone
#               automatycznie; wymagany plik vco_core_N.pex.spice),
#            3) uruchamiany jest caly PVT/Vin sweep + plot_vco.py,
#            4) wyniki trafiaja do $RESULTS_DIR/core_N/ (png, html, data).
#
# -en5 [0|1|both] : sweep stanu pinu wyboru trybu en5 (zrodlo V3 w testbenchu):
#          0    -> V3 = 0
#          1    -> V3 = EN5_HIGH (domyslnie {vdd}, czyli en5 = napiecie zasilania
#                  danego przebiegu; dla vp_nom = 1.2 V)
#          both -> oba przypadki (domyslne w -cores dla rdzeni z pinem en5)
#          W -cores rdzenie bez pinu en5 (np. vco_core_0) licza sie raz.
#          Wyniki: results/core_N_en5_0/, results/core_N_en5_1/
#          Bez -cores: wyniki w results/en5_0/, results/en5_1/ (tylko gdy podano -en5).
#
# -j N : liczba rownoleglych symulacji ngspice (domyslnie: nproc).
#        Kazdy ngspice dziala jednowatkowo (OMP_NUM_THREADS=1), a
#        rownoleglosc dotyczy kombinacji corner/temp/vp/Vin.

FILTER_CORNERS=""
FILTER_TEMPS=""
FILTER_VPS=""
PRESET=""
USE_EXT=0
USE_MEAS=0
USE_DEBUG=0
USE_CORES=0
CORE_LIST=()
JOBS="$(nproc 2>/dev/null || echo 4)"

# Prefiks nazwy rdzenia: vco_core_0, vco_core_1, ... (zmien, jesli symbole
# nazywaja sie inaczej, np. "vco_core").
CORE_PREFIX="vco_core_"
# Mapowanie pin rdzenia -> siec testbenchu (pin=siec). Piny nieobecne tutaj sa
# laczone z siecia o tej samej nazwie (en5, nen5, en11, nen11, in, out ...).
CORE_PORT_MAP="vp=vdd gnd=0"

# en5: EN5_SEL = ""(nie ruszaj V3) | 0 | 1 | both. EN5_HIGH = wartosc dla en5=1
# (np. "{vdd}" albo "1.2"). EN5_VAL = biezaca wartosc podstawiana do V3.
EN5_SEL=""
EN5_HIGH="{vdd}"
EN5_VAL=""

EXTRACTION_DIR="$PROJECT_DIR/layout/extraction"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -ext)
            USE_EXT=1
            shift ;;
        -meas)
            USE_MEAS=1
            shift ;;
        -debug)
            USE_DEBUG=1
            shift ;;
        -cores)
            USE_CORES=1
            USE_EXT=1
            shift
            while [[ $# -gt 0 && "$1" =~ ^[0-9]+$ ]]; do
                CORE_LIST+=("$1")
                shift
            done ;;
        -en5)
            case "$2" in
                0|1|both) EN5_SEL="$2"; shift 2 ;;
                *) echo "Blad: -en5 wymaga argumentu 0, 1 lub both"; exit 1 ;;
            esac ;;
        -j)
            if [[ -z "$2" || ! "$2" =~ ^[0-9]+$ || "$2" -lt 1 ]]; then
                echo "Blad: -j wymaga dodatniej liczby calkowitej"
                exit 1
            fi
            JOBS="$2"
            shift 2 ;;
        -c) shift
            while [[ $# -gt 0 && "$1" != -* ]]; do
                case "$1" in
                    typ)
                        PRESET="typ"
                        FILTER_CORNERS="$FILTER_CORNERS mos_tt"
                        FILTER_TEMPS="$t_nom"
                        FILTER_VPS="$vp_nom"
                        ;;
                    hot)
                        PRESET="hot"
                        FILTER_CORNERS="$FILTER_CORNERS mos_ss"
                        FILTER_TEMPS="$t_max"
                        FILTER_VPS="$vp_min"
                        ;;
                    cold)
                        PRESET="cold"
                        FILTER_CORNERS="$FILTER_CORNERS mos_ff"
                        FILTER_TEMPS="$t_min"
                        FILTER_VPS="$vp_max"
                        ;;
                    *)
                        FILTER_CORNERS="$FILTER_CORNERS $1"
                        ;;
                esac
                shift
            done ;;
        *) echo "Nieznana opcja: $1"; exit 1 ;;
    esac
done

if [[ "$USE_CORES" -eq 1 && ${#CORE_LIST[@]} -eq 0 ]]; then
    CORE_LIST=(0 1 2 3 4)
fi
if [[ "$USE_CORES" -eq 1 && -z "$EN5_SEL" ]]; then
    EN5_SEL="both"
fi

if [[ "$USE_DEBUG" -eq 1 && "$JOBS" -gt 1 ]]; then
    echo "Tryb -debug: wymuszam -j 1 (wyjscie ngspice musi byc czytelne)."
    JOBS=1
fi

# Jesli nie podano presetow temp/vp, uzyj pelnego zakresu
if [[ -z "$FILTER_TEMPS" ]]; then FILTER_TEMPS="$t_min $t_nom $t_max"; fi
if [[ -z "$FILTER_VPS"   ]]; then FILTER_VPS="$vp_min $vp_nom $vp_max"; fi

if [[ -n "$FILTER_CORNERS" ]]; then
    filtered=""
    for C in $corners; do
        for F in $FILTER_CORNERS; do
            if [[ "$C" == *"$F"* ]]; then
                filtered="$filtered $C"
                break
            fi
        done
    done
    if [[ -z "$filtered" ]]; then
        echo "Blad: zaden corner nie pasuje do: $FILTER_CORNERS"
        echo "Dostepne cornery: $corners"
        exit 1
    fi
    corners="$filtered"
fi

# Sweep napiecia sterujacego Vin.
#   -meas : gesty sweep dla pomiaru KVCO
#   bez   : domyslne dwa punkty
if [[ "$USE_MEAS" -eq 1 ]]; then
    VIN_SWEEP="0.4 0.5 0.6 0.7 0.8 0.9 1.0"
else
    VIN_SWEEP="0.4 0.8"
fi

SPICE=$PROJECT_DIR/schematics/simulations/vco_dcin_tb.spice
DATA_DIR=$PROJECT_DIR/schematics/vco/results/data
RESULTS_DIR=$PROJECT_DIR/schematics/vco/results

echo "Sciezki:"
echo "  PROJECT_DIR = $PROJECT_DIR"
echo "  SPICE       = $SPICE"
echo "  DATA_DIR    = $DATA_DIR"
echo "  RESULTS_DIR = $RESULTS_DIR"
if [[ ! -f "$SPICE" ]]; then
    echo "  [BLAD] Netlista nie istnieje pod SPICE! Sprawdz sciezke."
fi

# Netlista uzywana do symulacji. Domyslnie schematyczna; przy -ext / -cores
# podmieniona na wersje post-layout zbudowana ponizej.
SIM_SPICE="$SPICE"

if [[ -n "$PRESET" ]]; then
    echo "Preset: $PRESET -> corners:$corners  temp: $FILTER_TEMPS  vp: $FILTER_VPS"
else
    echo "Symulowane cornery: wszystkie ($corners)"
fi

if [[ "$USE_MEAS" -eq 1 ]]; then
    echo "Vin sweep (KVCO / -meas): $VIN_SWEEP"
else
    echo "Vin sweep: $VIN_SWEEP  (uzyj -meas dla pomiaru KVCO)"
fi

echo "Rownolegle symulacje: $JOBS"
if [[ "$USE_CORES" -eq 1 ]]; then
    echo "Tryb -cores: warianty rdzenia: ${CORE_LIST[*]} (post-layout)"
fi

# Pomocnicza funkcja debugowania: wypisuje tylko gdy USE_DEBUG=1
dbg() {
    if [[ "$USE_DEBUG" -eq 1 ]]; then
        echo "[DEBUG] $*"
    fi
}

if [[ "$USE_DEBUG" -eq 1 ]]; then
    echo "Tryb -debug: wlaczone szczegolowe logi (wyjscie ngspice widoczne)."
fi

# Kazdy ngspice jednowatkowo - rownoleglosc robimy sami na poziomie procesow.
export OMP_NUM_THREADS=1

# Katalog roboczy na pliki tymczasowe (osobny podkatalog na kazde zadanie)
# oraz katalog logow ngspice.
WORK="$(mktemp -d /tmp/vco_work.XXXXXX)"
LOG_DIR=/tmp/vco_logs
mkdir -p "$LOG_DIR"
cleanup() { rm -rf "$WORK"; }
on_signal() {
    echo
    echo "Przerwano - zatrzymuje symulacje..."
    kill $(jobs -p) 2>/dev/null
    cleanup
    exit 130
}
trap cleanup EXIT
trap on_signal INT TERM

# -----------------------------------------------------------------------------
# make_core_netlist <N> <out>
#   Kopia netlisty z podmieniona instancja rdzenia na vco_core_<N>
#   (odpowiednik wymiany symbolu na schemacie). Rdzenie roznia sie liczba
#   pinow, wiec:
#     - lista pinow = naglowek .subckt z vco_core_<N>.pex.spice,
#     - kazdy pin -> siec testbenchu o tej samej nazwie (z CORE_PORT_MAP),
#     - stara definicja .subckt rdzenia zastepowana pustym stubem o tych
#       samych pinach (cialo i tak zastapi ekstrakcja w build_ext_netlist).
#   Dziala niezaleznie od tego, ktory rdzen (0..4) jest w bazowej netliscie.
# -----------------------------------------------------------------------------
make_core_netlist() {
    python3 - "$SPICE" "$1" "$2" "$CORE_PREFIX" "$EXTRACTION_DIR" "$CORE_PORT_MAP" <<'PYEOF'
import os
import re
import sys

src, n, out, prefix, ext_dir, map_str = sys.argv[1:7]

port_map = {}
for kv in map_str.split():
    if '=' in kv:
        k, v = kv.split('=', 1)
        port_map[k.lower()] = v


def fail(msg):
    sys.stderr.write(f'[-cores] BLAD: {msg}\n')
    sys.exit(2)


with open(src) as f:
    text = f.read()

name = f'{prefix}{n}'
pex = os.path.join(ext_dir, f'{name}.pex.spice')
if not os.path.isfile(pex):
    fail(f'brak pliku ekstrakcji {pex}')

ports = None
with open(pex) as f:
    for line in f:
        m = re.match(r'^[ \t]*\.subckt[ \t]+(\S+)[ \t]+(.*)', line, re.IGNORECASE)
        if m:
            ports = [t for t in m.group(2).split() if '=' not in t]
            break
if not ports:
    fail(f'nie znaleziono naglowka .subckt w {pex}')

inst_re = re.compile(
    r'^([ \t]*x\S*)[ \t]+(.*?)[ \t]+(' + re.escape(prefix) + r'\d+)[ \t]*$',
    re.IGNORECASE | re.MULTILINE,
)
insts = list(inst_re.finditer(text))
if not insts:
    fail(f'w netliscie nie ma instancji rdzenia ({prefix}<cyfra>)')
base_names = []
for m in insts:
    if m.group(3) not in base_names:
        base_names.append(m.group(3))

# Sieci dostepne w testbenchu (bez samych linii instancji rdzenia)
rest = inst_re.sub('', text)
nets = set()
for m in insts:   # sieci, do ktorych podlaczony byl dotychczasowy rdzen
    nets.update(t.lower() for t in m.group(2).split())
for line in rest.splitlines():
    s = line.strip()
    if s and s[0] not in '*.':
        nets.update(t.lower() for t in s.split())

conn = []
missing = []
for p in ports:
    net = port_map.get(p.lower(), p.lower())
    if net != '0' and net.lower() not in nets:
        missing.append(p)
    conn.append(net)
if missing:
    fail(f'piny {name} bez odpowiadajacej sieci w testbenchu: {missing}\n'
         f'        piny ekstrakcji: {ports}\n'
         f'        Dodaj siec do testbenchu albo regule pin=siec do CORE_PORT_MAP.')

text = inst_re.sub(lambda m: f'{m.group(1)} {" ".join(conn)} {name}', text)

stub = f'.subckt {name} {" ".join(ports)}\n.ends\n'
placed = False
for b in base_names:
    block_re = re.compile(
        r'^[ \t]*\.subckt[ \t]+' + re.escape(b) + r'\b.*?^[ \t]*\.ends\b[^\n]*\n?',
        re.IGNORECASE | re.DOTALL | re.MULTILINE,
    )
    def repl(m, first=not placed):
        return stub if first else ''
    text, k = block_re.subn(repl, text, count=1)
    if k:
        placed = True
if not placed:
    fail(f'nie znaleziono definicji .subckt {base_names}')

with open(out, 'w') as f:
    f.write(text)
sys.stderr.write(f'[-cores] {", ".join(base_names)} -> {name}; piny: '
                 + ', '.join(f'{p}->{c}' for p, c in zip(ports, conn))
                 + f'\n[-cores] netlista: {out}\n')
PYEOF
}

# -----------------------------------------------------------------------------
# build_ext_netlist <in> <out> [wymagana_komorka]
#   Buduje netliste post-layout. Jesli podano wymagana_komorke (tryb -cores),
#   to jej ekstrakcja MUSI zostac faktycznie wstawiona; inaczej blad
#   (np. gdy ekstrakcja rodzica przykrywa rdzen i wszystkie warianty byly by
#   identyczne).
# -----------------------------------------------------------------------------
build_ext_netlist() {
    python3 - "$1" "$EXTRACTION_DIR" "$2" "$3" <<'PYEOF'
import re
import sys
import os

in_path, ext_dir, out_path = sys.argv[1:4]
required = (sys.argv[4] if len(sys.argv) > 4 else '') or None

with open(in_path) as f:
    netlist = f.read()


def parse_subckts(text):
    subckts = {}
    pattern = re.compile(
        r'^[ \t]*\.subckt[ \t]+(\S+)[ \t]+(.*?)\n(.*?)^[ \t]*\.ends\b',
        re.IGNORECASE | re.DOTALL | re.MULTILINE,
    )
    for m in pattern.finditer(text):
        name = m.group(1)
        ports = m.group(2).split()
        body = m.group(3)
        child_tokens = set()
        for line in body.splitlines():
            s = line.strip()
            if s and s[0] in 'xX' and not s.startswith('*'):
                toks = s.split()
                if len(toks) >= 2:
                    child_tokens.add(toks[-1])
        subckts[name] = {'ports': ports, 'body': body, 'child_tokens': child_tokens}
    return subckts


def parse_ext_header(pex_path):
    with open(pex_path) as f:
        for line in f:
            m = re.match(r'^[ \t]*\.subckt[ \t]+(\S+)[ \t]+(.*)', line, re.IGNORECASE)
            if m:
                return m.group(1), m.group(2).split()
    return None, None


def descendants(name, subckts):
    seen = set()
    stack = [name]
    while stack:
        cur = stack.pop()
        info = subckts.get(cur)
        if not info:
            continue
        for tok in info['child_tokens']:
            if tok in subckts and tok not in seen:
                seen.add(tok)
                stack.append(tok)
    seen.discard(name)
    return seen


subckts = parse_subckts(netlist)

available = {}
for name in subckts:
    pex = os.path.join(ext_dir, f'{name}.pex.spice')
    if os.path.isfile(pex):
        available[name] = pex

if required and required not in available:
    sys.stderr.write(
        f'[-ext] BLAD: brak ekstrakcji dla wymaganej komorki {required}: '
        f'{os.path.join(ext_dir, required + ".pex.spice")}\n'
    )
    sys.exit(2)

if not available:
    sys.stderr.write(
        f'[-ext] Brak plikow ekstrakcji w {ext_dir} dla zadnej komorki '
        f'({", ".join(sorted(subckts)) or "brak"}).\n'
    )
    sys.exit(2)

excluded = set()
for name in available:
    excluded |= descendants(name, subckts) & set(available)
selected = {n: p for n, p in available.items() if n not in excluded}

if required and required not in selected:
    sys.stderr.write(
        f'[-ext] BLAD: ekstrakcja {required} jest pomijana, bo komorka nadrzedna '
        f'ma wlasna ekstrakcje (rdzen jest juz w niej zawarty - warianty '
        f'rdzenia bylyby identyczne).\n'
    )
    sys.exit(2)

out = netlist
adapters = []
substituted = []

for name, pex in selected.items():
    ext_name, ext_ports = parse_ext_header(pex)
    with open(pex) as f:
        ext_body_full = f.read()

    sch_ports = subckts[name]['ports']

    # Mapowanie portow po NAZWIE (nie po pozycji), bo ekstrakcja moze miec
    # inna kolejnosc i inna liczbe portow niz schemat.
    #   sch_ports (5): vp gnd out in v2i_vp
    #   ext_ports (4): in out gnd vp    (brak v2i_vp)
    # Porty ekstrakcji, ktore istnieja w schemacie -> mapujemy 1:1 po nazwie.
    # Porty schematu nieobecne w ekstrakcji (tu: v2i_vp) -> nie ida do xpex,
    # ale zwieramy je wewnatrz adaptera do 'vp' (w layoucie V2I dzieli vp).
    #
    # Konfigurowalne zwarcia: port_schematu -> z czym zewrzec, gdy brak w ext.
    # (Gdyby ekstrakcja miala inne braki, dopisz tu regule.)
    shorts = {'v2i_vp': 'vp'}

    ext_set = set(ext_ports)
    sch_set = set(sch_ports)

    # Porty ekstrakcji muszą istniec w schemacie (po ewentualnym uwzglednieniu
    # zwarcia). Jesli ekstrakcja ma port nieznany schematowi -> nie umiemy go
    # podlaczyc, ostrzegamy i pomijamy komorke.
    unknown_ext = [p for p in ext_ports if p not in sch_set]
    if unknown_ext:
        sys.stderr.write(
            f'[-ext] UWAGA: ekstrakcja {name} ma porty nieznane schematowi: '
            f'{unknown_ext}\n'
            f'        schemat:    {sch_ports}\n'
            f'        ekstrakcja: {ext_ports}\n'
            f'        Nie umiem ich podlaczyc; pomijam ta komorke.\n'
        )
        continue

    # Porty schematu nieobecne w ekstrakcji: musza miec regule zwarcia,
    # inaczej zwisalyby (np. v2i_vp). Sprawdzamy.
    missing_in_ext = [p for p in sch_ports if p not in ext_set]
    unshorted = [p for p in missing_in_ext if p not in shorts]
    if unshorted:
        sys.stderr.write(
            f'[-ext] UWAGA: porty schematu {name} nieobecne w ekstrakcji i bez '
            f'reguly zwarcia: {unshorted}\n'
            f'        schemat:    {sch_ports}\n'
            f'        ekstrakcja: {ext_ports}\n'
            f'        Dodaj regule do "shorts" w skrypcie. Pomijam ta komorke.\n'
        )
        continue

    if missing_in_ext:
        sys.stderr.write(
            f'[-ext] INFO {name}: porty {missing_in_ext} nieobecne w ekstrakcji; '
            f'zwieram je zgodnie z regula {shorts}.\n'
        )

    block_re = re.compile(
        r'^[ \t]*\.subckt[ \t]+' + re.escape(name) + r'\b.*?^[ \t]*\.ends\b[^\n]*\n?',
        re.IGNORECASE | re.DOTALL | re.MULTILINE,
    )
    out = block_re.sub('', out)

    pex_name = f'{name}__pex'
    ext_renamed = re.sub(
        r'(^[ \t]*\.subckt[ \t]+)' + re.escape(ext_name) + r'\b',
        r'\1' + pex_name,
        ext_body_full,
        count=1,
        flags=re.IGNORECASE | re.MULTILINE,
    )

    # Wywolanie xpex: dla kazdego portu ekstrakcji podajemy odpowiadajacy
    # wezel adaptera. Poniewaz mapujemy po nazwie, a porty adaptera to
    # sch_ports, wezel = ta sama nazwa (port ekstrakcji istnieje w schemacie).
    xpex_nodes = ' '.join(ext_ports)

    # Zwarcia dla portow schematu nieobecnych w ekstrakcji: R=0 (albo alias).
    # Uzywamy 0-omowego rezystora, bo ngspice nie ma prostszego aliasu wezlow
    # wewnatrz .subckt. Znak: to laczy np. v2i_vp z vp.
    short_lines = ''
    for i, p in enumerate(missing_in_ext):
        tgt = shorts[p]
        short_lines += f'R_short_{i} {p} {tgt} 0\n'

    adapter = (
        f'* ---- PEX adapter dla {name} ----\n'
        f'*   porty schematu (zachowane): {" ".join(sch_ports)}\n'
        f'*   porty ekstrakcji (xpex):    {" ".join(ext_ports)}\n'
        f'*   zwarcia (brak w ext):       {missing_in_ext} -> {shorts}\n'
        f'.subckt {name} {" ".join(sch_ports)}\n'
        f'xpex {xpex_nodes} {pex_name}\n'
        f'{short_lines}'
        f'.ends\n'
        f'{ext_renamed.rstrip()}\n'
    )
    adapters.append(adapter)
    substituted.append(name)

if not adapters:
    sys.stderr.write('[-ext] Nic nie podmieniono; przerywam.\n')
    sys.exit(2)

if required and required not in substituted:
    sys.stderr.write(f'[-ext] BLAD: nie udalo sie podmienic wymaganej komorki {required}.\n')
    sys.exit(2)

ext_section = (
    '\n* ==== BEGIN PEX substitutions (generated by -ext) ====\n'
    + '\n'.join(adapters)
    + '* ==== END PEX substitutions ====\n'
)
if re.search(r'^[ \t]*\.end\b', out, re.IGNORECASE | re.MULTILINE):
    out = re.sub(
        r'(^[ \t]*\.end\b)',
        ext_section + r'\1',
        out,
        count=1,
        flags=re.IGNORECASE | re.MULTILINE,
    )
else:
    out = out + ext_section

with open(out_path, 'w') as f:
    f.write(out)

sys.stderr.write('[-ext] Zastosowano ekstrakcje:\n')
for name in sorted(substituted):
    sys.stderr.write(f'         ekstrakcja:  {name}\n')
for name in sorted(excluded):
    sys.stderr.write(f'         pominieto (wewnatrz ekstrahowanego rodzica): {name}\n')
for name in sorted(set(subckts) - set(available)):
    sys.stderr.write(f'         schemat (brak ekstrakcji): {name}\n')
PYEOF
}

# -----------------------------------------------------------------------------
# print_params - wypisuje parametry .param z uzywanej netlisty
# -----------------------------------------------------------------------------
print_params() {
    echo "Simulation parameters:"
    python3 - "$SIM_SPICE" <<'PYEOF'
import re, sys
spice_path = sys.argv[1]
skip = {'temp', 'vdd', 'vin'}
with open(spice_path) as f:
    for line in f:
        m = re.match(r'\.param\s+(\w+)\s*=\s*(\S+)', line.strip(), re.IGNORECASE)
        if m and m.group(1).lower() not in skip:
            print(f"  {m.group(1)}={m.group(2)}")
PYEOF
}

# Usun wszystkie poprzednie wyniki przed kazda symulacja
clean_results() {
    mkdir -p "$DATA_DIR"
    rm -f "$DATA_DIR"/vco_*.dat
    rm -f "$DATA_DIR"/vco_*.acdat
    rm -f "$RESULTS_DIR"/vco_*.png
    rm -f "$RESULTS_DIR"/kvco_*.png
    rm -f "$RESULTS_DIR"/rc_*.png
    rm -f "$RESULTS_DIR"/vco_report.html
}

# -----------------------------------------------------------------------------
# run_job <corner> <temp> <vp> <vin>
#   Jedna kombinacja PVT/Vin: transient (+ AC przy -meas). Dziala w osobnym
#   podkatalogu $WORK/<tag>, wiec moze byc uruchamiana rownolegle.
#   Zmienne globalne uzywane: SIM_SPICE, DATA_DIR, WORK, LOG_DIR, LOG_PREFIX,
#   USE_MEAS, USE_DEBUG, TOTAL, DONE_DIR.
# -----------------------------------------------------------------------------
run_job() {
    local CORNER="$1" TEMP="$2" VP="$3" VIN="$4"
    local TAG="${CORNER}_T${TEMP}_Vp${VP}_Vin${VIN}"
    local DAT="$DATA_DIR/vco_${TAG}.dat"
    local ACDAT="$DATA_DIR/vco_${TAG}.acdat"
    local JOBDIR="$WORK/${LOG_PREFIX}${TAG}"
    mkdir -p "$JOBDIR"

    dbg "----------------------------------------------------------------"
    dbg "TAG=$TAG"
    dbg "CORNER=$CORNER TEMP=$TEMP VP=$VP VIN=$VIN"
    dbg "DAT=$DAT"
    dbg "USE_MEAS=$USE_MEAS  (ACDAT=$ACDAT jesli 1)"

    # Zbuduj netliste do symulacji (transient + opcjonalnie .ac dla C).
    # USE_MEAS decyduje czy dolaczyc analize .ac i zapis i(v1) przy 1 MHz.
    python3 - "$SIM_SPICE" "$CORNER" "$TEMP" "$VP" "$VIN" "$DAT" "$ACDAT" "$USE_MEAS" "$USE_DEBUG" "$JOBDIR" "$EN5_VAL" <<'PYEOF'
import re, sys
(spice_path, corner, temp, vp, vin, dat_path, acdat_path,
 use_meas, use_debug, jobdir, en5_val) = sys.argv[1:]
use_meas  = (use_meas  == '1')
use_debug = (use_debug == '1')

with open(spice_path) as f:
    spice = f.read()

# Usun oryginalny blok .control i nadpisz parametry PVT
spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice)
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice)
spice = re.sub(r'\.param\s+vin\s*=.*',  f'.param vin={vin}',   spice)

# Stan pinu en5 (zrodlo V3 en5 0 <wartosc>), jesli zadano sweep en5.
if en5_val != '':
    spice, k_en5 = re.subn(r'^([ \t]*V3[ \t]+en5[ \t]+0[ \t]+)\S+',
                           lambda m: m.group(1) + en5_val, spice,
                           flags=re.IGNORECASE | re.MULTILINE)
    if k_en5 == 0:
        sys.stderr.write('[-en5] UWAGA: nie znaleziono linii "V3 en5 0 <wartosc>" w netliscie\n')

# WAZNE: netlista ma '.save i(v1)', co powoduje ze ngspice zapisuje TYLKO
# i(v1) i odrzuca reszte wektorow (out, out_pb, i(v2)) -> "zero length" w
# transiencie. Usuwamy linie '.save ...' z netlisty; zamiast tego kazdy blok
# .control (tran / ac) sam deklaruje 'save' z potrzebnymi sygnalami.
spice = re.sub(r'^[ \t]*\.save\b[^\n]*\n', '', spice, flags=re.IGNORECASE | re.MULTILINE)

# Wstaw .options TEMP przed .end
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

# --- Gwarancja stymulacji AC na V1 ---
# Do analizy .ac zrodlo V1 MUSI miec magnitude 'ac 1'. Jesli netlista ma juz
# 'ac 1', zostawiamy. Jesli nie, dopisujemy. Robimy to na kopii dla wersji AC,
# zeby nie zaburzac transientu (magnitude ac nie wplywa na tran, ale kopia
# jest bezpieczniejsza).
def ensure_ac_on_v1(text):
    # dopasuj linie zrodla V1 (na poczatku linii, wielkosc liter dowolna)
    pat = re.compile(r'^(\s*V1\b[^\n]*)$', re.IGNORECASE | re.MULTILINE)
    m = pat.search(text)
    if not m:
        return text, 'NIE ZNALEZIONO V1'
    line = m.group(1)
    if re.search(r'\bac\b', line, re.IGNORECASE):
        return text, f'V1 juz ma ac: {line.strip()}'
    newline = line.rstrip() + ' ac 1'
    return text[:m.start(1)] + newline + text[m.end(1):], f'DOPISANO ac 1: {newline.strip()}'

spice_ac, ac_note = ensure_ac_on_v1(spice)

# Wezel pgt jest wewnatrz instancji x2 (vco_core_0), nazwa hierarchiczna
# v(x2.pgt). Uzywany tylko jako referencja/debug (v_osc bierzemy z v(out)).
#
# UWAGA (-ext / PEX): w netliscie post-layout wnetrze vco_core_0 jest
# zastapione ekstrakcja, przez co wezel 'pgt' NIE istnieje jako x2.pgt
# (ngspice zwraca "no such vector x2.pgt..."). Dlatego pgt jest OPCJONALNY:
# dodajemy go do save/wrdata tylko gdy w netliscie widac schematyczny rdzen
# (linia 'XM1 pgt in gnd' w .subckt vco_core_0). Gdy go nie ma (PEX),
# zapisujemy 6 kolumn zamiast 8, a plot_vco.py to obsluguje (v_pgt=None).
pgt_present = bool(re.search(r'^\s*XM1\s+pgt\s+in\s+gnd\b', spice,
                             re.IGNORECASE | re.MULTILINE))
pgt_save = ' v(x2.pgt)' if pgt_present else ''
pgt_wr   = ' v(x2.pgt)' if pgt_present else ''

if use_debug:
    sys.stderr.write(f"[DEBUG-PY] pgt_present={pgt_present} "
                     f"(v(x2.pgt) {'wlaczony' if pgt_present else 'POMINIETY'})\n")

# PRZYCZYNA ZERO-LENGTH (schematyczna): netlista zawiera '.save i(v1)'. Gdy
# ngspice widzi jawne '.save', zapisuje TYLKO wymienione wektory i odrzuca
# reszte. Naprawa: usuwamy '.save' z netlisty (wyzej), a tu jawnie 'save'
# potrzebne sygnaly.
#tran 200p 100u dluga
#tran 1p 20n krotka
tran_control = f"""
.control
save v(out_pb) v(out) i(v2){pgt_save}
tran 200p 100u
wrdata {dat_path} v(out_pb) v(out) i(v2){pgt_wr}
exit
.endc
"""

# AC (tylko -meas): jeden punkt przy 1 MHz.
# Zamiast polegac na real()/imag() jako argumentach wrdata (nieprzenosne),
# liczymy je jawnie do osobnych wektorow rzeczywistych, a potem zapisujemy.
# C = |Im(i(V1))| / (2*pi*f).
# 'set filetype=ascii' + 'print' daje tez czytelny slad w -debug.
ac_control = f"""
.control
save i(v1)
ac lin 1 1meg 1meg
let iac = i(v1)
let ire = real(iac)
let iim = imag(iac)
let imag_abs = abs(iim)
print iac
print ire
print iim
wrdata {acdat_path} ire iim
exit
.endc
"""

run_path = f'{jobdir}/run.spice'
ac_path  = f'{jobdir}/ac.spice'

with open(run_path, 'w') as f:
    f.write(spice + tran_control)

if use_meas:
    with open(ac_path, 'w') as f:
        f.write(spice_ac + ac_control)

if use_debug:
    sys.stderr.write(f"[DEBUG-PY] transient netlist -> {run_path}\n")
    if use_meas:
        sys.stderr.write(f"[DEBUG-PY] ac netlist        -> {ac_path}\n")
        sys.stderr.write(f"[DEBUG-PY] AC-source: {ac_note}\n")
        # pokaz faktyczna linie V1 w netliscie AC
        for ln in spice_ac.splitlines():
            if re.match(r'\s*V1\b', ln, re.IGNORECASE):
                sys.stderr.write(f"[DEBUG-PY] V1 w netliscie AC: {ln.strip()}\n")
                break
    # pokaz jak wygladaja bloki .control zeby latwo wychwycic literowki
    sys.stderr.write("[DEBUG-PY] tran .control:\n")
    for ln in tran_control.strip().splitlines():
        sys.stderr.write(f"[DEBUG-PY]   {ln}\n")
    if use_meas:
        sys.stderr.write("[DEBUG-PY] ac .control:\n")
        for ln in ac_control.strip().splitlines():
            sys.stderr.write(f"[DEBUG-PY]   {ln}\n")
PYEOF

    # Uruchom transient. Zawsze zapisujemy log, zeby moc pokazac blad
    # gdy plik .dat nie powstanie (nawet bez -debug).
    local TRAN_LOG="$LOG_DIR/vco_tran_${LOG_PREFIX}${TAG}.log"
    if [[ "$USE_DEBUG" -eq 1 ]]; then
        dbg "Uruchamiam ngspice (transient)..."
        ngspice -b "$JOBDIR/run.spice" 2>&1 | tee "$TRAN_LOG"
        dbg "ngspice transient zakonczony"
    else
        ngspice -b "$JOBDIR/run.spice" > "$TRAN_LOG" 2>&1
    fi

    # Sprawdz czy transient faktycznie zapisal plik .dat.
    if [[ ! -f "$DAT" ]]; then
        {
            echo "  [BLAD] ($TAG) Transient nie zapisal $DAT"
            echo "  [BLAD] Ostatnie linie logu ngspice ($TRAN_LOG):"
            grep -iE "error|warning|no such|not available|aborted" "$TRAN_LOG" | tail -8 | sed 's/^/         /'
            echo "  [BLAD] (pelny log: $TRAN_LOG)"
        }
    fi

    # Uruchom AC (tylko -meas) dla ekstrakcji C przy 1 MHz.
    if [[ "$USE_MEAS" -eq 1 ]]; then
        if [[ "$USE_DEBUG" -eq 1 ]]; then
            dbg "Uruchamiam ngspice (.ac 1 MHz)..."
            ngspice -b "$JOBDIR/ac.spice"
            dbg "ngspice ac zakonczony (exit=$?)"
            if [[ -f "$ACDAT" ]]; then
                dbg "ACDAT zawartosc ($ACDAT):"
                while IFS= read -r line; do dbg "  $line"; done < "$ACDAT"
            else
                dbg "UWAGA: brak pliku ACDAT ($ACDAT) - ekstrakcja C sie nie powiedzie"
            fi
        else
            ngspice -b "$JOBDIR/ac.spice" >/dev/null 2>&1
        fi
    fi

    rm -rf "$JOBDIR"

    # Licznik postepu wspolny dla rownoleglych zadan (plik znacznikowy na zadanie)
    : > "$DONE_DIR/${TAG}"
    local N_DONE PCT
    N_DONE=$(ls "$DONE_DIR" | wc -l)
    PCT=$(( N_DONE * 100 / TOTAL ))
    printf "%-45s done %3d%% of simulation finished\n" "${LOG_PREFIX}${TAG}" "${PCT}"
}

# -----------------------------------------------------------------------------
# run_batch - uruchamia caly sweep PVT x Vin dla biezacego SIM_SPICE,
#             maksymalnie $JOBS zadan naraz.
# -----------------------------------------------------------------------------
run_batch() {
    TOTAL=0
    for CORNER in $corners; do
    for TEMP in $FILTER_TEMPS; do
    for VP in $FILTER_VPS; do
    for VIN in $VIN_SWEEP; do
        TOTAL=$((TOTAL + 1))
    done; done; done; done

    DONE_DIR="$WORK/done_${LOG_PREFIX:-all}"
    rm -rf "$DONE_DIR"; mkdir -p "$DONE_DIR"

    for CORNER in $corners; do
    for TEMP in $FILTER_TEMPS; do
    for VP in $FILTER_VPS; do
    for VIN in $VIN_SWEEP; do
        # Limit liczby rownoleglych zadan
        while [[ $(jobs -rp | wc -l) -ge $JOBS ]]; do
            wait -n 2>/dev/null || true
        done
        run_job "$CORNER" "$TEMP" "$VP" "$VIN" &
    done; done; done; done
    wait
}

run_plots() {
    echo "Generating plots and report..."
    local PLOT_ARGS=""
    if [[ "$USE_MEAS"  -eq 1 ]]; then PLOT_ARGS="$PLOT_ARGS --meas";  fi
    if [[ "$USE_DEBUG" -eq 1 ]]; then PLOT_ARGS="$PLOT_ARGS --debug"; fi
    python3 "$SCRIPT_DIR/plot_vco.py" $PLOT_ARGS
}

# Czy rdzen N ma pin en5 (wg naglowka .subckt w ekstrakcji)
core_has_en5() {
    local pex="$EXTRACTION_DIR/${CORE_PREFIX}$1.pex.spice"
    grep -m1 -iE '^[[:space:]]*\.subckt' "$pex" 2>/dev/null | grep -qiw 'en5'
}

# Przenosi biezace wyniki do $RESULTS_DIR/<nazwa>/
archive_results() {
    local N="$1"
    local OUT="$RESULTS_DIR/${N}"
    rm -rf "$OUT"
    mkdir -p "$OUT/data"
    shopt -s nullglob
    local f
    for f in "$RESULTS_DIR"/vco_*.png "$RESULTS_DIR"/kvco_*.png \
             "$RESULTS_DIR"/rc_*.png "$RESULTS_DIR"/vco_report.html; do
        [[ -e "$f" ]] && mv "$f" "$OUT/"
    done
    for f in "$DATA_DIR"/vco_*.dat "$DATA_DIR"/vco_*.acdat; do
        mv "$f" "$OUT/data/"
    done
    shopt -u nullglob
    echo "Wyniki: $OUT"
}

# =============================================================================
# GLOWNA CZESC
# =============================================================================
LOG_PREFIX=""

if [[ "$USE_CORES" -eq 1 ]]; then
    if [[ ! -d "$EXTRACTION_DIR" ]]; then
        echo "Blad: katalog ekstrakcji nie istnieje: $EXTRACTION_DIR"
        exit 1
    fi
    mkdir -p "$RESULTS_DIR"

    CORES_OK=()
    CORES_FAILED=()

    for N in "${CORE_LIST[@]}"; do
        echo
        echo "============================================================"
        echo "  RDZEN ${CORE_PREFIX}${N}  (post-layout)"
        echo "============================================================"

        CORE_NETLIST="$RESULTS_DIR/vco_dcin_tb_core${N}.spice"
        EXT_SPICE="$RESULTS_DIR/vco_dcin_tb_ext_core${N}.spice"

        if ! make_core_netlist "$N" "$CORE_NETLIST"; then
            echo "Blad: nie udalo sie przygotowac netlisty dla rdzenia $N - pomijam."
            CORES_FAILED+=("$N"); continue
        fi
        if ! build_ext_netlist "$CORE_NETLIST" "$EXT_SPICE" "${CORE_PREFIX}${N}"; then
            echo "Blad: budowa netlisty post-layout dla rdzenia $N nie powiodla sie - pomijam."
            CORES_FAILED+=("$N"); continue
        fi

        SIM_SPICE="$EXT_SPICE"
        echo "Netlista uzyta do symulacji: $SIM_SPICE (post-layout / PEX)"
        print_params

        # Tryby en5: rdzen z pinem en5 -> wg EN5_SEL; bez pinu -> jeden przebieg.
        MODES=("")
        if core_has_en5 "$N"; then
            case "$EN5_SEL" in
                0) MODES=(0) ;;
                1) MODES=(1) ;;
                *) MODES=(0 1) ;;
            esac
        else
            echo "Rdzen $N nie ma pinu en5 - sweep en5 pominiety (jeden przebieg)."
        fi

        for M in "${MODES[@]}"; do
            if [[ -z "$M" ]]; then
                EN5_VAL=""; SUF=""; LOG_PREFIX="core${N}_"
            else
                if [[ "$M" == "1" ]]; then EN5_VAL="$EN5_HIGH"; else EN5_VAL="0"; fi
                SUF="_en5_${M}"; LOG_PREFIX="core${N}${SUF}_"
                echo "--- rdzen $N: en5 = $EN5_VAL ---"
            fi
            clean_results
            run_batch
            run_plots
            archive_results "core_${N}${SUF}"
        done
        CORES_OK+=("$N")
    done

    echo
    echo "Podsumowanie -cores: OK: ${CORES_OK[*]:-brak}  | BLAD: ${CORES_FAILED[*]:-brak}"
    [[ ${#CORES_FAILED[@]} -eq 0 ]] || exit 1
    exit 0
fi

# --- tryb standardowy (jeden rdzen, jak dotychczas) ---

# Budowa netlisty post-layout gdy podano -ext
if [[ "$USE_EXT" -eq 1 ]]; then
    if [[ ! -d "$EXTRACTION_DIR" ]]; then
        echo "Blad: katalog ekstrakcji nie istnieje: $EXTRACTION_DIR"
        exit 1
    fi
    EXT_SPICE="$RESULTS_DIR/vco_dcin_tb_ext.spice"
    echo "Tryb -ext: budowa netlisty post-layout z $EXTRACTION_DIR"
    mkdir -p "$RESULTS_DIR"

    if ! build_ext_netlist "$SPICE" "$EXT_SPICE" ""; then
        echo "Blad: budowa netlisty post-layout nie powiodla sie."
        exit 1
    fi
    SIM_SPICE="$EXT_SPICE"
    echo "Netlista post-layout zapisana: $EXT_SPICE"
fi

if [[ "$USE_EXT" -eq 1 ]]; then
    echo "Netlista uzyta do symulacji: $SIM_SPICE (post-layout / PEX)"
else
    echo "Netlista uzyta do symulacji: $SIM_SPICE (schematyczna)"
fi

print_params
if [[ -n "$EN5_SEL" ]]; then
    case "$EN5_SEL" in 0) MODES=(0) ;; 1) MODES=(1) ;; *) MODES=(0 1) ;; esac
    for M in "${MODES[@]}"; do
        if [[ "$M" == "1" ]]; then EN5_VAL="$EN5_HIGH"; else EN5_VAL="0"; fi
        LOG_PREFIX="en5_${M}_"
        echo "--- en5 = $EN5_VAL ---"
        clean_results
        run_batch
        run_plots
        archive_results "en5_${M}"
    done
else
    clean_results
    run_batch
    run_plots
fi
