def registers(w, x, y, z):
    return {
        'w': w,
        'x': x,
        'y': y,
        'z': z,
    }


def day_24_py(model_number: str, w=0, x=0, y=0, z=0):
    input_digits = list(map(int, list(model_number)))
    (a, b, c, d, e, f, g, h, i, j, k, l, m, n) = input_digits
    loop_count = 0
    for input_digit in input_digits:
        print(f"start: {loop_count}: {registers(w, x, y, z)}")
        w = input_digit
        x = z % 26
        print(f"  z%26:  {x}")

        x_modifier_list = [14, 15, 12, 11, -5, 14, 15, -13, -16, -8, 15, -8, 0, -4]
        y_modifier_list = [12, 7, 1, 2, 4, 15, 11, 5, 3, 9, 2, 3, 3, 11]
        x_modifier = x_modifier_list[loop_count]
        y_modifier = y_modifier_list[loop_count]

        if loop_count in [4, 7, 8, 9, 11, 12, 13]:
            z = z // 26
            # print(f"input digits needs to be [w - x == 0] [{w} - {x} == {x+y_modifier_list[loop_count-1]}]")
            print(
                f"{loop_count}th input digit needs to be (last input) - {x_modifier + y_modifier_list[loop_count - 1]}")

        x += x_modifier

        if loop_count == 9:
            yyyyy = 9

        if x == w:
            x = 0
            y = 0
        else:
            x = 1
            y = 26
            z = z * y
            y = w
            y += y_modifier
            z = z + y

        print(f"  input: {input_digit}")
        print(f"  x_mod: {x_modifier}")
        print(f"  y_mod: {y_modifier}")
        print(f"end: {loop_count}: {registers(w, x, y, z)}")

        loop_count += 1
        last_input_digit = input_digit
        last_y_modifier = y_modifier
    return registers(w, x, y, z)


if __name__ == '__main__':
    a = 1
    b = 1
    c = 8
    d = 4
    e = d + 2 - 5
    f = 2
    g = 3
    h = g + 11 - 13
    i = f + 15 - 16
    j = c + 1 - 8
    k = 7
    l = k + 2 - 8
    m = b + 7
    n = a + 12 - 4
    result_registers = day_24_py(f"{a}{b}{c}{d}{e}{f}{g}{h}{i}{j}{k}{l}{m}{n}")
    num = f"{a}{b}{c}{d}{e}{f}{g}{h}{i}{j}{k}{l}{m}{n}"
    yyyyy = 9

    # maybe:
    # '11952342228289' (works)
    # '12996997829399' (works max)
    # '11841231117189' (works min)
