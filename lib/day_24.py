from __future__ import annotations

from collections import deque
from copy import deepcopy
from dataclasses import dataclass
from enum import Enum
from typing import List, Union, Optional


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

    def valid_model_number(self) -> bool:
        if self.pointer == 0:
            raise Exception("Did you forget to run()?")
        return self.registers['z'] == 0

    def step(self):
        instruction = self.instructions[self.pointer]
        if self.debug:
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


def run():
    instructions = parse_input(read_input())
    for i in range(1,10):
        alu = ALU(
            f"{i}",
            instructions[0:18]
        )
        # alu.debug = True
        alu.run()
        print(f"{i}: {alu.registers}")
    x = 0


if __name__ == '__main__':
    run()
