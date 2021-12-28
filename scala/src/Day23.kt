import java.io.File
import java.util.*
import kotlin.RuntimeException
import kotlin.collections.LinkedHashMap

object Day23 {
    @JvmStatic
    fun main(args: Array<String>) {
        // Part 1
        val grid = parseInput(readInput())

        val lookups = buildLookups(grid)

        val adjacencyMap = buildAdjacencyMap(grid)
        val startingState = State(grid.filter { it.value != '.' })

        val winningStates = findSolutions(adjacencyMap, startingState, lookups)

        val part1 = winningStates.map { it.cost() }.minOrNull() ?: throw RuntimeException("no solution found")
        println("Part 1: $part1")

        // Part 2
        val rawInput = readInput()
        val part2BonusLines = listOf(
            "  #D#C#B#A#",
            "  #D#B#A#C#"
        )
        val composedLines = listOf(
            rawInput[0],
            rawInput[1],
            rawInput[2],
            part2BonusLines[0],
            part2BonusLines[1],
            rawInput[3],
            rawInput[4],
        )
        val grid2 = parseInput(composedLines)
        val lookups2 = buildLookups(grid2)
        val adjacencyMap2 = buildAdjacencyMap(grid2)
        val startingState2 = State(grid2.filter { it.value != '.' })

        val winningStates2 = findSolutions(adjacencyMap2, startingState2, lookups2)

        val part2 = winningStates2.map { it.cost() }.minOrNull() ?: throw RuntimeException("no solution found")
        println("Part 2: $part2")
    }

    fun findSolutions(adjacencyMap: Map<Point, List<Point>>, startingState: State, lookups: Lookups): LinkedList<State> {
        val statesToCheck = LinkedHashMap<String, State>()
        statesToCheck.put(startingState.key(), startingState
        )
        val winningStates = LinkedList<State>()
        var statesToCheckSize = statesToCheck.size
        val checkedStates = HashMap<String, Long>()

        while (statesToCheck.isNotEmpty()) {
            val stateToCheckPair = statesToCheck.asIterable().first()
            val stateToCheck = stateToCheckPair.value
            statesToCheck.remove(stateToCheckPair.key)
            checkedStates.put(stateToCheckPair.key, stateToCheck.cost())
            statesToCheckSize -= 1
            if (isStateWinner(stateToCheck, lookups)) {
                winningStates.add(stateToCheck)
                continue
            }

            stateToCheck.positions.forEach { point, amphipodType ->
                println(statesToCheckSize)
                findDestinations(adjacencyMap, stateToCheck, lookups, point).forEach { dest ->
                    val currPositions = stateToCheck.positions.toMutableMap()
                    currPositions.remove(point)
                    currPositions.put(dest.key, amphipodType)
                    val currMoveCounts = stateToCheck.moveCounts.toMutableMap()
                    currMoveCounts[amphipodType] = (currMoveCounts[amphipodType] ?: 0) + dest.value
                    val newState = State(
                        positions = currPositions,
                        moveCounts = currMoveCounts
                    )
                    if (shouldAddForChecking(checkedStates, statesToCheck, newState)) {
                        statesToCheck.put(newState.key(), newState)
                        statesToCheckSize += 1
                    } else {
//                        println("skipping new state")
                    }
                }
            }
        }
        return winningStates
    }

    fun shouldAddForChecking(checkedStates: HashMap<String, Long>, statesToCheck: Map<String, State>, newState: State): Boolean {
        val key = newState.key()
        if (checkedStates.containsKey(key) && checkedStates[key]!! > newState.cost()) {
            return true
        }
        if (checkedStates.containsKey(key)) {
            return false
        }
        if (statesToCheck.contains(key) && statesToCheck[key]!!.cost() > newState.cost()) {
            return true
        }
        if (statesToCheck.contains(key)) {
            return false
        }
        return true
    }

    fun isStateWinner(state: State, lookups: Lookups): Boolean {
        val a = allHome(lookups, state, 'A')
        val b = allHome(lookups, state, 'B')
        val c = allHome(lookups, state, 'C')
        val d = allHome(lookups, state, 'D')
        return a && b && c && d
    }

    private fun allHome(lookups: Lookups, state: State, type: Char): Boolean {
        return lookups.homes[type]?.all { state.positions[it] == type }
                ?: throw RuntimeException("missing lookup")
    }

    fun findDestinations(adjacencyMap: Map<Point, List<Point>>, state: State, lookups: Lookups, start: Point): Map<Point, Int> {
        val visited = mutableMapOf<Point, Int>()
        val unvisited = validNextSteps(adjacencyMap, start, 0, state, visited)
        while (unvisited.isNotEmpty()) {
            val (point, dist) = unvisited.removeFirst()
            visited.put(point, dist)
            unvisited.addAll(validNextSteps(adjacencyMap, point, dist, state, visited))
        }

        return visited
                .filter { !(lookups.invalidStops[state.positions[start]]?.contains(it.key) ?: false) }
                .filter { isDisallowed(it, lookups, state, start) }

    }

    private fun isDisallowed(possibleDest: Map.Entry<Point, Int>, lookups: Lookups, state: State, start: Point): Boolean {
        val amphipodType = getAmphipodType(state, start)
        val home = lookups.homes[amphipodType] ?: throw RuntimeException("amphipod home invalid??")
        // If I'm in my final destination, don't allow any moves
        if (home.contains(start)) {
            if (allHome(lookups, state, amphipodType)) {
                return false
            }
            if (home.filter { it.y == 3 }.contains(start)) {
                return false
            }
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
        if (home.contains(possibleDest.key) && inHome.any { it != amphipodType }) {
            return false
        }
        return true
    }

    private fun getAmphipodType(state: State, start: Point) =
            state.positions[start] ?: throw RuntimeException("amphipod not in state??")

    private fun validNextSteps(adjacencyMap: Map<Point, List<Point>>, start: Point, dist: Int, state: State, visited: MutableMap<Point, Int>): MutableList<Pair<Point, Int>> {
        return adjacencyMap[start]
                ?.filter { !state.positions.contains(it) }
                ?.filter { !visited.keys.contains(it) }
                ?.map { Pair(it, dist + 1) }?.toMutableList()
                ?: mutableListOf()
    }


    fun buildAdjacencyMap(grid: Map<Point, Char>): Map<Point, List<Point>> {
        val neighbors = listOf(Point(-1, 0), Point(1, 0), Point(0, -1), Point(0, 1))
        return grid.keys.map { k ->
            val ns = neighbors
                    .map { n -> k + n }
                    .filter { n -> grid.keys.contains(n) }
                    .toList()
            Pair(k, ns)
        }.toMap()
    }

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

    data class Lookups(val invalidStops: Map<Char, List<Point>>, val homes: Map<Char, List<Point>>)

    fun buildLookups(grid: Map<Point, Char>): Lookups {
        val homes = mapOf(
            'A' to grid.keys.filter { it.x == 3 && it.y > 1 },
            'B' to grid.keys.filter { it.x == 5 && it.y > 1 },
            'C' to grid.keys.filter { it.x == 7 && it.y > 1 },
            'D' to grid.keys.filter { it.x == 9 && it.y > 1 },
        )
        val invalidStops = mapOf(
            'A' to ALWAYS_INVALID_STOPS + grid.keys.filter { it.x != 3 && it.y > 1 },
            'B' to ALWAYS_INVALID_STOPS + grid.keys.filter { it.x != 5 && it.y > 1 },
            'C' to ALWAYS_INVALID_STOPS + grid.keys.filter { it.x != 7 && it.y > 1 },
            'D' to ALWAYS_INVALID_STOPS + grid.keys.filter { it.x != 9 && it.y > 1 },
        )
        return Lookups(invalidStops, homes)
    }

    data class State(val positions: Map<Point, Char>, val moveCounts: Map<Char, Int> = mapOf()) {
        fun key() = positions.map { it.toString() }.sorted().joinToString()
        fun cost(): Long {
            val a = (moveCounts['A'] ?: 0) * 1L
            val b = (moveCounts['B'] ?: 0) * 10L
            val c = (moveCounts['C'] ?: 0) * 100L
            val d = (moveCounts['D'] ?: 0) * 1000L
            return a + b + c + d
        }
    }

    data class Point(val x: Int, val y: Int) {
        operator fun plus(other: Point): Point {
            return Point(this.x + other.x, this.y + other.y)
        }
    }

    private val ALWAYS_INVALID_STOPS = listOf(
            Point(3, 1),
            Point(5, 1),
            Point(7, 1),
            Point(9, 1),
    )
}


