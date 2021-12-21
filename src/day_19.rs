use std::fs::File;
use std::io::{BufRead, BufReader, Read};


pub fn run() {
    let scanners = parse_input();
    scanner_rotations(scanners.get(0).unwrap());


    let x = 0;
    let y = 1;
}

fn scanner_rotations(scanner: &Scanner) -> Vec<Scanner> {
    let mut aliases = vec![];
    for _ in 0..24 {
        aliases.push(Scanner{ name: scanner.name.to_owned(), beacons: vec![]})
    }
    aliases.get(0).unwrap().beacons.push(Point{x:1,y:1,z:1});
    // x y z
    // -x -y z
    // -z y -z


    // y z x
    // z x y

    // -x y z
    // y z -x
    // z -x y

    // x y z
    // y z x
    // z x y

    // y z x
    // z x y
    // z y x
    return aliases;
}

fn parse_input() -> Vec<Scanner> {
    let scanner_groups = read_file_to_lines();
    let scanners = scanner_groups
        .into_iter()
        .map(|lines| lines.split("\n").map(String::from).collect::<Vec<String>>())
        .map(|lines| {
            parse_scanner_lines_to_scanner(lines)
        }
        ).collect::<Vec<Scanner>>();

    return scanners;
}

fn parse_scanner_lines_to_scanner(lines: Vec<String>) -> Scanner {
    let name = String::from(lines.get(0).unwrap());
    let beacons = lines.split_at(1).1
        .into_iter()
        .filter(|s| !s.is_empty())
        .map(|xyz| xyz.split(',').collect::<Vec<&str>>())
        // .map(|xyz| xyz.into_iter().map(|d|
        //     d.parse::<i64>().unwrap()).collect::<Vec<i64>>()
        // )
        .map(|xyz| Point {
            x: xyz.get(0).unwrap().parse::<i64>().unwrap(),
            y: xyz.get(1).unwrap().parse::<i64>().unwrap(),
            z: xyz.get(2).unwrap().parse::<i64>().unwrap()
        })
        .collect::<Vec<Point>>();
    Scanner { name, beacons }
}

fn read_file_to_lines() -> Vec<String> {
    let file = File::open("input/day19.txt").expect("Unable to open file");
    let mut reader = BufReader::new(file);
    let mut line: String = String::new();
    reader.read_to_string(&mut line)
        .expect("Reading file to line failed");
    line.split("\n\n").map(String::from).collect()
}

struct Scanner {
    name: String,
    beacons: Vec<Point>,
}

struct Point {
    x: i64,
    y: i64,
    z: i64,
}

#[cfg(test)]
mod tests {

    #[test]
    fn test() {}
}