from unittest import TestCase

# from lib.day_17 import parse_input, simulate, search
from lib.day_18 import parse_pairs, sum_pairs, reduce_pair, sum_list_of_pairs, magnitude, do_homework, find_largest_mag


class Test(TestCase):
    def test_basic_addition(self):
        p1 = parse_pairs(eval("[1,2]"), None, False)
        p2 = parse_pairs(eval("[[3,4],5]"), None, False)
        print(p1)
        print(p2)
        s = sum_pairs(p1, p2)
        reduced = reduce_pair(s)
        self.assertEqual(s, reduced)

    def test_explode_1(self):
        start = parse_pairs(eval("[[[[[9,8],1],2],3],4]"), None, False)
        result = reduce_pair(start)
        self.assertEqual(str(result), "[[[[0,9],2],3],4]")

    def test_explode_2(self):
        start = parse_pairs(eval("[7,[6,[5,[4,[3,2]]]]]"), None, False)
        result = reduce_pair(start)
        self.assertEqual(str(result), "[7,[6,[5,[7,0]]]]")

    def test_explode_3(self):
        start = parse_pairs(eval("[[6,[5,[4,[3,2]]]],1]"), None, False)
        result = reduce_pair(start)
        self.assertEqual(str(result), "[[6,[5,[7,0]]],3]")

    def test_explode_4(self):
        start = parse_pairs(eval("[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]"), None, False)
        result = reduce_pair(start)
        self.assertEqual(str(result), "[[3,[2,[8,0]]],[9,[5,[7,0]]]]")

    def test_basic_split_even(self):
        start = parse_pairs(eval("[1,10]"), None, False)
        result = reduce_pair(start)
        self.assertEqual(str(result), "[1,[5,5]]")

    def test_basic_split_odd(self):
        start = parse_pairs(eval("[1,11]"), None, False)
        result = reduce_pair(start)
        self.assertEqual(str(result), "[1,[5,6]]")

    def test_sum_pairs(self):
        p1 = parse_pairs(eval("[[[[4,3],4],4],[7,[[8,4],9]]]"), None, False)
        p2 = parse_pairs(eval("[1,1]"), None, False)
        sum_result = sum_pairs(p1, p2)
        self.assertEqual(str(sum_result), "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")

    def test_sum_list_1(self):
        pairs = [
            parse_pairs(eval("[1,1]"), None, False),
            parse_pairs(eval("[2,2]"), None, False),
            parse_pairs(eval("[3,3]"), None, False),
            parse_pairs(eval("[4,4]"), None, False),
        ]
        result = sum_list_of_pairs(pairs)
        self.assertEqual("[[[[1,1],[2,2]],[3,3]],[4,4]]", str(result))

    def test_sum_list_2(self):
        pairs = [
            parse_pairs(eval("[1,1]"), None, False),
            parse_pairs(eval("[2,2]"), None, False),
            parse_pairs(eval("[3,3]"), None, False),
            parse_pairs(eval("[4,4]"), None, False),
            parse_pairs(eval("[5,5]"), None, False),
        ]
        result = sum_list_of_pairs(pairs)
        self.assertEqual("[[[[3,0],[5,3]],[4,4]],[5,5]]", str(result))

    def test_sum_list_3(self):
        pairs = [
            parse_pairs(eval("[1,1]"), None, False),
            parse_pairs(eval("[2,2]"), None, False),
            parse_pairs(eval("[3,3]"), None, False),
            parse_pairs(eval("[4,4]"), None, False),
            parse_pairs(eval("[5,5]"), None, False),
            parse_pairs(eval("[6,6]"), None, False),
        ]
        result = sum_list_of_pairs(pairs)
        self.assertEqual("[[[[5,0],[7,4]],[5,5]],[6,6]]", str(result))

    def test_sum_list_longer_example(self):
        pairs = [
            parse_pairs(eval("[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]"), None, False),
            parse_pairs(eval("[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]"), None, False),
            parse_pairs(eval("[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]"), None, False),
            parse_pairs(eval("[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]"), None, False),
            parse_pairs(eval("[7,[5,[[3,8],[1,4]]]]"), None, False),
            parse_pairs(eval("[[2,[2,2]],[8,[8,1]]]"), None, False),
            parse_pairs(eval("[2,9]"), None, False),
            parse_pairs(eval("[1,[[[9,3],9],[[9,0],[0,7]]]]"), None, False),
            parse_pairs(eval("[[[5,[7,4]],7],1]"), None, False),
            parse_pairs(eval("[[[[4,2],2],6],[8,7]]"), None, False),
        ]
        result = sum_list_of_pairs(pairs)
        self.assertEqual("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]", str(result))

    def test_simple_magnitude(self):
        self.assertEqual(29, magnitude(parse_pairs(eval("[9,1]"), None, False)))

    def test_magnitude_1(self):
        self.assertEqual(143, magnitude(parse_pairs(eval("[[1,2],[[3,4],5]]"), None, False)))

    def test_magnitude_2(self):
        self.assertEqual(1384, magnitude(parse_pairs(eval("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"), None, False)))

    def test_magnitude_3(self):
        self.assertEqual(445, magnitude(parse_pairs(eval("[[[[1,1],[2,2]],[3,3]],[4,4]]"), None, False)))

    def test_magnitude_4(self):
        self.assertEqual(791, magnitude(parse_pairs(eval("[[[[3,0],[5,3]],[4,4]],[5,5]]"), None, False)))

    def test_magnitude_5(self):
        self.assertEqual(1137, magnitude(parse_pairs(eval("[[[[5,0],[7,4]],[5,5]],[6,6]]"), None, False)))

    def test_magnitude_6(self):
        self.assertEqual(3488, magnitude(
            parse_pairs(eval("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]"), None, False)))

    def test_homework_assignment(self):
        pairs = [
            parse_pairs(eval("[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]"), None, False),
            parse_pairs(eval("[[[5,[2,8]],4],[5,[[9,9],0]]]"), None, False),
            parse_pairs(eval("[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]"), None, False),
            parse_pairs(eval("[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]"), None, False),
            parse_pairs(eval("[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]"), None, False),
            parse_pairs(eval("[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]"), None, False),
            parse_pairs(eval("[[[[5,4],[7,7]],8],[[8,3],8]]"), None, False),
            parse_pairs(eval("[[9,3],[[9,9],[6,[4,9]]]]"), None, False),
            parse_pairs(eval("[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]"), None, False),
            parse_pairs(eval("[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]"), None, False),
        ]
        self.assertEqual(4140, do_homework(pairs))

    def test_homework_find_largest_mag(self):
        pairs = [
            parse_pairs(eval("[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]"), None, False),
            parse_pairs(eval("[[[5,[2,8]],4],[5,[[9,9],0]]]"), None, False),
            parse_pairs(eval("[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]"), None, False),
            parse_pairs(eval("[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]"), None, False),
            parse_pairs(eval("[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]"), None, False),
            parse_pairs(eval("[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]"), None, False),
            parse_pairs(eval("[[[[5,4],[7,7]],8],[[8,3],8]]"), None, False),
            parse_pairs(eval("[[9,3],[[9,9],[6,[4,9]]]]"), None, False),
            parse_pairs(eval("[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]"), None, False),
            parse_pairs(eval("[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]"), None, False),
        ]
        self.assertEqual(3993, find_largest_mag(pairs))
