
//import Day22.State.{OFF, ON, State}

import java.util
import java.util.concurrent.ConcurrentLinkedQueue
import scala.collection.IterableOnce.iterableOnceExtensionMethods
import scala.collection.convert.ImplicitConversions.`collection AsScalaIterable`
import scala.collection.mutable
import scala.io.Source

object Day22 {
  def main(args: Array[String]): Unit = {
    val commands = parseLines(readInput())
    val part1 = calculatePart1(commands)
    println(s"Part 1: $part1")

    val part2 = computePart2(commands)
    println(s"Part 2: $part2")
    // too low 1334165143735093
    //         1334165143735093
    //          935078188393111
  }

  def computePart2(commands: List[Command]): Long = {
    val intermediateCubes = new util.LinkedList[Command]()

    // List starts out empty
    // Process ON
    // Add any ON commands to the list
    // If ON overlaps with any past ONs then add an OFF for the overlap
    // If ON overlaps with any past OFFs then add an ON for the overlap
    // Process OFF
    // For any past ONs add an OFF for the overlap
    // For any past OFFs add an ON for the overlap

    commands.foreach(command => {
      val additions = new util.LinkedList[Command]()
      if (command.state == State.ON) {
        intermediateCubes.foreach(ic => {
          val overlap = computeOverlap(command.minValues, command.maxValues, ic.minValues, ic.maxValues)
          if (overlap.nonEmpty) {
            if (ic.state == State.ON) {
              additions.add(Command(State.OFF, overlap.get._1, overlap.get._2))
            }
            else {
              additions.add(Command(State.ON, overlap.get._1, overlap.get._2))
            }
          }
        })
        additions.foreach(a => intermediateCubes.add(a))
        intermediateCubes.add(command)
      }
      else {
        //        val additions = new ConcurrentLinkedQueue[Command]()
        intermediateCubes.foreach(ic => {
          val overlap = computeOverlap(command.minValues, command.maxValues, ic.minValues, ic.maxValues)
          if (overlap.nonEmpty) {
            if (ic.state == State.ON) {
              additions.add(Command(State.OFF, overlap.get._1, overlap.get._2))
            }
            else {
              additions.add(Command(State.ON, overlap.get._1, overlap.get._2))
            }
          }
        })
        additions.foreach(a => intermediateCubes.add(a))

      }
    })

    var tally = 0L
    intermediateCubes.foreach(c =>
      if (c.state == State.ON) {
        tally += cubeSize(c.minValues, c.maxValues)
      } else {
        tally -= cubeSize(c.minValues, c.maxValues)
      }
    )

    tally
  }

  def findBoundingCube(commands: List[Command]) = {}


  def cubeSize(min: Point, max: Point) = {
    math.abs(max.x - min.x) * math.abs(max.y - min.y) * math.abs(max.z - min.z)
  }

  def cubesOverlap(c1Min: Point, c1Max: Point, c2Min: Point, c2Max: Point): Boolean = {
    var overlapX = false
    var overlapY = false
    var overlapZ = false
    // check X
    if (c1Min.x <= c2Min.x && c2Min.x < c1Max.x || c1Min.x < c2Max.x && c2Max.x <= c1Max.x ||
      c2Min.x <= c1Min.x && c1Min.x < c2Max.x || c2Min.x < c1Max.x && c1Max.x <= c2Max.x) {
      overlapX = true
    }
    // check Y
    if (c1Min.y <= c2Min.y && c2Min.y < c1Max.y || c1Min.y < c2Max.y && c2Max.y <= c1Max.y ||
      c2Min.y <= c1Min.y && c1Min.y < c2Max.y || c2Min.y < c1Max.y && c1Max.y <= c2Max.y) {
      overlapY = true
    }
    // check Z
    if (c1Min.z <= c2Min.z && c2Min.z < c1Max.z || c1Min.z < c2Max.z && c2Max.z <= c1Max.z ||
      c2Min.z <= c1Min.z && c1Min.z < c2Max.z || c2Min.z < c1Max.z && c1Max.z <= c2Max.z) {
      overlapZ = true
    }

    overlapX && overlapY && overlapZ
  }

  def addCubes(c1Min: Point, c1Max: Point, c2Min: Point, c2Max: Point): Long = {
    if (!cubesOverlap(c1Min, c1Max, c2Min, c2Max)) {
      return cubeSize(c1Min, c1Max) + cubeSize(c2Min, c2Max)
    }
    val sizeA = cubeSize(c1Min, c1Max)
    val sizeB = cubeSize(c2Min, c2Max)
    val sizeAMinusOverlap = subtractCubes(c1Min, c1Max, c2Min, c2Max)
    val overlapSize = sizeA - sizeAMinusOverlap
    sizeA + sizeB - overlapSize
  }

  def computeOverlap(c1Min: Point, c1Max: Point, c2Min: Point, c2Max: Point): Option[(Point, Point)] = {
    if (!cubesOverlap(c1Min, c1Max, c2Min, c2Max)) {
      return None
    }

    val overlapMin = Point(
      math.max(c1Min.x, c2Min.x),
      math.max(c1Min.y, c2Min.y),
      math.max(c1Min.z, c2Min.z)
    )
    val overlapMax = Point(
      math.min(c1Max.x, c2Max.x),
      math.min(c1Max.y, c2Max.y),
      math.min(c1Max.z, c2Max.z)
    )

    Some((overlapMin, overlapMax))
  }

  def subtractCubes(c1Min: Point, c1Max: Point, c2Min: Point, c2Max: Point): Long = {
    val overlap = computeOverlap(c1Min, c1Max, c2Min, c2Max)
    if (overlap.isEmpty) {
      return cubeSize(c1Min, c1Max)
    }

    val (overlapMin, overlapMax) = overlap.get
    cubeSize(c1Min, c1Max) - cubeSize(overlapMin, overlapMax)
  }

  private def calculatePart1(commands: List[Command]) = {
    val grid = new mutable.HashSet[Point]()
    commands.foreach(c => {
      val cp = crossProduct(c.minValues, c.maxValues)
      c.state match {
        case State.ON => grid.addAll(cp)
        case State.OFF => cp.foreach(p => grid.remove(p))
      }
    })
    grid.size
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

  case class Point(x: Long, y: Long, z: Long)
}