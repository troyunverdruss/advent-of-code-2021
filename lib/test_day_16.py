from unittest import TestCase

from lib.day_16 import parse_hex_to_bits, parse_packet, Packet, ParsePacketResult, compute_version_sum, \
    compute_packet_value


class Test(TestCase):
    def test_parse_input(self):
        self.assertEqual("110100101111111000101000", parse_hex_to_bits("D2FE28"))
        self.assertEqual("00111000000000000110111101000101001010010001001000000000",
                         parse_hex_to_bits("38006F45291200"))

    def test_parse_handle_type_4_literal(self):
        parse_packet_result = parse_packet("110100101111111000101000")

        self.assertEqual("000", parse_packet_result.remainder_bits)
        self.assertEqual(6, parse_packet_result.packet.version)
        self.assertEqual(4, parse_packet_result.packet.type_id)
        self.assertEqual(2021, parse_packet_result.packet.literal_value)
        self.assertEqual([], parse_packet_result.packet.sub_packets)

    def test_parse_handle_operator_0(self):
        bits = parse_hex_to_bits("38006F45291200")
        parse_packet_result = parse_packet(bits)

        self.assertEqual("0000000", parse_packet_result.remainder_bits)
        self.assertEqual(1, parse_packet_result.packet.version)
        self.assertEqual(6, parse_packet_result.packet.type_id)
        self.assertEqual(None, parse_packet_result.packet.literal_value)
        self.assertEqual(2, len(parse_packet_result.packet.sub_packets))

        self.assertEqual(6, parse_packet_result.packet.sub_packets[0].version)
        self.assertEqual(4, parse_packet_result.packet.sub_packets[0].type_id)
        self.assertEqual(10, parse_packet_result.packet.sub_packets[0].literal_value)

        self.assertEqual(2, parse_packet_result.packet.sub_packets[1].version)
        self.assertEqual(4, parse_packet_result.packet.sub_packets[1].type_id)
        self.assertEqual(20, parse_packet_result.packet.sub_packets[1].literal_value)

    def test_parse_handle_operator_1(self):
        bits = parse_hex_to_bits("EE00D40C823060")
        parse_packet_result = parse_packet(bits)

        self.assertEqual("00000", parse_packet_result.remainder_bits)
        self.assertEqual(7, parse_packet_result.packet.version)
        self.assertEqual(3, parse_packet_result.packet.type_id)
        self.assertEqual(None, parse_packet_result.packet.literal_value)
        self.assertEqual(3, len(parse_packet_result.packet.sub_packets))

        self.assertEqual(2, parse_packet_result.packet.sub_packets[0].version)
        self.assertEqual(4, parse_packet_result.packet.sub_packets[0].type_id)
        self.assertEqual(1, parse_packet_result.packet.sub_packets[0].literal_value)

        self.assertEqual(4, parse_packet_result.packet.sub_packets[1].version)
        self.assertEqual(4, parse_packet_result.packet.sub_packets[1].type_id)
        self.assertEqual(2, parse_packet_result.packet.sub_packets[1].literal_value)

        self.assertEqual(1, parse_packet_result.packet.sub_packets[2].version)
        self.assertEqual(4, parse_packet_result.packet.sub_packets[2].type_id)
        self.assertEqual(3, parse_packet_result.packet.sub_packets[2].literal_value)

    def test_part_1_compute_version_sum_1(self):
        bits = parse_hex_to_bits("8A004A801A8002F478")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(16, compute_version_sum(parse_packet_result.packet))

    def test_part_1_compute_version_sum_2(self):
        bits = parse_hex_to_bits("620080001611562C8802118E34")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(12, compute_version_sum(parse_packet_result.packet))

    def test_part_1_compute_version_sum_3(self):
        bits = parse_hex_to_bits("C0015000016115A2E0802F182340")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(23, compute_version_sum(parse_packet_result.packet))

    def test_part_1_compute_version_sum_4(self):
        bits = parse_hex_to_bits("A0016C880162017C3686B18A3D4780")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(31, compute_version_sum(parse_packet_result.packet))

    def test_part2_compute_value_1(self):
        bits = parse_hex_to_bits("C200B40A82")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(3, compute_packet_value(parse_packet_result.packet))

    def test_part2_compute_value_2(self):
        bits = parse_hex_to_bits("04005AC33890")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(54, compute_packet_value(parse_packet_result.packet))

    def test_part2_compute_value_3(self):
        bits = parse_hex_to_bits("880086C3E88112")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(7, compute_packet_value(parse_packet_result.packet))

    def test_part2_compute_value_4(self):
        bits = parse_hex_to_bits("CE00C43D881120")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(9, compute_packet_value(parse_packet_result.packet))

    def test_part2_compute_value_5(self):
        bits = parse_hex_to_bits("D8005AC2A8F0")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(1, compute_packet_value(parse_packet_result.packet))

    def test_part2_compute_value_6(self):
        bits = parse_hex_to_bits("F600BC2D8F")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(0, compute_packet_value(parse_packet_result.packet))

    def test_part2_compute_value_7(self):
        bits = parse_hex_to_bits("9C005AC2F8F0")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(0, compute_packet_value(parse_packet_result.packet))

    def test_part2_compute_value_8(self):
        bits = parse_hex_to_bits("9C0141080250320F1802104A08")
        parse_packet_result = parse_packet(bits)
        self.assertEqual(1, compute_packet_value(parse_packet_result.packet))

