import java.io.File
import java.lang.RuntimeException
import java.util.*
import kotlin.collections.LinkedHashMap

object Day23 {
    @JvmStatic
    fun main(args: Array<String>) {
        val grid = parseInput(readInput())
        val adjacencyMap = buildAdjacencyList(grid)
        val startingState = State(0, grid.filter { it.value != '.' })
        val dests = findDestinations(adjacencyMap, startingState, Point(4, 1))
        val stateQueue = PriorityQueue<State>(compareBy { it.cost })
        stateQueue.add(State(0, grid))
        var winner: State? = null
        while (stateQueue.isNotEmpty()) {
            val state = stateQueue.poll()
            nextOptions(state).forEach { next ->
                if (winner(next)) {
                    if (winner == null || winner!!.cost > next.cost) {
                        winner = next.copy()
                    }
                }
            }

        }
    }

    fun findDestinations(adjacencyMap: Map<Point, List<Point>>, state: State, start: Point): Map<Point, Int> {
        val visited = mutableMapOf<Point, Int>()
        val unvisited = validNextSteps(adjacencyMap, start, 0, state, visited)
        while (unvisited.isNotEmpty()) {
            val (point, dist) = unvisited.removeFirst()
            visited.put(point, dist)
            unvisited.addAll(validNextSteps(adjacencyMap, point, dist, state, visited))
        }

        return visited
                .filter { !(INVALID_STOPS_LOOKUP[state.positions[start]]?.contains(it.key) ?: false) }
                .filter { isDisallowed(it, state, start) }

    }

    private fun isDisallowed(possibleDest: Map.Entry<Point, Int>, state: State, start: Point): Boolean {
        val amphipodType = state.positions[start] ?: throw RuntimeException("amphipod not in state??")
        val home = VALID_FINAL_STOPS[amphipodType] ?: throw RuntimeException("amphipod home invalid??")
        // If I'm in my final destination, don't allow any moves
        if (home.contains(start)) {
            return false
        }
        // Don't allow moving if i'm in hallway and not heading home
        if (start.y == 1 && possibleDest.key.y == 1) {
            return false
        }
        // Don't allow moving to top of hole if empty
        val homeEmpty = state.positions.filter { home.contains(it.key) }.isEmpty()
        if (homeEmpty && home.contains(possibleDest.key) && possibleDest.key.y == 2) {
            return false
        }

        // Don't allow moving to a half occupied hole if not matching
        val inHome = state.positions.filter { home.contains(it.key) }.map { it.value }
        if (inHome.any { it != amphipodType }) {
            return false
        }
        return true
    }

    private fun validNextSteps(adjacencyMap: Map<Point, List<Point>>, start: Point, dist: Int, state: State, visited: MutableMap<Point, Int>): MutableList<Pair<Point, Int>> {
        return adjacencyMap[start]
                ?.filter { !state.positions.contains(it) }
                ?.filter { !visited.keys.contains(it) }
                ?.map { Pair(it, dist + 1) }?.toMutableList()
                ?: mutableListOf()
    }


    fun buildAdjacencyList(grid: Map<Point, Char>): Map<Point, List<Point>> {
        val neighbors = listOf(Point(-1, 0), Point(1, 0), Point(0, -1), Point(0, 1))
        return grid.keys.map { k ->
            val ns = neighbors
                    .map { n -> k + n }
                    .filter { n -> grid.keys.contains(n) }
                    .toList()
            Pair(k, ns)
        }.toMap()
    }
//    data class Edge(val a: String, val b: String, val d: Int)
//    fun adjacencyMap(): Map<String, List<String>> {
//        listOf(
//                Edge("H1", "H2", 1),
//                Edge("H2", "H3", 2),
//                Edge("H2", "A1", 2),
//                Edge("A1", "A2", 1),
//                Edge("H3", "H4"),
//                Edge("H3", "B1"),
//                Edge("B1", "B2"),
//                Edge("H4", "H5"),
//                Edge("H4", "C1"),
//                Edge("C1", "C2"),
//                Edge("C1", "C2"),
//                Edge("H5", "H6"),
//
//
//        )
//    }

    private fun winner(next: State): Boolean {
        TODO("Not yet implemented")
    }

    private fun nextOptions(state: State): List<State> {
        TODO()
    }

    fun readInput(): List<String> {
        return File("../input/day23.txt").readLines()
    }

    fun parseInput(lines: List<String>): LinkedHashMap<Point, Char> {
        val grid = LinkedHashMap<Point, Char>()
        lines.withIndex().map { (y, line) ->
            line.withIndex().forEach { (x, p) ->
                if (p != '#' && p != ' ') {
                    grid[Point(x, y)] = p
                }
            }
        }
        return grid
    }

    data class State(val cost: Long, val positions: Map<Point, Char>)
    data class Point(val x: Int, val y: Int) {
        operator fun plus(other: Point): Point {
            return Point(this.x + other.x, this.y + other.y)
        }
    }

    private val INVALID_STOPS = listOf(
            Point(3, 1),
            Point(5, 1),
            Point(7, 1),
            Point(9, 1),
    )
    private val A_ONLY = listOf(
            Point(3, 2),
            Point(3, 3),
    )
    private val B_ONLY = listOf(
            Point(5, 2),
            Point(5, 3),
    )
    private val C_ONLY = listOf(
            Point(7, 2),
            Point(7, 3),
    )
    private val D_ONLY = listOf(
            Point(9, 2),
            Point(9, 3),
    )
    private val INVALID_STOPS_LOOKUP = mapOf(
            'A' to INVALID_STOPS + B_ONLY + C_ONLY + D_ONLY,
            'B' to INVALID_STOPS + A_ONLY + C_ONLY + D_ONLY,
            'C' to INVALID_STOPS + A_ONLY + B_ONLY + D_ONLY,
            'D' to INVALID_STOPS + A_ONLY + B_ONLY + C_ONLY,
    )
    private val VALID_FINAL_STOPS = mapOf(
            'A' to A_ONLY,
            'B' to B_ONLY,
            'C' to C_ONLY,
            'D' to D_ONLY,
    )
}


