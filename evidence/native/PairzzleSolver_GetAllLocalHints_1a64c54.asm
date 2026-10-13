// Data.Pairzzle.PairzzleSolver.GetAllLocalHints token=0x600105d VA=0x1a64c54
01a64c54: stp      x29, x30, [sp, #-0x60]!
01a64c58: stp      x28, x27, [sp, #0x10]
01a64c5c: stp      x26, x25, [sp, #0x20]
01a64c60: stp      x24, x23, [sp, #0x30]
01a64c64: stp      x22, x21, [sp, #0x40]
01a64c68: stp      x20, x19, [sp, #0x50]
01a64c6c: adrp     x21, #0x2387000
01a64c70: adrp     x23, #0x2212000
01a64c74: adrp     x20, #0x2212000
01a64c78: ldrb     w8, [x21, #0xd23]
01a64c7c: ldr      x23, [x23, #0xa8]
01a64c80: ldr      x20, [x20, #0xb0]
01a64c84: mov      x19, x1
01a64c88: mov      x22, x0
01a64c8c: tbnz     w8, #0, #0x1a64cd4
01a64c90: adrp     x0, #0x2212000
01a64c94: ldr      x0, [x0, #0xb8]
01a64c98: bl       #0xe54c48 ;
01a64c9c: adrp     x0, #0x2212000
01a64ca0: ldr      x0, [x0, #0xb0]
01a64ca4: bl       #0xe54c48 ;
01a64ca8: adrp     x0, #0x220b000
01a64cac: ldr      x0, [x0, #0x218]
01a64cb0: bl       #0xe54c48 ;
01a64cb4: adrp     x0, #0x220b000
01a64cb8: ldr      x0, [x0, #0x2f8]
01a64cbc: bl       #0xe54c48 ;
01a64cc0: adrp     x0, #0x2212000
01a64cc4: ldr      x0, [x0, #0xa8]
01a64cc8: bl       #0xe54c48 ;
01a64ccc: mov      w8, #1
01a64cd0: strb     w8, [x21, #0xd23]
01a64cd4: ldr      x0, [x23]
01a64cd8: bl       #0xe54e9c ;
01a64cdc: ldr      x1, [x20]
01a64ce0: mov      x20, x0
01a64ce4: bl       #0x145ca90 ;
01a64ce8: mov      x0, x22
01a64cec: bl       #0x1a6d978 ; PairzzleSolver.CollectEditableEmpties
01a64cf0: cbz      x22, #0x1a64e34
01a64cf4: mov      x21, x0
01a64cf8: mov      x0, x22
01a64cfc: bl       #0x1a6128c ; PairzzleBoardState.Clone
01a64d00: cbz      x21, #0x1a64e34
01a64d04: ldr      w8, [x21, #0x18]
01a64d08: cmp      w8, #1
01a64d0c: b.lt     #0x1a64e14
01a64d10: adrp     x26, #0x220b000
01a64d14: mov      x22, x0
01a64d18: mov      w23, wzr
01a64d1c: ldr      x26, [x26, #0x2f8]
01a64d20: mov      w28, #1
01a64d24: ldr      x2, [x26]
01a64d28: mov      x0, x21
01a64d2c: mov      w1, w23
01a64d30: bl       #0x140455c ;
01a64d34: cbz      x22, #0x1a64e34
01a64d38: mov      w24, w0
01a64d3c: mov      x27, xzr
01a64d40: mov      w8, #1
01a64d44: tst      w8, #1
01a64d48: mov      x0, x22
01a64d4c: mov      w1, w24
01a64d50: cinc     w2, w28, eq
01a64d54: mov      w29, w8
01a64d58: bl       #0x1a60bec ; PairzzleBoardState.Set
01a64d5c: mov      x0, x19
01a64d60: mov      x1, x22
01a64d64: mov      w2, w24
01a64d68: bl       #0x1a6dabc ; PairzzleSolver.CausesOwnViolation
01a64d6c: mov      w25, w0
01a64d70: mov      x0, x22
01a64d74: mov      w1, w24
01a64d78: mov      w2, wzr
01a64d7c: bl       #0x1a60bec ; PairzzleBoardState.Set
01a64d80: tbnz     w25, #0, #0x1a64d94
01a64d84: mov      w8, wzr
01a64d88: mov      x27, #0x100000000
01a64d8c: tbnz     w29, #0, #0x1a64d44
01a64d90: b        #0x1a64e04 ;
01a64d94: tst      w29, #1
01a64d98: mov      x8, #0x200000000
01a64d9c: csel     x8, x8, x27, ne
01a64da0: cbz      x20, #0x1a64e34
01a64da4: adrp     x10, #0x2212000
01a64da8: ldr      w11, [x20, #0x1c]
01a64dac: ldr      x9, [x20, #0x10]
01a64db0: ldr      x10, [x10, #0xb8]
01a64db4: add      w11, w11, #1
01a64db8: ldr      x10, [x10]
01a64dbc: str      w11, [x20, #0x1c]
01a64dc0: cbz      x9, #0x1a64e34
01a64dc4: ldrsw    x11, [x20, #0x18]
01a64dc8: ldr      w12, [x9, #0x18]
01a64dcc: mov      w13, w24
01a64dd0: orr      x1, x8, x13
01a64dd4: cmp      w11, w12
01a64dd8: b.hs     #0x1a64df0
01a64ddc: add      x9, x9, x11, lsl #3
01a64de0: add      w8, w11, #1
01a64de4: str      w8, [x20, #0x18]
01a64de8: str      x1, [x9, #0x20]
01a64dec: b        #0x1a64e04 ;
01a64df0: ldr      x8, [x10, #0x20]
01a64df4: mov      x0, x20
01a64df8: ldr      x8, [x8, #0xc0]
01a64dfc: ldr      x2, [x8, #0x70]
01a64e00: bl       #0x145d31c ;
01a64e04: ldr      w8, [x21, #0x18]
01a64e08: add      w23, w23, #1
01a64e0c: cmp      w23, w8
01a64e10: b.lt     #0x1a64d24
01a64e14: mov      x0, x20
01a64e18: ldp      x20, x19, [sp, #0x50]
01a64e1c: ldp      x22, x21, [sp, #0x40]
01a64e20: ldp      x24, x23, [sp, #0x30]
01a64e24: ldp      x26, x25, [sp, #0x20]
01a64e28: ldp      x28, x27, [sp, #0x10]
01a64e2c: ldp      x29, x30, [sp], #0x60
01a64e30: ret
01a64e34: bl       #0xe54eac ;
