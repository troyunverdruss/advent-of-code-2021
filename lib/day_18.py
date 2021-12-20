import sys
from dataclasses import dataclass
from typing import Optional, Union
import __future__

@dataclass
class Node:
    parent: int
    on_left: bool
    left: int
    right: int


def read_input() -> str:
    pairs = []
    with open("../input/day18.txt") as f:
        for line in f.readlines():
            pairs.append(parse_pairs(eval(line), None, False))
            x = 8
    
    return pairs 
        
def parse_pairs(line, parent, on_left) -> Node:
    pair = Node(parent, on_left, None, None)
    [a,b] = line

    if type(a) == int:
        pair.left = a
    else:
        pair.left = parse_pairs(a, pair, True)
    if type(b) == int:
        pair.right = b
    else: 
        pair.right = parse_pairs(b, pair, True)
    return pair

def find_pair_to_explode(pair, depth) -> Node:
    if depth > 5:
        raise Error("Should not be this deep")
    if depth == 5:
        if type(pair.left) == Node:
            return pair
        if type(pair.right) == Node:
            return pair 
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
            parent.left = parent.left + value
            return True
        else:
            next = parent.left
            while type(next) != int:
                next = next.right
            next.right = next.right + value           
    else:
        if parent.parent is None:
            return False
        while parent.parent.right != parent:
            if parent.parent is None:
                return False
            parent = parent.parent
            
        if type(parent.left) == int:
            parent.left += value
            return True
        else:
            next = parent.left
            while type(next) != int:
                next = next.right
            next.right += value
            

def update_closest_neighbor_right(pair) -> bool:
    parent = pair.parent
    if parent is None:
        return False
    if parent.right != pair:
        if type(parent.right) == int:
            parent.right += value
            return True
        else:
            next = parent.right
            while type(next) != int:
                next = next.left
            next.left += value           
    else:
        if parent.parent is None:
            return False
        while parent.parent.left != parent:
            if parent.parent is None:
                return False
            parent = parent.parent
            
        if type(parent.right) == int:
            parent.right += value
            return True
        else:
            next = parent.right
            while type(next) != int:
                next = next.left
            next.left += value
    
def find_pair_to_split(pair) -> bool:
    if type(pair.left) == int and pair.left >= 10:
        new_pair = split_number(pair.left)
        new_pair.on_left = True
        new_pair.parent = pair
        pair.left = new_pair
        return True
    elif type(pair.left) == int:
        return False
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
        return False
    else:
        right = find_pair_to_split(pair.right)
        if right:
            # somewhere down there we split something
            return right
    return False

    
def split_number(num: int) -> Node:
    a = math.floor(num/2)
    b = math.ceil(num/2)
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
        

def run():
    pairs = read_input()
    print(len(pairs))
    sum = reduce_pair(pairs[0])
    for pair in pairs[1:]:
        sum = sum_pairs(sum, pair)
        
    final_magnitude = magnitude(sum)
    print(final_magnitude)
        
    
#    (successful, best_y) = search(target_details)
#    print(f"Part 1: {best_y}")
#    print(f"Part 2: {successful}")


if __name__ == "__main__":
    run()
