import numpy as np
import glob
import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(SCRIPT_DIR, '../results/data')

# Usuń stare pliki parsed
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

    # Oczekujemy 5 kolumn
    if data.shape[1] != 5:
        print(f"  Ostrzeżenie: plik {tag} ma {data.shape[1]} kolumn, oczekiwano 5. Pomijam.")
        continue

    time = data[:, 0]
    vout = data[:, 1]
    i_viup = data[:, 2]    # prąd w amperach
    i_vidn = data[:, 3]    # prąd w amperach
    biasn = data[:, 4]

    out_array = np.column_stack((time, vout, biasn, i_viup, i_vidn))
    out_path = os.path.join(DATA_DIR, f'cp_parsed_{tag}.txt')
    header = "time vout biasn i_viup i_vidn"
    np.savetxt(out_path, out_array, header=header, comments='')
    print(f"  Zapisano: {out_path}")

print("Done.")
