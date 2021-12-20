from __future__ import annotations

import math
from copy import deepcopy
from dataclasses import dataclass
from enum import Enum
from itertools import permutations
from typing import Union, List, Optional


class Side(Enum):
    LEFT = 1
    RIGHT = 2


@dataclass
class Node:
    parent: Optional[Node]
    on_left: Optional[bool]
    left: Optional[Union[int, Node]]
    right: Optional[Union[int, Node]]

    def __str__(self):
        return node_to_string(self)


def node_to_string(node):
    if type(node.left) == int:
        left = str(node.left)
    else:
        left = node_to_string(node.left)
    if type(node.right) == int:
        right = str(node.right)
    else:
        right = node_to_string(node.right)
    return "[" + ",".join([left, right]) + "]"


def read_input() -> List[Node]:
    pairs = []
    with open("../input/day18.txt") as f:
        for line in f.readlines():
            pairs.append(parse_pairs(eval(line), None, False))

    return pairs


def parse_pairs(line, parent, on_left) -> Node:
    pair = Node(parent, on_left, None, None)
    [a, b] = line

    if type(a) == int:
        pair.left = a
    else:
        pair.left = parse_pairs(a, pair, True)
    if type(b) == int:
        pair.right = b
    else:
        pair.right = parse_pairs(b, pair, False)
    return pair


def find_pair_to_explode(pair, depth) -> Optional[Union[Node, bool]]:
    # print(f"{depth}: {pair}")
    if depth > 4:
        raise Error("Should not be this deep")
    if depth == 4:
        if type(pair.left) == Node:
            return pair.left
        if type(pair.right) == Node:
            return pair.right
        return None
    else:
        if type(pair.left) == Node:
            left = find_pair_to_explode(pair.left, depth + 1)
            if left is not None:
                return left
        if type(pair.right) == Node:
            right = find_pair_to_explode(pair.right, depth + 1)
            if right is not None:
                return right
        return None


def update_closest_neighbor_left(pair, value) -> bool:
    parent = pair.parent
    if parent is None:
        return False
    if parent.left != pair:
        if type(parent.left) == int:
            parent.left += value
            return True
        else:
            next = parent.left
            current_parent = parent
            while type(next) != int:
                current_parent = next
                next = next.right
            current_parent.right += value
    else:
        if parent.parent is None:
            return False
        find_parent = True
        while find_parent:
            if parent.parent is None:
                return False
            if parent.parent.left != parent:
                find_parent = False
            parent = parent.parent

        if type(parent.left) == int:
            parent.left += value
            return True
        else:
            next = parent.left
            current_parent = parent
            while type(next) != int:
                current_parent = next
                next = next.right
            current_parent.right += value


def update_closest_neighbor_right(pair, value) -> bool:
    parent = pair.parent
    if parent is None:
        return False
    if parent.right != pair:
        if type(parent.right) == int:
            parent.right += value
            return True
        else:
            next = parent.right
            current_parent = parent
            while type(next) != int:
                current_parent = next
                next = next.left
            current_parent.left += value
    else:
        if parent.parent is None:
            return False
        find_parent = True
        while find_parent:
            if parent.parent is None:
                return False
            if parent.parent.right != parent:
                find_parent = False
            parent = parent.parent

        if type(parent.right) == int:
            parent.right += value
            return True
        else:
            next = parent.right
            current_parent = parent
            while type(next) != int:
                current_parent = next
                next = next.left
            current_parent.left += value


def find_pair_to_split(pair) -> bool:
    if type(pair.left) == int and pair.left >= 10:
        new_pair = split_number(pair.left)
        new_pair.on_left = True
        new_pair.parent = pair
        pair.left = new_pair
        return True
    elif type(pair.left) == int:
        pass
    else:
        left = find_pair_to_split(pair.left)
        if left:
            # somewhere down there we split something
            return left
    if type(pair.right) == int and pair.right >= 10:
        new_pair = split_number(pair.right)
        new_pair.on_left = False
        new_pair.parent = pair
        pair.right = new_pair
        return True
    elif type(pair.right) == int:
        pass
    else:
        right = find_pair_to_split(pair.right)
        if right:
            # somewhere down there we split something
            return right
    return False


def split_number(num: int) -> Node:
    a = math.floor(num / 2)
    b = math.ceil(num / 2)
    return Node(None, None, a, b)


def reduce_pair(pair):
    keep_reducing = True
    while keep_reducing:
        pair_to_explode = find_pair_to_explode(pair, 1)
        if pair_to_explode is not None:
            update_closest_neighbor_left(pair_to_explode, pair_to_explode.left)
            update_closest_neighbor_right(pair_to_explode, pair_to_explode.right)
            if pair_to_explode.on_left:
                pair_to_explode.parent.left = 0
            else:
                pair_to_explode.parent.right = 0
            continue
        split = find_pair_to_split(pair)
        if split:
            continue

        keep_reducing = False
    return pair


def sum_pairs(pair1, pair2) -> Node:
    new_root = Node(None, None, pair1, pair2)
    new_root.left.on_left = True
    new_root.right.on_left = False
    new_root.left.parent = new_root
    new_root.right.parent = new_root
    reduce_pair(new_root)
    return new_root


def magnitude(pair) -> int:
    left = 0
    right = 0
    if type(pair.left) == int:
        left += pair.left
    else:
        left += magnitude(pair.left)
    if type(pair.right) == int:
        right += pair.right
    else:
        right += magnitude(pair.right)
    return (left * 3) + (right * 2)


def sum_list_of_pairs(pairs):
    sum_result = reduce_pair(pairs[0])
    for pair in pairs[1:]:
        # print(sum_result)
        sum_result = sum_pairs(sum_result, pair)
    # print(sum_result)
    return sum_result


def do_homework(pairs):
    # print(len(pairs))
    sum_result = sum_list_of_pairs(pairs)

    final_magnitude = magnitude(sum_result)
    # print(final_magnitude)
    return final_magnitude


def find_largest_mag(pairs):
    largest_mag = 0
    for pair_of_pairs in permutations(pairs, 2):
        copy = deepcopy(pair_of_pairs)
        mag = do_homework(copy)
        if mag > largest_mag:
            largest_mag = mag
    return largest_mag


if __name__ == "__main__":
    part1 = do_homework(read_input())
    print(f"Part 1: {part1}")
    part2 = find_largest_mag(read_input())
    print(f"Part 2: {part2}")
