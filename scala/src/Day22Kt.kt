import scala.Option
import java.io.File
import java.util.*
import java.util.function.ToLongFunction
import kotlin.math.abs
import kotlin.math.max
import kotlin.math.min

object Day22Kt {
    @JvmStatic
    fun main(args: Array<String>) {
        val commands = parseLines(readInput())
        val part2 = computePart2(commands)
        println("Part 2: $part2")
        val x = 0
        // too hi  2917071412308723
        //         1334275219162622
        // too low 1334165143735093
        //         1334165143735093
        //         1334165143735093
        //          935078188393111
        //          733303644302358
        // too low  503468910258853
    }

    fun computePart2(commands: List<Command>): Long {
        val intermediateCubes = LinkedList<Command>()
//
//        // List starts out empty
//        // Process ON
//        // Add any ON commands to the list
//        // If ON overlaps with any past ONs then add an OFF for the overlap
//        // If ON overlaps with any past OFFs then add an ON for the overlap
//        // Process OFF
//        // For any past ONs add an OFF for the overlap
//        // For any past OFFs add an ON for the overlap
        commands.forEach { command ->
            val additions: LinkedList<Command> = LinkedList<Command>()
            for (ic in intermediateCubes) {
                val overlap = computeOverlap(command.cube, ic.cube)
                if (State.ON == command.state) {
                    overlap?.let { o ->
                        if (State.ON == ic.state) {
                            additions.add(Command(State.OFF, o))
                        } else {
                            additions.add(Command(State.ON, o))
                        }
                    }
                } else {
                    overlap?.let { o ->
                        if (ic.state == State.ON) {
                            additions.add(Command(State.OFF, o))
                        } else {
                            additions.add(Command(State.ON, o))
                        }
                    }
                }
            }
            if (command.state == State.ON) {
                intermediateCubes.add(command)
            }
            intermediateCubes.addAll(additions)
        }

        return intermediateCubes.sumOf { c ->
            if (c.state == State.ON) {
                cubeSize(c.cube)
            } else {
                -1L * cubeSize(c.cube)
            }
        }
    }
}

fun calculatePart1(commands: List<Command>): Long {
    val grid = HashSet<Point>()
    commands.forEach { c ->

        val cp = crossProduct(c.cube.min, c.cube.max)

        when (c.state) {
            State.ON -> grid.addAll(cp)
            State.OFF -> grid.removeAll(cp)
        }
    }
    return grid.count().toLong()
}

fun calculatePart1OffOverlapOnly(commands: List<Command>): HashSet<Point> {
    val grid = HashSet<Point>()
    var overlap = HashSet<Point>()
    commands.forEach { c ->

        val cp = crossProduct(c.cube.min, c.cube.max)

        when (c.state) {
            State.ON -> grid.addAll(cp)
            State.OFF -> {
                cp.forEach {
                    if (grid.contains(it)) {
                        overlap.add(it)
                    }
                }
                grid.removeAll(cp)
            }
        }
    }
    return overlap
}

fun crossProduct(min: Point, max: Point): List<Point> {
    return (max(min.x, -50).rangeTo(min(max.x, 50))).flatMap { x ->
        (max(min.y, -50).rangeTo(min(max.y, 50))).flatMap { y ->
            (max(min.z, -50).rangeTo(min(max.z, 50))).map { z ->
                Point(x, y, z)
            }
        }
    }
}

fun constrainCommandsToInitRegion(commands: List<Command>): List<Command> {
    return commands
            .filter { cubesOverlap(Cube(Point(-50, -50, -50), Point(50, 50, 50)), it.cube) }
            .map { c ->
                val min = Point(max(-50, c.cube.min.x), max(-50, c.cube.min.y), max(-50, c.cube.min.z))
                val max = Point(min(50, c.cube.max.x), min(50, c.cube.max.y), min(50, c.cube.max.z))
                c.copy(cube = Cube(min, max))
            }
}


data class Point(val x: Long, val y: Long, val z: Long)
data class Cube(val min: Point, val max: Point)
enum class State {
    ON, OFF;

    open fun parse(s: String): State {
        if (s == "on") {
            return ON
        } else if (s == "off") {
            return OFF
        }
        throw RuntimeException("Couldn't match state word $s")
    }
}

data class Command(val state: State, val cube: Cube)

fun cubeSize(cube: Cube): Long {
    val x = abs(cube.max.x - cube.min.x) + 1
    val y = abs(cube.max.y - cube.min.y) + 1
    val z = abs(cube.max.z - cube.min.z) + 1
    return x * y * z
//    return if (x == 0L || y == 0L || z == 0L) {
//        0
//    } else {
//        (x + 1) * (y + 1) * (z + 1)
//    }
}

fun readInput(): List<String> {
    return File("../input/day22.txt").readLines()
}

fun parseLines(lines: List<String>): List<Command> {
    return lines.map { line ->
        val parse1 = line.split(" ", limit = 2)
        val state = parseState(parse1[0])
        val xyz = parse1[1].split(",").map { v -> parseRange(v) }
        Command(state, Cube(Point(xyz[0].first, xyz[1].first, xyz[2].first), Point(xyz[0].second, xyz[1].second, xyz[2].second)))
    }
}

fun parseRange(s: String): Pair<Long, Long> {
    val res = s.split("=")[1].split("..")
    return Pair(res[0].toLong(), res[1].toLong())
}

fun parseState(s: String): State {
    if (s == "on") {
        return State.ON
    } else if (s == "off") {
        return State.OFF
    }
    throw RuntimeException("Couldn't match state word $s")
}

fun computeOverlap(cube1: Cube, cube2: Cube): Cube? {
    if (!cubesOverlap(cube1, cube2)) {
        return null
    }

    val overlapMin = Point(
            max(cube1.min.x, cube2.min.x),
            max(cube1.min.y, cube2.min.y),
            max(cube1.min.z, cube2.min.z)
    )
    val overlapMax = Point(
            min(cube1.max.x, cube2.max.x),
            min(cube1.max.y, cube2.max.y),
            min(cube1.max.z, cube2.max.z)
    )

    return Cube(overlapMin, overlapMax)
}

//fun test(cube1: Cube, cube2: Cube) {
//    if ((cube1.min.x >= cube2.min.x && cube1.min.x < cube2.max.x || cube1.max.x >= cube2.min.x && cube1.max.x < cube2.max.x) && (same with y) && (same with z) ||
//            (cube2.min.x >= cube1.min.x && cube2.min.x < cube1.max.x || cube2.max.x >= cube1.min.x && cube2.max.x < cube1.max.x) && (same with y) && (same with z)) {
//    }
//}

fun cubesOverlap(cube1: Cube, cube2: Cube): Boolean {
    var overlapX = false
    var overlapY = false
    var overlapZ = false
    // check X
    if (cube1.min.x <= cube2.min.x && cube2.min.x <= cube1.max.x || cube1.min.x <= cube2.max.x && cube2.max.x <= cube1.max.x ||
            cube2.min.x <= cube1.min.x && cube1.min.x <= cube2.max.x || cube2.min.x <= cube1.max.x && cube1.max.x <= cube2.max.x) {
        overlapX = true
    }
    // check Y
    if (cube1.min.y <= cube2.min.y && cube2.min.y <= cube1.max.y || cube1.min.y <= cube2.max.y && cube2.max.y <= cube1.max.y ||
            cube2.min.y <= cube1.min.y && cube1.min.y <= cube2.max.y || cube2.min.y <= cube1.max.y && cube1.max.y <= cube2.max.y) {
        overlapY = true
    }
    // check Z
    if (cube1.min.z <= cube2.min.z && cube2.min.z <= cube1.max.z || cube1.min.z <= cube2.max.z && cube2.max.z <= cube1.max.z ||
            cube2.min.z <= cube1.min.z && cube1.min.z <= cube2.max.z || cube2.min.z <= cube1.max.z && cube1.max.z <= cube2.max.z) {
        overlapZ = true
    }

    return overlapX && overlapY && overlapZ
}