import numpy as np
import glob
import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(SCRIPT_DIR, '../results/data')

for f in glob.glob(os.path.join(DATA_DIR, 'cp_parsed_*.txt')):
    os.remove(f)

files = glob.glob(os.path.join(DATA_DIR, 'charge_pump_data_*.txt'))

if not files:
    print("Brak plików charge_pump_data_*.txt w", DATA_DIR)
    exit(1)

for filepath in files:
    tag = os.path.basename(filepath).replace('charge_pump_data_', '').replace('.txt', '')
    print(f"Parsuję: {tag}")

    data = np.loadtxt(filepath)
    if data.ndim == 1:
        data = data.reshape(1, -1)
    ncol = data.shape[1]

    # time zawsze w kolumnie 0
    time = data[:, 0]

    if ncol == 5:
        # oczekiwana struktura: time, vout, i_viup, i_vidn, biasn
        vout = data[:, 1]
        i_viup = data[:, 2]
        i_vidn = data[:, 3]
        biasn = data[:, 4]
    elif ncol == 10:
        # Przybliżona struktura ze starej wersji:
        # zakładamy, że kolumny to: time, vout, i_vip, i_vin, v_bias_p, v_bias_n, i_vdn2, i_vup2, i_vvp, v_up, v_dn? (to 11)
        # Ale mamy 10 kolumn – więc brak jednej. Trudno.
        # Dla bezpieczeństwa: vout = kol 1, biasn = kol 5 (v_bias_n), a prądy – brak -> ustawiamy 0
        print(f"  Ostrzeżenie: plik {tag} ma 10 kolumn – brak pomiarów prądów Viup/Vidn. Ustawiam je na 0.")
        vout = data[:, 1]
        biasn = data[:, 5] if data.shape[1] > 5 else data[:, -1]
        i_viup = np.zeros_like(time)
        i_vidn = np.zeros_like(time)
    else:
        print(f"  Nieobsługiwana liczba kolumn: {ncol}. Pomijam.")
        continue

    out_array = np.column_stack((time, vout, biasn, i_viup, i_vidn))
    out_path = os.path.join(DATA_DIR, f'cp_parsed_{tag}.txt')
    header = "time vout biasn i_viup i_vidn"
    np.savetxt(out_path, out_array, header=header, comments='')
    print(f"  Zapisano: {out_path}")

print("Done.")
