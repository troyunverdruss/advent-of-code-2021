
import Day22.State.{ON, OFF, State}

import scala.collection.mutable
import scala.io.Source

object Day22 {
  def main(args: Array[String]): Unit = {
    val commands = parseLines(readInput())
    val grid = new mutable.HashSet[Point]()
    commands.foreach(c => {
      val cp = crossProduct(c.minValues, c.maxValues)
      c.state match {
        case ON => grid.addAll(cp)
        case OFF => cp.foreach(p => grid.remove(p))
      }
    })

    val part1 = grid.count(p => p.x >= -50 && p.y >= -50 && p.z >= -50 && p.x <= 50 && p.y <= 50 && p.z <= 50)
    println(s"Part 1: $part1")
  }

  def crossProduct(min: Point, max: Point): List[Point] = {
    (math.max(min.x, -50) to math.min(max.x, 50)).flatMap(x => {
      (math.max(min.y, -50) to math.min(max.y, 50)).flatMap(y => {
        (math.max(min.z, -50) to math.min(max.z, 50)).map(z => {
          Point(x, y, z)
        })
      })
    }).toList
  }

  def parseLines(lines: List[String]): List[Command] = {
    lines.map(line => {
      val parse1 = line.split(" ", 2)
      val state = State.parse(parse1(0))
      val xyz = parse1(1).split(",").map(v => parseRange(v))
      Command(state, Point(xyz(0)._1, xyz(1)._1, xyz(2)._1), Point(xyz(0)._2, xyz(1)._2, xyz(2)._2))
    })
  }

  def parseRange(s: String): (Long, Long) = {
    val res = s.split("=")(1).split("\\.\\.")
    (res(0).toLong, res(1).toLong)
  }

  case class Command(state: State, minValues: Point, maxValues: Point)

  def readInput(): List[String] = {
    val source = Source.fromFile("../input/day22.txt")
    val lines = source.getLines().toList
    source.close()
    lines
  }

  object State extends Enumeration {
    type State = Value
    val ON, OFF = Value

    def parse(s: String): State = {
      s match {
        case "on" => ON
        case "off" => OFF
        case _ => throw new Exception(s"Couldn't match state word $s")
      }
    }
  }

  case class Point(x: Long, y: Long, z: Long)
}