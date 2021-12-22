use std::collections::{HashMap};
use std::fs::File;
use std::io::{BufReader, Read};

pub fn run() {
    let lines = read_file_to_lines();
    let algorithm = parse_algorithm(&lines);
    let pixels = parse_pixels(&lines);

    let enhance_part1 = enhance_n_times(&algorithm, &pixels, 2);
    let part1 = enhance_part1.values().filter(|v| matches!(v, PixelState::ON)).count();
    println!("Part 1: {}", part1);
    let enhance_part2 = enhance_n_times(&algorithm, &pixels, 50);
    let part2 = enhance_part2.values().filter(|v| matches!(v, PixelState::ON)).count();
    println!("Part 2: {}", part2);
}

fn enhance_n_times(algorithm: &Vec<PixelState>, pixels: &HashMap<Point, PixelState>, times: i64) -> HashMap<Point, PixelState> {
    let result = (0..times).fold(pixels.clone(), |acc, x| {
        let default = match x % 2 {
            0 => PixelState::OFF,
            1 => PixelState::ON,
            _ => panic!("Impossible mod 2 case")
        };
        enhance(&algorithm, &acc, &default)
    });
    return result;
}

fn enhance(algorithm: &Vec<PixelState>, pixels: &HashMap<Point, PixelState>, default_state: &PixelState) -> HashMap<Point, PixelState> {
    let x_min = pixels.keys().into_iter().map(|p| p.x).min().unwrap();
    let x_max = pixels.keys().into_iter().map(|p| p.x).max().unwrap();
    let y_min = pixels.keys().into_iter().map(|p| p.y).min().unwrap();
    let y_max = pixels.keys().into_iter().map(|p| p.y).max().unwrap();

    let mut next_pixels = HashMap::new();
    for y in y_min - 1..=y_max + 1 {
        for x in x_min - 1..=x_max + 1 {
            let decimal_index = pixel_to_decimal(pixels, &Point { x, y }, default_state);
            let value = algorithm.get(decimal_index as usize).unwrap();
            next_pixels.insert(Point { x, y }, *value);
        }
    }
    return next_pixels;
}

fn pixel_to_decimal(pixels: &HashMap<Point, PixelState>, point: &Point, default_state: &PixelState) -> i64 {
    let s: String = subject_pixels(point)
        .into_iter()
        .map(|p| {
            match pixels.get(&p) {
                Some(ps) => ps.binary_text_value(),
                None => default_state.binary_text_value()
            }
        })
        .collect();
    i64::from_str_radix(&s, 2).unwrap()
}

fn parse_pixels(lines: &Vec<String>) -> HashMap<Point, PixelState> {
    let img_data = &lines[1].split('\n').collect::<Vec<&str>>();
    let x_max = img_data.get(0).unwrap().len() as i64;
    let y_max = img_data.len() as i64;
    let mut pixels = HashMap::new();
    for y in 0..y_max {
        for x in 0..x_max {
            let pixel_data = img_data.get(y as usize).unwrap().chars().nth(x as usize);
            match pixel_data {
                Some('#') => pixels.insert(Point { x, y }, PixelState::ON),
                Some('.') => pixels.insert(Point { x, y }, PixelState::OFF),
                None => None,
                _ => panic!("Unknown input pixel")
            };
        }
    }

    return pixels;
}

fn parse_algorithm(lines: &Vec<String>) -> Vec<PixelState> {
    let algorithm_data = lines.get(0).unwrap();
    algorithm_data.chars().map(|c| {
        match c {
            '.' => PixelState::OFF,
            '#' => PixelState::ON,
            _ => panic!("Unknown character")
        }
    }).collect()
}

fn read_file_to_lines() -> Vec<String> {
    let file = File::open("input/day20.txt").expect("Unable to open file");
    let mut reader = BufReader::new(file);
    let mut line: String = String::new();
    reader.read_to_string(&mut line)
        .expect("Reading file to line failed");
    line.split("\n\n").map(String::from).collect()
}

fn subject_pixels(point: &Point) -> Vec<Point> {
    let Point { x, y } = point;
    vec![
        Point { x: x - 1, y: y - 1 }, Point { x: *x, y: y - 1 }, Point { x: x + 1, y: y - 1 },
        Point { x: x - 1, y: *y }, Point { x: *x, y: *y }, Point { x: x + 1, y: *y },
        Point { x: x - 1, y: y + 1 }, Point { x: *x, y: y + 1 }, Point { x: x + 1, y: y + 1 },
    ]
}

#[derive(PartialEq, Eq, Hash, Copy, Clone)]
enum PixelState {
    ON,
    OFF,
}

impl PixelState {
    fn binary_text_value(&self) -> char {
        match *self {
            PixelState::ON => '1',
            PixelState::OFF => '0',
        }
    }
}

#[derive(PartialEq, Eq, Hash, Copy, Clone)]
struct Point {
    x: i64,
    y: i64,
}

#[cfg(test)]
mod tests {
    #[test]
    fn test() {}
}
