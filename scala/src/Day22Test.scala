//import Day22.{Command, Point, computePart2}
//import org.junit.Test
//import org.junit.Assert.assertEquals
//
//import java.util
//import java.util.Arrays.asList
//
//class Day22Test {
//  @Test
//  def testSubtractionSorted(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 10)
//    val minB = Day22.Point(5, 5, 5)
//    val maxB = Day22.Point(11, 11, 11)
//    val diff = Day22.subtractCubes(minA, maxA, minB, maxB)
//    assertEquals(875, diff)
//  }
//
//  @Test
//  def testSubtractionReverse(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 10)
//    val minB = Day22.Point(5, 5, 5)
//    val maxB = Day22.Point(11, 11, 11)
//    val diff = Day22.subtractCubes(minB, maxB, minA, maxA)
//    assertEquals(91, diff)
//  }
//
//  @Test
//  def testSubtractionSame(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 10)
//    val minB = Day22.Point(0, 0, 0)
//    val maxB = Day22.Point(10, 10, 10)
//    val diff = Day22.subtractCubes(minB, maxB, minA, maxA)
//    assertEquals(0, diff)
//  }
//
//  @Test
//  def testSubtractionFullyEnclosed(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 10)
//    val minB = Day22.Point(2, 2, 2)
//    val maxB = Day22.Point(8, 8, 8)
//    val diff = Day22.subtractCubes(minB, maxB, minA, maxA)
//    assertEquals(0, diff)
//  }
//
//  @Test
//  def testSubtractionFullyInside(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 10)
//    val minB = Day22.Point(2, 2, 2)
//    val maxB = Day22.Point(8, 8, 8)
//    val diff = Day22.subtractCubes(minA, maxA, minB, maxB)
//    assertEquals(784, diff)
//  }
//
//  @Test
//  def testSubtractionDisjoint(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 10)
//    val minB = Day22.Point(11, 11, 11)
//    val maxB = Day22.Point(12, 12, 12)
//    //        val diff = Day22.subtractCubes(minB, maxB, minA, maxA)
//    val diff = Day22.subtractCubes(minA, maxA, minB, maxB)
//    assertEquals(1000, diff)
//  }
//
//  @Test
//  def testSubtractionDisjointReverse(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 10)
//    val minB = Day22.Point(11, 11, 11)
//    val maxB = Day22.Point(12, 12, 12)
//    //        val diff = Day22.subtractCubes(minB, maxB, minA, maxA)
//    val diff = Day22.subtractCubes(minB, maxB, minA, maxA)
//    assertEquals(1, diff)
//  }
//
//  @Test
//  def testContrivedExample(): Unit = {
//    val commands = List.newBuilder[Command]
//    commands += Command(State.ON, Point(0, 0, 0), Point(5, 8, 1))
//    commands += Command(State.OFF, Point(2, 2, 0), Point(7, 6, 1))
//    commands += Command(State.ON, Point(4, 4, 0), Point(7, 7, 1))
//    commands += Command(State.OFF, Point(3, 3, 0), Point(6, 6, 1))
//
//    val part2 = Day22Java.computePart2(asList(commands.result()))
//    assertEquals(32, part2)
//  }
//
//  @Test
//  def testContrivedExampleAddOnly(): Unit = {
//    val commands = List.newBuilder[Command]
//    commands += Command(State.ON, Point(0, 0, 0), Point(10, 10, 1))
//    commands += Command(State.ON, Point(8, 8, 0), Point(12, 12, 1))
//
//    val part2 = Day22Java.computePart2(asList(commands.result()))
//    assertEquals(112, part2)
//  }
//
//  @Test
//  def testPart2Example(): Unit = {
//
//    val commands = Day22.parseLines(longerPart2Example().split("\n").toList)
//    //    commands += Command(State.ON, Point(0, 0, 0), Point(10, 10, 1))
//    //    commands += Command(State.OFF, Point(-1, -1, 0), Point(11, 5, 1))
//    //    commands += Command(State.ON, Point(0, 0, 0), Point(10, 10, 1))
//    //    commands += Command(State.OFF, Point(-1, 5, 0), Point(11, 15, 1))
//
//    val part2 = Day22Java.computePart2(asList(commands))
//    assertEquals(2758514936282235L, part2)
//  }
//
//  @Test
//  def testContrivedExampleSubtractAll(): Unit = {
//    val commands = List.newBuilder[Command]
//    commands += Command(State.ON, Point(0, 0, 0), Point(2, 2, 1))
//    commands += Command(State.ON, Point(1, 1, 0), Point(3, 3, 1))
//    commands += Command(State.OFF, Point(0, 0, -1), Point(1, 1, 2))
//    commands += Command(State.OFF, Point(1, 1, -1), Point(2, 2, 2))
//
////    commands += Command(State.ON, Point(11, 11, 0), Point(12, 12, 1))
////    commands += Command(State.ON, Point(5, 5, 0), Point(15, 15, 1))
////    commands += Command(State.OFF, Point(0, 0, 0), Point(10, 10, 1))
////    commands += Command(State.ON, Point(1, 1, 0), Point(9, 9, 1))
////    commands += Command(State.OFF, Point(0, 0, 0), Point(20, 20, 1))
////    commands += Command(State.ON, Point(0, 0, 0), Point(10, 10, 1))
//
//    val part2 = Day22Java.computePart2(asList(commands.result()))
//    assertEquals(7L, part2)
//  }
//
//  @Test
//  def testAddOverlappingCubes(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(5, 8, 1)
//    val minB = Day22.Point(4, 4, 0)
//    val maxB = Day22.Point(7, 7, 1)
//    assertEquals(46, Day22.addCubes(minA, maxA, minB, maxB))
//  }
//
//  @Test
//  def testAddFullyOverlappingCubes(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(5, 8, 1)
//    val minB = Day22.Point(1, 1, 0)
//    val maxB = Day22.Point(2, 2, 1)
//    assertEquals(40, Day22.addCubes(minA, maxA, minB, maxB))
//  }
//
//  @Test
//  def testAddDisjointOverlappingCubes(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(5, 8, 1)
//    val minB = Day22.Point(10, 10, 0)
//    val maxB = Day22.Point(11, 11, 1)
//    assertEquals(41, Day22.addCubes(minA, maxA, minB, maxB))
//  }
//
//  def longerPart2Example() = {
//    "on x=-5..47,y=-31..22,z=-19..33\non x=-44..5,y=-27..21,z=-14..35\non x=-49..-1,y=-11..42,z=-10..38\non x=-20..34,y=-40..6,z=-44..1\noff x=26..39,y=40..50,z=-2..11\non x=-41..5,y=-41..6,z=-36..8\noff x=-43..-33,y=-45..-28,z=7..25\non x=-33..15,y=-32..19,z=-34..11\noff x=35..47,y=-46..-34,z=-11..5\non x=-14..36,y=-6..44,z=-16..29\non x=-57795..-6158,y=29564..72030,z=20435..90618\non x=36731..105352,y=-21140..28532,z=16094..90401\non x=30999..107136,y=-53464..15513,z=8553..71215\non x=13528..83982,y=-99403..-27377,z=-24141..23996\non x=-72682..-12347,y=18159..111354,z=7391..80950\non x=-1060..80757,y=-65301..-20884,z=-103788..-16709\non x=-83015..-9461,y=-72160..-8347,z=-81239..-26856\non x=-52752..22273,y=-49450..9096,z=54442..119054\non x=-29982..40483,y=-108474..-28371,z=-24328..38471\non x=-4958..62750,y=40422..118853,z=-7672..65583\non x=55694..108686,y=-43367..46958,z=-26781..48729\non x=-98497..-18186,y=-63569..3412,z=1232..88485\non x=-726..56291,y=-62629..13224,z=18033..85226\non x=-110886..-34664,y=-81338..-8658,z=8914..63723\non x=-55829..24974,y=-16897..54165,z=-121762..-28058\non x=-65152..-11147,y=22489..91432,z=-58782..1780\non x=-120100..-32970,y=-46592..27473,z=-11695..61039\non x=-18631..37533,y=-124565..-50804,z=-35667..28308\non x=-57817..18248,y=49321..117703,z=5745..55881\non x=14781..98692,y=-1341..70827,z=15753..70151\non x=-34419..55919,y=-19626..40991,z=39015..114138\non x=-60785..11593,y=-56135..2999,z=-95368..-26915\non x=-32178..58085,y=17647..101866,z=-91405..-8878\non x=-53655..12091,y=50097..105568,z=-75335..-4862\non x=-111166..-40997,y=-71714..2688,z=5609..50954\non x=-16602..70118,y=-98693..-44401,z=5197..76897\non x=16383..101554,y=4615..83635,z=-44907..18747\noff x=-95822..-15171,y=-19987..48940,z=10804..104439\non x=-89813..-14614,y=16069..88491,z=-3297..45228\non x=41075..99376,y=-20427..49978,z=-52012..13762\non x=-21330..50085,y=-17944..62733,z=-112280..-30197\non x=-16478..35915,y=36008..118594,z=-7885..47086\noff x=-98156..-27851,y=-49952..43171,z=-99005..-8456\noff x=2032..69770,y=-71013..4824,z=7471..94418\non x=43670..120875,y=-42068..12382,z=-24787..38892\noff x=37514..111226,y=-45862..25743,z=-16714..54663\noff x=25699..97951,y=-30668..59918,z=-15349..69697\noff x=-44271..17935,y=-9516..60759,z=49131..112598\non x=-61695..-5813,y=40978..94975,z=8655..80240\noff x=-101086..-9439,y=-7088..67543,z=33935..83858\noff x=18020..114017,y=-48931..32606,z=21474..89843\noff x=-77139..10506,y=-89994..-18797,z=-80..59318\noff x=8476..79288,y=-75520..11602,z=-96624..-24783\non x=-47488..-1262,y=24338..100707,z=16292..72967\noff x=-84341..13987,y=2429..92914,z=-90671..-1318\noff x=-37810..49457,y=-71013..-7894,z=-105357..-13188\noff x=-27365..46395,y=31009..98017,z=15428..76570\noff x=-70369..-16548,y=22648..78696,z=-1892..86821\non x=-53470..21291,y=-120233..-33476,z=-44150..38147\noff x=-93533..-4276,y=-16170..68771,z=-104985..-24507"
//  }
//
//  @Test
//  def testFindOverlapCubes1(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 1)
//    val minB = Day22.Point(-1, -1, 0)
//    val maxB = Day22.Point(11, 11, 1)
//    assertEquals(Some((Point(0, 0, 0), Point(10, 10, 1))), Day22.computeOverlap(minA, maxA, minB, maxB))
//    assertEquals(Some((Point(0, 0, 0), Point(10, 10, 1))), Day22.computeOverlap(minB, maxB, minA, maxA))
//  }
//
//  @Test
//  def testFindOverlapCubes2(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 1)
//    val minB = Day22.Point(10, 10, 0)
//    val maxB = Day22.Point(11, 11, 1)
//    assertEquals(None, Day22.computeOverlap(minA, maxA, minB, maxB))
//    assertEquals(None, Day22.computeOverlap(minB, maxB, minA, maxA))
//  }
//
//  @Test
//  def testFindOverlapCubes3(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 1)
//    val minB = Day22.Point(2, 2, 0)
//    val maxB = Day22.Point(8, 8, 1)
//    assertEquals(Some((Point(2, 2, 0), Point(8, 8, 1))), Day22.computeOverlap(minA, maxA, minB, maxB))
//    assertEquals(Some((Point(2, 2, 0), Point(8, 8, 1))), Day22.computeOverlap(minB, maxB, minA, maxA))
//  }
//
//  @Test
//  def testFindOverlapCubes4(): Unit = {
//    val minA = Day22.Point(0, 0, -1)
//    val maxA = Day22.Point(10, 10, 2)
//    val minB = Day22.Point(0, 0, 0)
//    val maxB = Day22.Point(10, 10, 1)
//    assertEquals(Some((Point(0, 0, 0), Point(10, 10, 1))), Day22.computeOverlap(minA, maxA, minB, maxB))
//    assertEquals(Some((Point(0, 0, 0), Point(10, 10, 1))), Day22.computeOverlap(minB, maxB, minA, maxA))
//  }
//
//  @Test
//  def testFindOverlapCubes5(): Unit = {
//    val minA = Day22.Point(0, 0, 0)
//    val maxA = Day22.Point(10, 10, 1)
//    val minB = Day22.Point(2, 2, -5)
//    val maxB = Day22.Point(8, 8, 10)
//    assertEquals(Some((Point(2, 2, 0), Point(8, 8, 1))), Day22.computeOverlap(minA, maxA, minB, maxB))
//    assertEquals(Some((Point(2, 2, 0), Point(8, 8, 1))), Day22.computeOverlap(minB, maxB, minA, maxA))
//  }
//}