import scala.Option;
import scala.Tuple2;

import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

public class Day22Java {

    public static Long computePart2(List<Day22.Command> commands) {
        List<Day22.Command> intermediateCubes = new LinkedList<>();

        // List starts out empty
        // Process ON
        // Add any ON commands to the list
        // If ON overlaps with any past ONs then add an OFF for the overlap
        // If ON overlaps with any past OFFs then add an ON for the overlap
        // Process OFF
        // For any past ONs add an OFF for the overlap
        // For any past OFFs add an ON for the overlap

        for (Day22.Command command : commands) {
            LinkedList<Day22.Command> additions = new LinkedList<>();
            for (Day22.Command ic : intermediateCubes) {
                if (State.ON.equals(command.state())) {
                    Option<Tuple2<Day22.Point, Day22.Point>> overlap = Day22.computeOverlap(command.minValues(), command.maxValues(), ic.minValues(), ic.maxValues());

                    if (overlap.nonEmpty()) {
                        if (State.ON.equals(ic.state())) {
                            additions.add(new Day22.Command(State.OFF, overlap.get()._1(), overlap.get()._2));
                        } else {
                            additions.add(new Day22.Command(State.ON, overlap.get()._1, overlap.get()._2));
                        }
                    }
                    intermediateCubes.addAll(additions);
                    intermediateCubes.add(command);
                } else {
//                    intermediateCubes.foreach(ic = > {
//                            val overlap = computeOverlap(command.minValues, command.maxValues, ic.minValues, ic.maxValues)
//                    if (overlap.nonEmpty) {
//                        if (ic.state == ON) {
//                            additions.add(Command(OFF, overlap.get._1, overlap.get._2))
//                        } else {
//                            additions.add(Command(ON, overlap.get._1, overlap.get._2))
//                        }
//                    }
//        })
//                    additions.foreach(a = > intermediateCubes.add(a))
//
//                }
                }
            }
        }


        return intermediateCubes.stream().mapToLong(c -> {
            if (c.state() == State.ON) {
                return Day22.cubeSize(c.minValues(), c.maxValues());
            } else {
                return -1 * Day22.cubeSize(c.minValues(), c.maxValues());
            }
        }).sum();
    }

}
