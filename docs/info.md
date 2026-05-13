## How it works

This project implements a 4-bit synchronous down counter using Verilog HDL.

The counter decreases its value by 1 on every positive edge of the clock signal.

An active-low reset (`rst_n`) is used:
- When `rst_n = 0`, the counter resets to `1111` (decimal 15).
- When `rst_n = 1`, the counter continuously counts downward.

Counter sequence:

1111 → 1110 → 1101 → 1100 → ... → 0000 → 1111

The counter output is available on:
- `uo[3:0]` → 4-bit counter output

Upper output bits `uo[7:4]` are unused and remain 0.

---

## How to test

1. Apply a clock signal to the design.
2. Keep `rst_n = 0` for a few clock cycles.
3. Release reset by setting `rst_n = 1`.
4. Observe the output pins `uo[3:0]`.

Expected behavior:
- Counter starts from `1111`
- Decrements on every clock cycle
- Wraps from `0000` back to `1111`

Example sequence:

| Clock Cycle | Output |
|-------------|--------|
| 0 | 1111 |
| 1 | 1110 |
| 2 | 1101 |
| 3 | 1100 |

---

## External hardware

No external hardware is required.

Optional:
- LEDs can be connected to `uo[3:0]` to observe the counting sequence visually.
