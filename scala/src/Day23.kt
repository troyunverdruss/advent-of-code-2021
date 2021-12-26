import java.io.File
import java.util.*
import kotlin.collections.HashMap
import kotlin.collections.LinkedHashMap

object Day23 {
    @JvmStatic
    fun main(args: Array<String>) {
        val grid = parseInpput(readInput())
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

    private fun winner(next: State): Boolean {
        TODO("Not yet implemented")
    }

    private fun nextOptions(state: State): List<State> {
        TODO()
    }

    fun readInput(): List<String> {
        return File("../input/day23.txt").readLines()
    }

    fun parseInpput(lines: List<String>): LinkedHashMap<Point, Char> {
        val grid = LinkedHashMap<Point, Char>()
        lines.withIndex().map { (y, line) ->
            line.withIndex().forEach { (x, p) ->
                if (p != '#') {
                    grid[Point(x, y)] = p
                }
            }
        }
        return grid
    }

    data class Point(val x: Int, val y: Int)
    data class State(val cost: Long, val grid: LinkedHashMap<Point, Char>)
}