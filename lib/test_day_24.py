from unittest import TestCase

from lib.day_24 import ALU, parse_input


class Test(TestCase):
    def test_ex_1(self):
        instructions = [
            "inp x",
            "mul x -1"
        ]
        alu = ALU("5", parse_input(instructions))
        alu.run()
        self.assertEqual(-5, alu.registers['x'])

    def test_ex_2_is_3x(self):
        instructions = [
            "inp z",
            "inp x",
            "mul z 3",
            "eql z x"
        ]
        alu = ALU("39", parse_input(instructions))
        alu.run()
        self.assertEqual(1, alu.registers['z'])

    def test_ex_2_is_not_3x(self):
        instructions = [
            "inp z",
            "inp x",
            "mul z 3",
            "eql z x"
        ]
        alu = ALU("38", parse_input(instructions))
        alu.run()
        self.assertEqual(0, alu.registers['z'])

    def test_ex_convert_to_binary(self):
        instructions = [
            "inp w",
            "add z w",
            "mod z 2",
            "div w 2",
            "add y w",
            "mod y 2",
            "div w 2",
            "add x w",
            "mod x 2",
            "div w 2",
            "mod w 2",
        ]
        alu = ALU("7", parse_input(instructions))
        alu.run()
        self.assertEqual(0, alu.registers['w'])
        self.assertEqual(1, alu.registers['x'])
        self.assertEqual(1, alu.registers['y'])
        self.assertEqual(1, alu.registers['z'])
