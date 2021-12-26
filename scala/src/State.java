import java.util.Objects;

public enum State {
    ON, OFF;

    public static State parse(String s) {
        if (Objects.equals(s, "on")) {
            return ON;
        } else if (Objects.equals(s, "off")) {
            return OFF;
        }
        throw new RuntimeException("Couldn't match state word " + s);
    }
}
