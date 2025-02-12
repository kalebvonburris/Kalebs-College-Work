def problem_e():
    sum = 0
    for i in range(50):
        # (i + 1) as range() starts 
        # from 0 not 1.
        sum += (0.3 * (i + 1)) + 1

    print(sum)

def problem_f():
    sum = 0
    for i in range(50 - 7):
        # (i + 7) as range() starts 
        # from 0 not 7.
        sum += (0.3 * (i + 7)) + 1

    print(sum)

problem_g():
sum = 0
for i in range(50 - 7):
    # (i + 7) as range() starts 
    # from 0 not 7.
    sum += (0.3 * (i + 7)) + 1

problem_f()