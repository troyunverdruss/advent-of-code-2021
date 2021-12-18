from unittest import TestCase

from lib.day_17 import parse_input, simulate, search


class Test(TestCase):
    def test_simulate_part_1_example_1_success(self):
        target = parse_input("target area: x=20..30, y=-10..-5")
        result = simulate(7, 2, target)
        self.assertEqual(True, result.success)

    def test_simulate_part_1_example_2_success(self):
        target = parse_input("target area: x=20..30, y=-10..-5")
        result = simulate(6, 3, target)
        self.assertEqual(True, result.success)

    def test_simulate_part_1_example_3_success(self):
        target = parse_input("target area: x=20..30, y=-10..-5")
        result = simulate(9, 0, target)
        self.assertEqual(True, result.success)

    def test_simulate_part_1_example_4_misses(self):
        target = parse_input("target area: x=20..30, y=-10..-5")
        result = simulate(17, -4, target)
        self.assertEqual(False, result.success)

    def test_search_part_1(self):
        target = parse_input("target area: x=20..30, y=-10..-5")
        (successful, best_y) = search(target)
        self.assertEqual(45, best_y)

    def test_search_all_part_2(self):
        target = parse_input("target area: x=20..30, y=-10..-5")
        (successful, best_y) = search(target)
        self.assertEqual(112, successful)

