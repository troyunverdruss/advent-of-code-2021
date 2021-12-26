import Day22Kt.computePart2
import org.junit.Test
import org.junit.jupiter.api.Assertions.*
import java.lang.RuntimeException

internal class Day22KtKtTest {
    @Test
    fun `verify constrained part 2`() {
        val raw = "on x=-5..47,y=-31..22,z=-19..33\non x=-44..5,y=-27..21,z=-14..35\non x=-49..-1,y=-11..42,z=-10..38\non x=-20..34,y=-40..6,z=-44..1\noff x=26..39,y=40..50,z=-2..11\non x=-41..5,y=-41..6,z=-36..8\noff x=-43..-33,y=-45..-28,z=7..25\non x=-33..15,y=-32..19,z=-34..11\noff x=35..47,y=-46..-34,z=-11..5\non x=-14..36,y=-6..44,z=-16..29\non x=-57795..-6158,y=29564..72030,z=20435..90618\non x=36731..105352,y=-21140..28532,z=16094..90401\non x=30999..107136,y=-53464..15513,z=8553..71215\non x=13528..83982,y=-99403..-27377,z=-24141..23996\non x=-72682..-12347,y=18159..111354,z=7391..80950\non x=-1060..80757,y=-65301..-20884,z=-103788..-16709\non x=-83015..-9461,y=-72160..-8347,z=-81239..-26856\non x=-52752..22273,y=-49450..9096,z=54442..119054\non x=-29982..40483,y=-108474..-28371,z=-24328..38471\non x=-4958..62750,y=40422..118853,z=-7672..65583\non x=55694..108686,y=-43367..46958,z=-26781..48729\non x=-98497..-18186,y=-63569..3412,z=1232..88485\non x=-726..56291,y=-62629..13224,z=18033..85226\non x=-110886..-34664,y=-81338..-8658,z=8914..63723\non x=-55829..24974,y=-16897..54165,z=-121762..-28058\non x=-65152..-11147,y=22489..91432,z=-58782..1780\non x=-120100..-32970,y=-46592..27473,z=-11695..61039\non x=-18631..37533,y=-124565..-50804,z=-35667..28308\non x=-57817..18248,y=49321..117703,z=5745..55881\non x=14781..98692,y=-1341..70827,z=15753..70151\non x=-34419..55919,y=-19626..40991,z=39015..114138\non x=-60785..11593,y=-56135..2999,z=-95368..-26915\non x=-32178..58085,y=17647..101866,z=-91405..-8878\non x=-53655..12091,y=50097..105568,z=-75335..-4862\non x=-111166..-40997,y=-71714..2688,z=5609..50954\non x=-16602..70118,y=-98693..-44401,z=5197..76897\non x=16383..101554,y=4615..83635,z=-44907..18747\noff x=-95822..-15171,y=-19987..48940,z=10804..104439\non x=-89813..-14614,y=16069..88491,z=-3297..45228\non x=41075..99376,y=-20427..49978,z=-52012..13762\non x=-21330..50085,y=-17944..62733,z=-112280..-30197\non x=-16478..35915,y=36008..118594,z=-7885..47086\noff x=-98156..-27851,y=-49952..43171,z=-99005..-8456\noff x=2032..69770,y=-71013..4824,z=7471..94418\non x=43670..120875,y=-42068..12382,z=-24787..38892\noff x=37514..111226,y=-45862..25743,z=-16714..54663\noff x=25699..97951,y=-30668..59918,z=-15349..69697\noff x=-44271..17935,y=-9516..60759,z=49131..112598\non x=-61695..-5813,y=40978..94975,z=8655..80240\noff x=-101086..-9439,y=-7088..67543,z=33935..83858\noff x=18020..114017,y=-48931..32606,z=21474..89843\noff x=-77139..10506,y=-89994..-18797,z=-80..59318\noff x=8476..79288,y=-75520..11602,z=-96624..-24783\non x=-47488..-1262,y=24338..100707,z=16292..72967\noff x=-84341..13987,y=2429..92914,z=-90671..-1318\noff x=-37810..49457,y=-71013..-7894,z=-105357..-13188\noff x=-27365..46395,y=31009..98017,z=15428..76570\noff x=-70369..-16548,y=22648..78696,z=-1892..86821\non x=-53470..21291,y=-120233..-33476,z=-44150..38147\noff x=-93533..-4276,y=-16170..68771,z=-104985..-24507"
        val commands = parseLines(raw.split("\n"))
        val constrainedCommands = constrainCommandsToInitRegion(commands)
        val result = computePart2(constrainedCommands)
        kotlin.test.assertEquals(474140, result)
//        kotlin.test.assertEquals(2758514936282235, result)
    }

    @Test
    fun `verify constrained part 1`() {
        val raw = "on x=-20..26,y=-36..17,z=-47..7\n" +
                "on x=-20..33,y=-21..23,z=-26..28\n" +
                "on x=-22..28,y=-29..23,z=-38..16\n" +
                "on x=-46..7,y=-6..46,z=-50..-1\n" +
                "on x=-49..1,y=-3..46,z=-24..28\n" +
                "on x=2..47,y=-22..22,z=-23..27\n" +
                "on x=-27..23,y=-28..26,z=-21..29\n" +
                "on x=-39..5,y=-6..47,z=-3..44\n" +
                "on x=-30..21,y=-8..43,z=-13..34\n" +
                "on x=-22..26,y=-27..20,z=-29..19\n" +
                "off x=-48..-32,y=26..41,z=-47..-37\n" +
                "on x=-12..35,y=6..50,z=-50..-2\n" +
                "off x=-48..-32,y=-32..-16,z=-15..-5\n" +
                "on x=-18..26,y=-33..15,z=-7..46\n" +
                "off x=-40..-22,y=-38..-28,z=23..41\n" +

                "on x=-16..35,y=-41..10,z=-47..6\n" +
                "off x=-32..-23,y=11..30,z=-14..3\n" +
                "on x=-49..-5,y=-3..45,z=-29..18\n" +
                "off x=18..30,y=-20..-8,z=-3..13\n" +
                "on x=-41..9,y=-7..43,z=-33..15"
        val commands = parseLines(raw.split("\n"))
        val constrainedCommands = constrainCommandsToInitRegion(commands)
        val manualCubeOn = Cube(min = Point(x = -27, y = -28, z = -21), max = Point(x = 23, y = 26, z = 29))
        val manualCubeOff = Cube(min = Point(x = -40, y = -38, z = 23), max = Point(x = -22, y = -28, z = 41))
        val manualCommands = listOf(
                Command(state = State.ON, cube = manualCubeOn),
//                Command(state = State.ON, cube = Cube(min = Point(x = -39, y = -6, z = -3), max = Point(x = 5, y = 47, z = 44))),
//                Command(state = State.ON, cube = Cube(min = Point(x = -30, y = -8, z = -13), max = Point(x = 21, y = 43, z = 34))),
//                Command(state = State.ON, cube = Cube(min = Point(x = -22, y = -27, z = -29), max = Point(x = 26, y = 20, z = 19))),
//                Command(state = State.OFF, cube = Cube(min = Point(x = -48, y = 26, z = -47), max = Point(x = -32, y = 41, z = -37))),
//                Command(state = State.ON, cube = Cube(min = Point(x = -12, y = 6, z = -50), max = Point(x = 35, y = 50, z = -2))),
//                Command(state = State.OFF, cube = Cube(min = Point(x = -48, y = -32, z = -15), max = Point(x = -32, y = -16, z = -5))),
//                Command(state = State.ON, cube = Cube(min = Point(x = -18, y = -33, z = -7), max = Point(x = 26, y = 15, z = 46))),
                Command(state = State.OFF, cube = manualCubeOff),
        )
        val part1 = calculatePart1(manualCommands)
        val part2 = computePart2(manualCommands)

        val overlap = computeOverlap(manualCubeOn, manualCubeOff) ?: throw RuntimeException()
        val overlapSize = cubeSize(overlap)
        val calculatePart1OffOverlapOnly = calculatePart1OffOverlapOnly(manualCommands)
        val overlapCrossProduct = crossProduct(overlap.min, overlap.max)




        assertEquals(part1, part2)
//        (0..constrainedCommands.lastIndex).forEach { lastIndex ->
//            println("Up to $lastIndex]")
//            println("  Command: ${constrainedCommands[6]}")
//            println("  Command: ${constrainedCommands[14]}")
//
//            val part1 = calculatePart1(constrainedCommands.subList(6, 15))
//            val part2 = computePart2(constrainedCommands.subList(6, 15))
//            assertEquals(part1, part2)
//        }
        val result = computePart2(commands)
        kotlin.test.assertEquals(590784, result)
//        kotlin.test.assertEquals(2758514936282235, result)
    }

    @Test
    fun `verify compute cube size`() {
        val cube = Cube(Point(0, 0, 0), Point(10, 10, 10))
        val part1Size = calculatePart1(listOf(Command(State.ON, cube)))
        val size = cubeSize(cube)
        assertEquals(size, part1Size)
    }

    @Test
    fun `verify simple part 2`() {
        val commands = listOf(
                Command(State.ON, Cube(Point(1, 1, 0), Point(5, 3, 1))),
                Command(State.ON, Cube(Point(4, 0, 0), Point(6, 4, 1))),
                Command(State.OFF, Cube(Point(3, 2, 0), Point(5, 5, 1))),
                Command(State.ON, Cube(Point(2, 2, 0), Point(5, 4, 1))),
                Command(State.OFF, Cube(Point(3, 2, 0), Point(5, 4, 1))),
                Command(State.OFF, Cube(Point(3, 1, 0), Point(5, 3, 1))),
                Command(State.ON, Cube(Point(1, 1, 0), Point(5, 4, 1))),

                )
        val result = computePart2(commands)
        kotlin.test.assertEquals(17, result)
    }

    @Test
    fun `verify cubes overlap correctly`() {
        val c1 = Cube(Point(0, 0, 0), Point(10, 10, 10))
        val c2 = Cube(Point(2, 2, 2), Point(8, 8, 8))
        val overlap = computeOverlap(c1, c2) ?: throw RuntimeException()
        assertEquals(216, cubeSize(overlap))
//        assertEquals(Cube(Point(0,2,2), Point(10,8,8)), overlap)
    }

    @Test
    fun `verify overlap is working`() {
        val list = listOf<Pair<Pair<Cube, Cube>, Boolean>>(
                // Simple x tests
                Pair(Pair(Cube(Point(0, 0, 0), Point(10, 1, 1)), Cube(Point(-1, 0, 0), Point(4, 1, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(10, 1, 1)), Cube(Point(7, 0, 0), Point(12, 1, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(10, 1, 1)), Cube(Point(4, 0, 0), Point(7, 1, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(10, 1, 1)), Cube(Point(-1, 0, 0), Point(11, 1, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(10, 1, 1)), Cube(Point(0, 0, 0), Point(1, 1, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(10, 1, 1)), Cube(Point(9, 0, 0), Point(10, 1, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(10, 1, 1)), Cube(Point(-1, 0, 0), Point(0, 1, 1))), false),
                Pair(Pair(Cube(Point(0, 0, 0), Point(10, 1, 1)), Cube(Point(10, 0, 0), Point(11, 1, 1))), false),

                // Simple y tests
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 10, 1)), Cube(Point(0, -1, 0), Point(1, 4, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 10, 1)), Cube(Point(0, 7, 0), Point(1, 12, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 10, 1)), Cube(Point(0, 4, 0), Point(1, 7, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 10, 1)), Cube(Point(0, -1, 0), Point(1, 11, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 10, 1)), Cube(Point(0, 0, 0), Point(1, 1, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 10, 1)), Cube(Point(0, 9, 0), Point(1, 10, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 10, 1)), Cube(Point(0, -1, 0), Point(1, 0, 1))), false),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 10, 1)), Cube(Point(0, 10, 0), Point(1, 11, 1))), false),

                // Simple z tests
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 1, 10)), Cube(Point(0, 0, -1), Point(1, 1, 4))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 1, 10)), Cube(Point(0, 0, 7), Point(1, 1, 12))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 1, 10)), Cube(Point(0, 0, 4), Point(1, 1, 7))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 1, 10)), Cube(Point(0, 0, -1), Point(1, 1, 11))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 1, 10)), Cube(Point(0, 0, 0), Point(1, 1, 1))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 1, 10)), Cube(Point(0, 0, 9), Point(1, 1, 10))), true),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 1, 10)), Cube(Point(0, 0, -1), Point(1, 1, 0))), false),
                Pair(Pair(Cube(Point(0, 0, 0), Point(1, 1, 10)), Cube(Point(0, 0, 10), Point(1, 1, 11))), false),
        )

        list.forEach { data ->
            assertEquals(data.second, cubesOverlap(data.first.first, data.first.second))
        }
    }
}