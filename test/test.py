# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge


@cocotb.test()
async def test_down_counter(dut):

    dut._log.info("Starting Down Counter Test")

    # Create clock
    clock = Clock(dut.clk, 10, unit="ns")
    cocotb.start_soon(clock.start())

    # Initialize inputs
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    # Apply reset
    dut.rst_n.value = 0

    # Wait for 2 clock cycles
    for _ in range(2):
        await RisingEdge(dut.clk)

    # Release reset
    dut.rst_n.value = 1

    dut._log.info("Reset Released")

    # Expected counter sequence
    expected_values = [
        15, 14, 13, 12,
        11, 10, 9, 8,
        7, 6, 5, 4,
        3, 2, 1, 0,
        15
    ]

    # Verify output
    for expected in expected_values:

        await RisingEdge(dut.clk)

        actual = int(dut.uo_out.value) & 0xF

        dut._log.info(
            f"Expected={expected} Actual={actual}"
        )

        assert actual == expected, \
            f"Counter mismatch: Expected {expected}, Got {actual}"

    dut._log.info("Down Counter Test Passed")
