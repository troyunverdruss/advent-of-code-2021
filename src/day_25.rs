use std::collections::HashMap;
use std::fs::File;
use std::io::{BufReader, Read};
use std::iter::Map;
use crate::day_25::CukeType::{DOWN, NONE, RIGHT};

pub fn run() {
    let grid = parse_lines(&read_input());

    let step_count = part1(&grid);
    println!("Part 1: {}", step_count);

    let assdf = 0;
}

fn part1(grid: &HashMap<Point, CukeType>) -> i64 {
    let mut step_count = 1;
    let mut last_grid = grid.clone();
    let mut next_grid = step(&grid);
    while last_grid != next_grid {
        step_count += 1;
        if (step_count % 10 == 0) {
            println!("Step: {}", step_count)
        }
        last_grid = next_grid.clone();
        next_grid = step(&next_grid)
    }
    step_count
}

fn step(grid: &HashMap<Point, CukeType>) -> HashMap<Point, CukeType> {
    let right_moved = sub_step(grid, RIGHT);
    let down_moved = sub_step(&right_moved, DOWN);
    down_moved
}

fn sub_step(grid: &HashMap<Point, CukeType>, cukeType: CukeType) -> HashMap<Point, CukeType> {
    let mut next_grid: HashMap<Point, CukeType> = HashMap::new();
    grid.keys().for_each(|f| {
        next_grid.insert(*f, CukeType::NONE);
    });
    grid.into_iter().filter(|kv| kv.1 != &cukeType && kv.1 != &NONE).for_each(|kv| {
        next_grid.insert(*kv.0, *kv.1);
    });
    grid.into_iter().filter(|kv| kv.1 == &cukeType).for_each(|kv| {
        let next_move = can_move(grid, kv.0, kv.1);
        if (next_move.is_some()) {
            next_grid.insert(next_move.unwrap(), *kv.1);
            next_grid.insert(*kv.0, NONE);
        } else if (kv.1 != &NONE) {
            next_grid.insert(*kv.0, *kv.1);
        }
    });

    next_grid
}

fn parse_lines(lines: &Vec<String>) -> HashMap<Point, CukeType> {
    let mut grid = HashMap::new();
    for y in 0..lines.len() {
        for x in 0..lines.get(0).unwrap().len() {
            let line = lines.get(y).unwrap();
            let char = line.chars().nth(x).unwrap();

            grid.insert(Point { x: x as i64, y: y as i64 }, CukeType::parse(char));
        }
    }
    grid
}

fn read_input() -> Vec<String> {
    let file = File::open("input/day25.txt").expect("Unable to open file");
    let mut reader = BufReader::new(file);
    let mut line: String = String::new();
    reader.read_to_string(&mut line)
        .expect("Reading file to line failed");
    line.split("\n").map(String::from).filter(|l| !l.is_empty()).collect()
}

#[derive(Eq, PartialEq, Copy, Clone, Hash, Debug)]
struct Point {
    x: i64,
    y: i64,
}

impl Point {
    fn plus(self: &Point, other: &Point) -> Point {
        Point { x: self.x + other.x, y: self.y + other.y }
    }
}

#[derive(Eq, PartialEq, Copy, Clone, Debug)]
enum CukeType {
    RIGHT,
    DOWN,
    NONE,
}

impl CukeType {
    fn parse(s: char) -> CukeType {
        match s {
            '>' => RIGHT,
            'v' => DOWN,
            '.' => NONE,
            _ => panic!("Unknown input: {}", s)
        }
    }
}

fn can_move(grid: &HashMap<Point, CukeType>, loc: &Point, cukeType: &CukeType) -> Option<Point> {
    let max_x = grid.keys().map(|k| k.x).max().unwrap();
    let max_y = grid.keys().map(|k| k.y).max().unwrap();
    match cukeType {
        RIGHT => {
            let next_x = (loc.x + 1) % (max_x + 1);
            let check = Point { x: next_x, y: loc.y };
            if (grid.get(&check).unwrap() == &NONE) {
                Some(check)
            } else {
                None
            }
        }
        DOWN => {
            let next_y = (loc.y + 1) % (max_y + 1);
            let check = Point { x: loc.x, y: next_y };
            if (grid.get(&check).unwrap() == &NONE) {
                Some(check)
            } else {
                None
            }
        }
        NONE => None
    }
}

#[cfg(test)]
mod tests {
    use crate::day_25::{parse_lines, part1, step};

    #[test]
    fn test_one_line_simple_example() {
        let input = [
            ".>>.>"
        ].into_iter().map(|l| String::from(l)).collect();
        let grid = parse_lines(&input);
        let next_grid = step(&grid);

        let expected_input = [
            ">>.>."
        ].into_iter().map(|l| String::from(l)).collect();
        let expected = parse_lines(&expected_input);

        // expected.into_iter().for_each(|kv| {
        //     let found = next_grid.get(&kv.0).unwrap();
        //     println!("Point: {:?}, Expected: {:?}, Found: {:?}", kv.0, kv.1, found);
        //     assert!(found == &kv.1)
        // });

        assert_eq!(expected, next_grid)
    }

    #[test]
    fn test_one_col_simple_example() {
        let input = [
            ".",
            "v",
            "v",
            ".",
            "v",
        ].into_iter().map(|l| String::from(l)).collect();
        let grid = parse_lines(&input);
        let next_grid = step(&grid);

        let expected_input = [
            "v",
            "v",
            ".",
            "v",
            ".",
        ].into_iter().map(|l| String::from(l)).collect();
        let expected = parse_lines(&expected_input);

        // expected.into_iter().for_each(|kv| {
        //     let found = next_grid.get(&kv.0).unwrap();
        //     println!("Point: {:?}, Expected: {:?}, Found: {:?}", kv.0, kv.1, found);
        //     assert!(found == &kv.1)
        // });

        assert_eq!(expected, next_grid)
    }

    #[test]
    fn test_one_step_example() {
        let input = [
            "..........",
            ".>v....v..",
            ".......>..",
            "..........",
        ].into_iter().map(|l| String::from(l)).collect();
        let grid = parse_lines(&input);
        let next_grid = step(&grid);

        let expected_input = [
            "..........",
            ".>........",
            "..v....v>.",
            "..........",
        ].into_iter().map(|l| String::from(l)).collect();
        let expected = parse_lines(&expected_input);

        // expected.into_iter().for_each(|kv| {
        //     let found = next_grid.get(&kv.0).unwrap();
        //     println!("Point: {:?}, Expected: {:?}, Found: {:?}", kv.0, kv.1, found);
        //     assert!(found == &kv.1)
        // });

        assert_eq!(expected, next_grid)
    }

    #[test]
    fn test_one_line_example() {
        let input = [
            "...>>>>>..."
        ].into_iter().map(|l| String::from(l)).collect();
        let grid = parse_lines(&input);
        let next_grid = step(&grid);

        let expected_input = [
            "...>>>>.>.."
        ].into_iter().map(|l| String::from(l)).collect();
        let expected = parse_lines(&expected_input);

        expected.into_iter().for_each(|kv| {
            let found = next_grid.get(&kv.0).unwrap();
            println!("Point: {:?}, Expected: {:?}, Found: {:?}", kv.0, kv.1, found);
            assert!(found == &kv.1)
        });

        // assert_eq!(expected, next_grid)
    }

    #[test]
    fn test_full_example() {
        let input = [
            "v...>>.vv>",
            ".vv>>.vv..",
            ">>.>v>...v",
            ">>v>>.>.v.",
            "v>v.vv.v..",
            ">.>>..v...",
            ".vv..>.>v.",
            "v.v..>>v.v",
            "....v..v.>",
        ].into_iter().map(|l| String::from(l)).collect();
        let grid = parse_lines(&input);
        assert_eq!(58, part1(&grid))
    }
}