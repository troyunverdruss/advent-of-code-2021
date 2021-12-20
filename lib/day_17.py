import sys
from dataclasses import dataclass
from typing import Optional


@dataclass
class TargetDetails:
    x_min: int
    x_max: int
    y_min: int
    y_max: int

    def center(self):
        return (
            self.x_min + (self.x_max - self.x_min),
            self.y_min + (self.y_max - self.y_min)
        )


@dataclass
class SimulationResult:
    success: bool
    y_max: int
    short: bool
    long: bool


def read_input() -> str:
    with open("../input/day17.txt") as f:
        return f.readlines()[0]


def parse_input(line) -> TargetDetails:
    [_, _, x, y] = line.replace(",", "").split(" ")
    [_, x_min, x_max] = x.replace("=", " ").replace("..", " ").split(" ")
    [_, y_min, y_max] = y.replace("=", " ").replace("..", " ").split(" ")

    return TargetDetails(int(x_min), int(x_max), int(y_min), int(y_max))


def simulate(init_x_vel: int, init_y_vel: int, target: TargetDetails) -> SimulationResult:
    success = False
    y_max = -sys.maxsize
    x_loc = 0
    y_loc = 0
    x_vel = init_x_vel
    y_vel = init_y_vel

    while True:
        if x_loc > target.x_max or y_loc < target.y_min:
            break
        if target.x_min <= x_loc <= target.x_max and target.y_min <= y_loc <= target.y_max:
            success = True
            break

        x_loc = x_loc + x_vel
        y_loc = y_loc + y_vel

        if y_loc > y_max:
            y_max = y_loc

        if x_vel > 0:
            x_vel = x_vel - 1
        y_vel = y_vel - 1

    return SimulationResult(
        success,
        y_max,
        x_loc < target.x_min,
        x_loc > target.x_max
    )


def search(target: TargetDetails):
    best_result: Optional[SimulationResult] = None

    successful_results = 0
    for y_vel in range(target.y_min, 100):
        for x_vel in range(0, 500):
            result = simulate(x_vel, y_vel, target)
            if result.success:
                successful_results += 1
                if best_result is None or result.y_max > best_result.y_max:
                    best_result = result
                    # print("best", best_result)
    return (successful_results, best_result.y_max)


def run():
    target_details = parse_input(read_input())
    (successful, best_y) = search(target_details)
    print(f"Part 1: {best_y}")
    print(f"Part 2: {successful}")


if __name__ == "__main__":
    run()
