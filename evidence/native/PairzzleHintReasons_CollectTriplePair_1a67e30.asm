// Data.Pairzzle.PairzzleHintReasons.CollectTriplePair token=0x6000fe9 VA=0x1a67e30
01a67e30: stp      x29, x30, [sp, #-0x60]!
01a67e34: stp      x28, x27, [sp, #0x10]
01a67e38: stp      x26, x25, [sp, #0x20]
01a67e3c: stp      x24, x23, [sp, #0x30]
01a67e40: stp      x22, x21, [sp, #0x40]
01a67e44: stp      x20, x19, [sp, #0x50]
01a67e48: adrp     x29, #0x2387000
01a67e4c: adrp     x28, #0x21f1000
01a67e50: adrp     x27, #0x21f1000
01a67e54: ldrb     w8, [x29, #0xccd]
01a67e58: ldr      x28, [x28, #0x688]
01a67e5c: ldr      x27, [x27, #0x690]
01a67e60: mov      w26, w7
01a67e64: mov      w19, w6
01a67e68: mov      w20, w5
01a67e6c: mov      w21, w4
01a67e70: mov      w22, w3
01a67e74: mov      w23, w2
01a67e78: mov      x24, x1
01a67e7c: mov      x25, x0
01a67e80: tbnz     w8, #0, #0x1a67ebc
01a67e84: adrp     x0, #0x21f1000
01a67e88: ldr      x0, [x0, #0x3f0]
01a67e8c: bl       #0xe54c48 ;
01a67e90: adrp     x0, #0x21f1000
01a67e94: ldr      x0, [x0, #0x690]
01a67e98: bl       #0xe54c48 ;
01a67e9c: adrp     x0, #0x220b000
01a67ea0: ldr      x0, [x0, #0x218]
01a67ea4: bl       #0xe54c48 ;
01a67ea8: adrp     x0, #0x21f1000
01a67eac: ldr      x0, [x0, #0x688]
01a67eb0: bl       #0xe54c48 ;
01a67eb4: mov      w8, #1
01a67eb8: strb     w8, [x29, #0xccd]
01a67ebc: ldr      x0, [x28]
01a67ec0: and      w29, w26, #0xff
01a67ec4: bl       #0xe54e9c ;
01a67ec8: ldr      x2, [x27]
01a67ecc: mov      w1, #2
01a67ed0: mov      x26, x0
01a67ed4: bl       #0x140403c ;
01a67ed8: mov      w28, wzr
01a67edc: add      w8, w20, w28
01a67ee0: tbz      w21, #0, #0x1a67ef0
01a67ee4: mov      w9, w23
01a67ee8: cbnz     x25, #0x1a67efc
01a67eec: b        #0x1a67fe4 ;
01a67ef0: mov      w9, w8
01a67ef4: mov      w8, w22
01a67ef8: cbz      x25, #0x1a67fe4
01a67efc: ldr      w10, [x25, #0x10]
01a67f00: madd     w27, w10, w9, w8
01a67f04: cmp      w27, w19
01a67f08: b.eq     #0x1a67fa4
01a67f0c: mov      x0, x25
01a67f10: mov      w1, w27
01a67f14: bl       #0x1a609fc ; PairzzlePuzzle.IsHole
01a67f18: tbnz     w0, #0, #0x1a67fc4
01a67f1c: cbz      x24, #0x1a67fe4
01a67f20: ldr      x8, [x24, #0x18]
01a67f24: cbz      x8, #0x1a67fe4
01a67f28: ldr      w9, [x8, #0x18]
01a67f2c: cmp      w27, w9
01a67f30: b.hs     #0x1a67fe8
01a67f34: add      x8, x8, w27, sxtw
01a67f38: ldrb     w8, [x8, #0x20]
01a67f3c: cmp      w8, w29
01a67f40: b.ne     #0x1a67fc4
01a67f44: cbz      x26, #0x1a67fe4
01a67f48: adrp     x9, #0x21f1000
01a67f4c: ldr      w10, [x26, #0x1c]
01a67f50: ldr      x8, [x26, #0x10]
01a67f54: ldr      x9, [x9, #0x3f0]
01a67f58: add      w10, w10, #1
01a67f5c: ldr      x9, [x9]
01a67f60: str      w10, [x26, #0x1c]
01a67f64: cbz      x8, #0x1a67fe4
01a67f68: ldrsw    x10, [x26, #0x18]
01a67f6c: ldr      w11, [x8, #0x18]
01a67f70: cmp      w10, w11
01a67f74: b.hs     #0x1a67f8c
01a67f78: add      x8, x8, x10, lsl #2
01a67f7c: add      w9, w10, #1
01a67f80: str      w9, [x26, #0x18]
01a67f84: str      w27, [x8, #0x20]
01a67f88: b        #0x1a67fa4 ;
01a67f8c: ldr      x8, [x9, #0x20]
01a67f90: mov      x0, x26
01a67f94: mov      w1, w27
01a67f98: ldr      x8, [x8, #0xc0]
01a67f9c: ldr      x2, [x8, #0x70]
01a67fa0: bl       #0x1404854 ;
01a67fa4: add      w28, w28, #1
01a67fa8: cmp      w28, #3
01a67fac: b.ne     #0x1a67edc
01a67fb0: cbz      x26, #0x1a67fe4
01a67fb4: ldr      w8, [x26, #0x18]
01a67fb8: cmp      w8, #2
01a67fbc: csel     x0, x26, xzr, eq
01a67fc0: b        #0x1a67fc8 ;
01a67fc4: mov      x0, xzr
01a67fc8: ldp      x20, x19, [sp, #0x50]
01a67fcc: ldp      x22, x21, [sp, #0x40]
01a67fd0: ldp      x24, x23, [sp, #0x30]
01a67fd4: ldp      x26, x25, [sp, #0x20]
01a67fd8: ldp      x28, x27, [sp, #0x10]
01a67fdc: ldp      x29, x30, [sp], #0x60
01a67fe0: ret
01a67fe4: bl       #0xe54eac ;
01a67fe8: bl       #0xe54eb4 ;
