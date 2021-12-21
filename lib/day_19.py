from __future__ import annotations

import math
from collections import deque
from copy import deepcopy
from dataclasses import dataclass
from enum import Enum
from itertools import permutations, combinations
from typing import Union, List, Optional, Dict, Set, Tuple


@dataclass
class Scanner:
    name: str
    beacons: List[Point]


@dataclass(frozen=True)
class Point:
    x: int
    y: int
    z: int

    def __sub__(self, other):
        return Point(
            self.x - other.x,
            self.y - other.y,
            self.z - other.z
        )

    def __add__(self, other):
        return Point(
            self.x + other.x,
            self.y + other.y,
            self.z + other.z
        )


@dataclass
class Part1Result:
    beacons: Set[Point]
    scanner_details: Dict[str, Tuple[Scanner, Point]]


def read_input() -> List[List[str]]:
    with open("../input/day19.txt") as f:
        raw_input = f.read()

    return parse_raw_input(raw_input)


def parse_raw_input(raw_input: str) -> List[List[str]]:
    groups = []

    for group_lines in raw_input.split('\n\n'):
        lines = group_lines.split('\n')
        groups.append(lines)

    return groups


def parse_scanners(groups: List[List[str]]) -> List[Scanner]:
    scanners = []
    for group_lines in groups:
        name = group_lines[0]
        beacons = []
        for line in filter(lambda x: len(x) > 0, group_lines[1:]):
            xyz = line.split(',')
            beacons.append(Point(int(xyz[0]), int(xyz[1]), int(xyz[2])))
        scanners.append(Scanner(name, beacons))
    return scanners


def roll(p: Point) -> Point:
    return Point(p.x, p.z, -p.y)


def turn(p: Point) -> Point:
    return Point(-p.y, p.x, p.z)


def get_rotations(point: Point) -> List[Point]:
    local_point = deepcopy(point)
    rotated_points = []
    for _ in range(2):
        for _ in range(3):
            local_point = roll(local_point)
            rotated_points.append(local_point)
            for _ in range(3):
                local_point = turn(local_point)
                rotated_points.append(local_point)
        local_point = roll(turn(roll(local_point)))
    return rotated_points


def build_all_aliases_lookup(scanners: List[Scanner]) -> Dict[str, List[Scanner]]:
    lookup = {}
    for scanner in scanners:
        lookup[scanner.name] = [Scanner(scanner.name, []) for _ in range(24)]
        for beacon in scanner.beacons:
            for index, rotation in enumerate(get_rotations(beacon)):
                lookup[scanner.name][index].beacons.append(rotation)
    return lookup


def part1(scanners: List[Scanner], matches_required: int) -> Part1Result:
    lookup = build_all_aliases_lookup(scanners[1:])
    known_beacons: Set[Point] = set(scanners[0].beacons)
    remaining_scanners = deque(map(lambda x: x.name, scanners[1:]))
    located_scanners: Dict[str, Tuple[Scanner, Point]] = {scanners[0].name: (scanners[0], Point(0, 0, 0))}
    while len(remaining_scanners) > 0:
        count_remaining = len(remaining_scanners)
        print(f"{count_remaining} remaining to position")
        remaining_scanners.rotate(1)
        for scanner_rotation in lookup[remaining_scanners[0]]:
            for known_beacon in known_beacons:
                for beacon in scanner_rotation.beacons:
                    assumed_scanner_location = known_beacon - beacon
                    matched_beacons = 0
                    for test_beacon in scanner_rotation.beacons:
                        test_beacon_loc = assumed_scanner_location + test_beacon
                        if test_beacon_loc in known_beacons:
                            matched_beacons += 1
                    if matched_beacons >= matches_required:
                        located_scanners[scanner_rotation.name] = (
                            deepcopy(scanner_rotation),
                            assumed_scanner_location
                        )
                        remaining_scanners.popleft()
                        for located_beacon in scanner_rotation.beacons:
                            known_beacons.add(assumed_scanner_location + located_beacon)
                        break
                if count_remaining != len(remaining_scanners):
                    break
            if count_remaining != len(remaining_scanners):
                break
    return Part1Result(
        known_beacons,
        located_scanners
    )


def manhattan_distance(p1: Point, p2: Point) -> int:
    difference = p1 - p2
    return abs(difference.x) + abs(difference.y) + abs(difference.z)


def find_largest_distance_between_scanners(part1_result: Part1Result) -> int:
    scanner_locations = map(
        lambda x: x[1],
        part1_result.scanner_details.values()
    )
    return max(map(lambda x: manhattan_distance(x[0], x[1]), combinations(scanner_locations, 2)))


if __name__ == "__main__":
    part1_result = part1(parse_scanners(read_input()), 12)
    part1 = len(part1_result.beacons)
    print(f"Part 1: {part1}")
    part2 = find_largest_distance_between_scanners(part1_result)
    print(f"Part 2: {part2}")
