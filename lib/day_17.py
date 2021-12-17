from dataclasses import dataclass
from functools import reduce
from typing import List, Optional

VERSION_START_OFFSET = 0
VERSION_END_OFFSET = 3
TYPE_ID_START_OFFSET = 3
TYPE_ID_END_OFFSET = 6

TYPE_4_OFFSET_START = 6

OPERATOR_TYPE_POSITION = 6
OP_LEN_START_OFFSET = 7
OP_LEN_START_OFFSET_TYPE_0 = 22
OPERATOR_LENGTH_START_OFFSET_TYPE_1 = 18


@dataclass
class Packet:
    version: int
    type_id: int
    literal_value: Optional[int]
    sub_packets: List


@dataclass
class ParsePacketResult:
    packet: Packet
    remainder_bits: str


def read_input():
    with open("input/day16.txt") as f:
        input = f.readlines()
    return input[0]


def parse_hex_to_bits(input):
    chars = list(map(lambda x: bin(int(x, 16))[2:].zfill(4), list(input.strip())))
    return "".join(chars)


def handle_type_4_packet(version, type_id, bits) -> ParsePacketResult:
    last_block_starting_index = None

    for i in range(TYPE_4_OFFSET_START, len(bits), 5):
        if bits[i] == "0":
            last_block_starting_index = i
            break

    if not last_block_starting_index:
        raise "last_block_starting_index not initialized"

    all_packet_bits = bits[TYPE_4_OFFSET_START:last_block_starting_index + 5]
    packet_bits = [x for i, x in enumerate(all_packet_bits) if i % 5 != 0]
    literal_value = int("".join(packet_bits), 2)
    return ParsePacketResult(
        Packet(version, type_id, literal_value, []),
        bits[last_block_starting_index + 5:]
    )


def handle_operator_packet(version, type_id, bits) -> ParsePacketResult:
    operator_type = bits[OPERATOR_TYPE_POSITION]
    if operator_type == "0":
        num_bits_for_sub_packets = int(bits[OP_LEN_START_OFFSET:OP_LEN_START_OFFSET + 15], 2)
        packet_bits = bits[OP_LEN_START_OFFSET_TYPE_0:OP_LEN_START_OFFSET_TYPE_0 + num_bits_for_sub_packets]
        remainder_bits = bits[OP_LEN_START_OFFSET_TYPE_0 + num_bits_for_sub_packets:]

        packets = []
        while len(packet_bits) > 0:
            parse_packet_result = parse_packet(packet_bits)
            packets.append(parse_packet_result.packet)
            packet_bits = parse_packet_result.remainder_bits

        return ParsePacketResult(
            Packet(version, type_id, None, packets),
            remainder_bits
        )
    elif operator_type == "1":
        num_packets = int(bits[OP_LEN_START_OFFSET:OP_LEN_START_OFFSET + 11], 2)
        remainder_bits = bits[OPERATOR_LENGTH_START_OFFSET_TYPE_1:]
        packets = []
        for i in range(0, num_packets):
            parse_packet_result = parse_packet(remainder_bits)
            packets.append(parse_packet_result.packet)
            remainder_bits = parse_packet_result.remainder_bits
        return ParsePacketResult(
            Packet(version, type_id, None, packets),
            remainder_bits
        )
    else:
        raise Exception(f"unknown operator type: {operator_type}")


def parse_packet(bits) -> ParsePacketResult:
    version = int(bits[VERSION_START_OFFSET:VERSION_END_OFFSET], 2)
    type_id = int(bits[TYPE_ID_START_OFFSET:TYPE_ID_END_OFFSET], 2)
    if type_id == 4:
        result = handle_type_4_packet(version, type_id, bits)
    else:
        result = handle_operator_packet(version, type_id, bits)

    return result


def compute_version_sum(packet: Packet) -> int:
    sub_packet_sum = sum(map(lambda x: compute_version_sum(x), packet.sub_packets))
    return packet.version + sub_packet_sum


def compute_packet_value(packet: Packet) -> int:
    if packet.type_id == 4:
        return packet.literal_value
    if packet.type_id == 0:
        return sum(map(lambda x: compute_packet_value(x), packet.sub_packets))
    if packet.type_id == 1:
        if len(packet.sub_packets) == 1:
            return compute_packet_value(packet.sub_packets[0])
        else:
            return reduce(lambda x, y: x * y, map(lambda x: compute_packet_value(x), packet.sub_packets))
    if packet.type_id == 2:
        return min(map(lambda x: compute_packet_value(x), packet.sub_packets))
    if packet.type_id == 3:
        return max(map(lambda x: compute_packet_value(x), packet.sub_packets))
    if packet.type_id == 5:
        a = compute_packet_value(packet.sub_packets[0])
        b = compute_packet_value(packet.sub_packets[1])
        if a > b:
            return 1
        else:
            return 0
    if packet.type_id == 6:
        a = compute_packet_value(packet.sub_packets[0])
        b = compute_packet_value(packet.sub_packets[1])
        if a < b:
            return 1
        else:
            return 0
    if packet.type_id == 7:
        a = compute_packet_value(packet.sub_packets[0])
        b = compute_packet_value(packet.sub_packets[1])
        if a == b:
            return 1
        else:
            return 0


def run():
    input = read_input()
    bits = parse_hex_to_bits(input)
    packet = parse_packet(bits)
    part1 = compute_version_sum(packet.packet)
    print(part1)

    part2 = compute_packet_value(packet.packet)
    print(part2)


if __name__ == "__main__":
    run()
