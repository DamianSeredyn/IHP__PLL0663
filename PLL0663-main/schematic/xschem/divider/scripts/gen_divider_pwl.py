fin = 320e6
unit = 10/fin      # 31.25 ns

t = 0.0

pwl = [[] for _ in range(6)]

state = 1

for bit in range(6):
    pwl[bit].append((0.0, (state >> bit) & 1))

for n in range(1, 64):
    hold = unit * n
    tnext = t + hold

    old = n
    new = 1 if n == 63 else n + 1

    for bit in range(6):
        bo = (old >> bit) & 1
        bn = (new >> bit) & 1

        if bo != bn:
            pwl[bit].append((tnext, bo))
            pwl[bit].append((tnext + 1e-12, bn))

    t = tnext

for bit in range(6):
    print(f"Vd{bit} D{bit} 0 PWL(", end="")
    first = True
    for tt, vv in pwl[bit]:
        if not first:
            print(" ", end="")
        print(f"{tt:.12e} {vv}", end="")
        first = False
    print(")")