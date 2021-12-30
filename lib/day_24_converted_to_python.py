def day_24_py(model_number: str, w=0, x=0, y=0, z=0):
    input_digits = list(map(int, list(model_number)))
    loop_count = 0
    for input_digit in input_digits:
        w = input_digit
        x = z % 26
        if loop_count in [4, 7, 8, 9, 11, 12, 13]:
            z = z // 26

        x += [14, 15, 12, 11, -5, 14, 15, -13, -16, -8, 15, -8, 0, -4][loop_count]

        if x == w:
            x = 0
            y = 0
        else:
            x = 1
            y = 26
            z = z * y
            y = w
            y += [12, 7, 1, 2, 4, 15, 11, 5, 3, 9, 2, 3, 3, 11][loop_count]
            z = z + y

        registers = {
            'w': w,
            'x': x,
            'y': y,
            'z': z,
        }
        # print(f"{loop_count}: {registers}")
        loop_count += 1
    return registers


if __name__ == '__main__':
    day_24_py("1")
