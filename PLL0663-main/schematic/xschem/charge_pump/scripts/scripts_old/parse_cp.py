import numpy as np
import os
import glob

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, "../.."))
DATA_DIR = os.path.join(PROJECT_DIR, "charge_pump/results/data")

for f in glob.glob(os.path.join(DATA_DIR, 'cp_parsed_*.txt')):
    os.remove(f)
print("Usunieto stare pliki.")

files = glob.glob(os.path.join(DATA_DIR, "charge_pump_data_*.txt"))

for filepath in files:
    tag = os.path.basename(filepath).replace("charge_pump_data_", "").replace(".txt", "")

    data = np.loadtxt(filepath)
    ncols = data.shape[1]

    time     = data[:, 0]
    vout     = data[:, 3]
    i_vip    = data[:, 5]
    i_vin    = data[:, 7]
    v_bias_p = data[:, 9]
    v_bias_n = data[:, 11]

    # Nowe kolumny -- czytane tylko jesli plik ma wystarczajaca liczbe kolumn
    # Zakladany wzorzec indeksow (co druga kolumna, jak powyzej):
    #   i(Vdn2) -> 13, i(Vup2) -> 15, i(Vvp) -> 17, v(up) -> 19, v(dn) -> 21
    cols      = [time, vout, i_vip, i_vin, v_bias_p, v_bias_n]
    header    = "time vout i_vip i_vin v_bias_p v_bias_n"

    new_signals = [
        (13, "i_vdn2"),
        (15, "i_vup2"),
        (17, "i_vvp"),
        (19, "v_up"),
        (21, "v_dn"),
    ]

    for idx, name in new_signals:
        if ncols > idx:
            cols.append(data[:, idx])
            header += f" {name}"
        else:
            print(f"  [WARN] {tag}: brak kolumny {idx} ({name}), plik ma tylko {ncols} kolumn")

    out = np.column_stack(cols)
    out_path = os.path.join(DATA_DIR, f"cp_parsed_{tag}.txt")
    np.savetxt(out_path, out, header=header, comments="")

    print(f"Parsed: {tag}  ({ncols} kol. wejsciowych -> {len(cols)} kol. wyjsciowych)")

print("Done.")