from __future__ import annotations

from collections import deque
from copy import deepcopy
from dataclasses import dataclass
from enum import Enum
from random import random, randrange
from typing import List, Union, Optional
from itertools import product

from lib.day_24_converted_to_python import day_24_py


class ALU:
    def __init__(self, model_number: str, instructions: List[Instruction]):
        self.model_number = deque(map(lambda x: int(x), list(model_number)))
        self.instructions = deepcopy(instructions)
        self.pointer = 0
        self.debug = False
        self.registers = {
            'w': 0,
            'x': 0,
            'y': 0,
            'z': 0,
        }

    def run(self):
        while self.pointer < len(self.instructions):
            self.step()
            self.pointer += 1
        if self.debug:
            print(f"{self.pointer}  ||  < END >  ||  {self.registers}")

    def valid_model_number(self) -> bool:
        if self.pointer == 0:
            raise Exception("Did you forget to run()?")
        return self.registers['z'] == 0

    def step(self):
        instruction = self.instructions[self.pointer]
        if self.debug:
            if instruction.op == Op.INP:
                print()
            print(f"{self.pointer}  ||  {instruction}  ||  {self.registers}")
        if instruction.op == Op.INP:
            if len(self.model_number) == 0:
                raise Exception("Model numbers exhaused already")
            self.registers[instruction.a] = self.model_number.popleft()
        elif instruction.op == Op.ADD:
            a = self.get_value(instruction.a)
            b = self.get_value(instruction.b)
            self.assert_register(instruction.a)
            self.registers[instruction.a] = a + b
        elif instruction.op == Op.MUL:
            a = self.get_value(instruction.a)
            b = self.get_value(instruction.b)
            self.assert_register(instruction.a)
            self.registers[instruction.a] = a * b
        elif instruction.op == Op.DIV:
            a = self.get_value(instruction.a)
            b = self.get_value(instruction.b)
            self.assert_register(instruction.a)
            if b == 0:
                raise Exception("Can't divide by 0")
            self.registers[instruction.a] = a // b
        elif instruction.op == Op.MOD:
            a = self.get_value(instruction.a)
            b = self.get_value(instruction.b)
            self.assert_register(instruction.a)
            if a < 0:
                raise Exception("Can't mod with a < 0")
            if b <= 0:
                raise Exception(f"Can't mod by b <= 0: #{b}")
            self.registers[instruction.a] = a % b
        elif instruction.op == Op.EQL:
            a = self.get_value(instruction.a)
            b = self.get_value(instruction.b)
            self.assert_register(instruction.a)
            if a == b:
                self.registers[instruction.a] = 1
            else:
                self.registers[instruction.a] = 0

    def get_value(self, arg: Union[str, int]) -> int:
        if arg in ['w', 'x', 'y', 'z']:
            return self.registers[arg]
        return int(arg)

    def assert_register(self, arg: str) -> None:
        if arg not in ['w', 'x', 'y', 'z']:
            raise Exception(f"Expected register, got #{arg}")


def parse(s: str) -> Op:
    if s == 'inp':
        return Op.INP
    if s == 'add':
        return Op.ADD
    if s == 'mul':
        return Op.MUL
    if s == 'div':
        return Op.DIV
    if s == 'mod':
        return Op.MOD
    if s == 'eql':
        return Op.EQL


class Op(Enum):
    INP = 1
    ADD = 2
    MUL = 3
    DIV = 4
    MOD = 5
    EQL = 6


@dataclass
class Instruction:
    op: Op
    a: Union[str, int]
    b: Optional[Union[str, int]]


def read_input() -> List[str]:
    with open("input/day24.txt") as f:
        return f.readlines()


def parse_input(input_lines: List[str]) -> List[Instruction]:
    instructions = []
    for line in input_lines:
        parts = line.strip().split(" ")
        if len(parts) == 2:
            b = None
        else:
            b = parts[2]
        instructions.append(
            Instruction(
                parse(parts[0]),
                parts[1],
                b
            )
        )
    return instructions


@dataclass(frozen=True)
class regYZ:
    y: int
    z: int


def run():
    instructions = parse_input(read_input())
    # a = 1
    # b = 2
    # c = 3
    # d = 4
    # # e = 5
    products = product(
        range(1, 10),  # a
        range(1, 10),  # b
        range(1, 10),  # c
        range(1, 10),  # d
    )
    eqOrNot = {True: 0, False: 0}
    distinctStates = set()
    test_number = '12996997829399'
    for prod in products:
        (a, b, c, d) = prod
        alu = ALU(
            # f"{a}{b}{c}{d}",
            test_number,
            instructions
        )
        # alu.debug = True
        alu.run()
        # py_registers = day_24_py(f"{a}{b}{c}{d}")
        py_registers = day_24_py(test_number)
        assert alu.registers == py_registers
        print(py_registers)
        break
        # print(f"{i}: {alu.registers}")
        # assert alu.registers['w'] == d
        # assert alu.registers['x'] == 1
        # assert alu.registers['y'] == d + 2
        # assert alu.registers['z'] == 26 * (26 * (26 * (a + 12) + b + 7) + c + 1) + d + 2

        # distinctStates.add(
        #     regYZ(
        #         (d + 2),
        #         ((26 * (26 * (26 * (a + 12) + b + 7) + c + 1) + d + 2) // 26)
        #     )
        # )
        # if (26 * (26 * (26 * (a + 12) + b + 7) + c + 1) + d + 2) // 26 == ((
        #         26 * (26 * (26 * (a + 12) + b + 7) + c + 1)) // 26) + ((d + 2) // 26):
        #     eqOrNot[True] += 1
        # else:
        #     eqOrNot[False] += 1
        # distinctStates.add(str(sorted(alu.registers.items())))
        # print(f"{alu.registers['z']} % 26 => {alu.registers['z'] % 26}")
    # print(eqOrNot)
    # print(f'distinct states: {len(distinctStates)}')
    x = 0


def find_valid_model_numbers_sequentially():
    instructions = parse_input(read_input())
    maybe_model_number = "1" * 14
    while True:
        alu = ALU(
            maybe_model_number,
            instructions
        )
        alu.run()
        if alu.registers['z'] == 0:
            print(f"Valid model number: {maybe_model_number}")
        maybe_model_number_int = int(maybe_model_number)
        while True:
            maybe_model_number_int += 1
            if "0" not in str(maybe_model_number_int) and sum(map(int, list(str(maybe_model_number_int)))) == 26:
                maybe_model_number = str(maybe_model_number_int)
                break


def find_valid_model_numbers_random():
    instructions = parse_input(read_input())
    maybe_model_number = "1" * 14
    while True:
        alu = ALU(
            maybe_model_number,
            instructions
        )
        alu.run()
        if alu.registers['z'] == 0:
            print(f"Valid model number: {maybe_model_number}")
        maybe_model_number_int = int(maybe_model_number)
        while True:
            maybe_model_number_int = "58111111111111"
            if "0" not in str(maybe_model_number_int):
                maybe_model_number = str(maybe_model_number_int)
                break


def gen_random_14_digit_number():
    s = ""
    while len(s) < 14:
        s += str(randrange(1, 10))
    return s

# def gen_14_digit_number_with_digits_summing_26():



if __name__ == '__main__':
    # find_valid_model_numbers_sequentially()
    run()
