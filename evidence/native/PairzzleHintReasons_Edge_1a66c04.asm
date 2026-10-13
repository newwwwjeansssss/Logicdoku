// Data.Pairzzle.PairzzleHintReasons.Edge token=0x6000fea VA=0x1a66c04
01a66c04: sub      sp, sp, #0x100
01a66c08: stp      x29, x30, [sp, #0xa0]
01a66c0c: stp      x28, x27, [sp, #0xb0]
01a66c10: stp      x26, x25, [sp, #0xc0]
01a66c14: stp      x24, x23, [sp, #0xd0]
01a66c18: stp      x22, x21, [sp, #0xe0]
01a66c1c: stp      x20, x19, [sp, #0xf0]
01a66c20: adrp     x24, #0x2387000
01a66c24: mov      w21, w2
01a66c28: mov      x22, x1
01a66c2c: ldrb     w9, [x24, #0xcce]
01a66c30: mov      x23, x0
01a66c34: mov      x19, x8
01a66c38: str      w3, [sp, #0x14]
01a66c3c: tbnz     w9, #0, #0x1a66ce4
01a66c40: adrp     x0, #0x21f0000
01a66c44: ldr      x0, [x0, #0x470]
01a66c48: bl       #0xe54c48 ;
01a66c4c: adrp     x0, #0x220f000
01a66c50: ldr      x0, [x0, #0x40]
01a66c54: bl       #0xe54c48 ;
01a66c58: adrp     x0, #0x220f000
01a66c5c: ldr      x0, [x0, #0x48]
01a66c60: bl       #0xe54c48 ;
01a66c64: adrp     x0, #0x2212000
01a66c68: ldr      x0, [x0, #0x148]
01a66c6c: bl       #0xe54c48 ;
01a66c70: adrp     x0, #0x2212000
01a66c74: ldr      x0, [x0, #0x100]
01a66c78: bl       #0xe54c48 ;
01a66c7c: adrp     x0, #0x2212000
01a66c80: ldr      x0, [x0, #0x108]
01a66c84: bl       #0xe54c48 ;
01a66c88: adrp     x0, #0x2212000
01a66c8c: ldr      x0, [x0, #0x60]
01a66c90: bl       #0xe54c48 ;
01a66c94: adrp     x0, #0x2212000
01a66c98: ldr      x0, [x0, #0x168]
01a66c9c: bl       #0xe54c48 ;
01a66ca0: adrp     x0, #0x2212000
01a66ca4: ldr      x0, [x0, #0x170]
01a66ca8: bl       #0xe54c48 ;
01a66cac: adrp     x0, #0x2212000
01a66cb0: ldr      x0, [x0, #0x178]
01a66cb4: bl       #0xe54c48 ;
01a66cb8: adrp     x0, #0x2212000
01a66cbc: ldr      x0, [x0, #0x180]
01a66cc0: bl       #0xe54c48 ;
01a66cc4: adrp     x0, #0x2212000
01a66cc8: ldr      x0, [x0, #0x188]
01a66ccc: bl       #0xe54c48 ;
01a66cd0: adrp     x0, #0x2212000
01a66cd4: ldr      x0, [x0, #0x140]
01a66cd8: bl       #0xe54c48 ;
01a66cdc: mov      w8, #1
01a66ce0: strb     w8, [x24, #0xcce]
01a66ce4: movi     v0.2d, #0000000000000000
01a66ce8: stp      xzr, xzr, [sp, #0x48]
01a66cec: str      xzr, [sp, #0x58]
01a66cf0: stp      q0, q0, [sp, #0x60]
01a66cf4: cbz      x23, #0x1a66ff4
01a66cf8: ldr      x24, [x23, #0x40]
01a66cfc: str      x19, [sp, #8]
01a66d00: cbz      x24, #0x1a66ff4
01a66d04: ldr      w8, [x24, #0x18]
01a66d08: cmp      w8, #1
01a66d0c: b.lt     #0x1a66db0
01a66d10: adrp     x28, #0x220f000
01a66d14: mov      x26, xzr
01a66d18: mov      w25, wzr
01a66d1c: ldr      x28, [x28, #0x48]
01a66d20: mov      x29, #0x100000000
01a66d24: mov      w19, #2
01a66d28: ldr      x2, [x28]
01a66d2c: mov      x0, x24
01a66d30: mov      w1, w25
01a66d34: bl       #0x1458300 ;
01a66d38: lsr      x8, x0, #0x20
01a66d3c: cmp      w8, w21
01a66d40: csinv    w9, w0, wzr, eq
01a66d44: cmp      w0, w21
01a66d48: csel     w27, w8, w9, eq
01a66d4c: tbnz     w27, #0x1f, #0x1a66d9c
01a66d50: cbz      x22, #0x1a66ff4
01a66d54: ldr      x8, [x22, #0x18]
01a66d58: cbz      x8, #0x1a66ff4
01a66d5c: ldr      w9, [x8, #0x18]
01a66d60: cmp      w27, w9
01a66d64: b.hs     #0x1a66ff8
01a66d68: add      x8, x8, w27, uxtw
01a66d6c: ldrb     w23, [x8, #0x20]
01a66d70: cbz      w23, #0x1a66d9c
01a66d74: cmp      w23, #2
01a66d78: and      x20, x1, #0xffffffff
01a66d7c: ldr      w9, [sp, #0x14]
01a66d80: cset     w8, eq
01a66d84: cmp      w23, #1
01a66d88: csel     w8, w19, w8, eq
01a66d8c: cmp      x20, #0
01a66d90: csel     w8, w23, w8, eq
01a66d94: cmp      w8, w9, uxtb
01a66d98: b.eq     #0x1a66de0
01a66d9c: ldr      w8, [x24, #0x18]
01a66da0: add      w25, w25, #1
01a66da4: add      x26, x26, x29
01a66da8: cmp      w25, w8
01a66dac: b.lt     #0x1a66d28
01a66db0: movi     v0.2d, #0000000000000000
01a66db4: ldr      x8, [sp, #8]
01a66db8: str      xzr, [x8, #0x20]
01a66dbc: stp      q0, q0, [x8]
01a66dc0: ldp      x20, x19, [sp, #0xf0]
01a66dc4: ldp      x22, x21, [sp, #0xe0]
01a66dc8: ldp      x24, x23, [sp, #0xd0]
01a66dcc: ldp      x26, x25, [sp, #0xc0]
01a66dd0: ldp      x28, x27, [sp, #0xb0]
01a66dd4: ldp      x29, x30, [sp, #0xa0]
01a66dd8: add      sp, sp, #0x100
01a66ddc: ret
01a66de0: movi     v0.2d, #0000000000000000
01a66de4: adrp     x8, #0x2212000
01a66de8: adrp     x9, #0x2212000
01a66dec: ldr      x8, [x8, #0x178]
01a66df0: ldr      x9, [x9, #0x180]
01a66df4: cmp      x20, #0
01a66df8: add      x0, sp, #0x60
01a66dfc: csel     x8, x8, x9, eq
01a66e00: stp      q0, q0, [sp, #0x60]
01a66e04: ldr      x1, [x8]
01a66e08: str      x1, [sp, #0x60]
01a66e0c: bl       #0xe54bf4 ;
01a66e10: adrp     x8, #0x2212000
01a66e14: mov      w1, #3
01a66e18: ldr      x8, [x8, #0x108]
01a66e1c: ldr      x0, [x8]
01a66e20: bl       #0xe54cf0 ;
01a66e24: adrp     x8, #0x2212000
01a66e28: mov      x21, x0
01a66e2c: add      x0, sp, #0x48
01a66e30: ldr      x8, [x8, #0x188]
01a66e34: stp      xzr, xzr, [sp, #0x50]
01a66e38: add      x19, sp, #0x48
01a66e3c: ldr      x1, [x8]
01a66e40: str      x1, [sp, #0x48]
01a66e44: bl       #0xe54bf4 ;
01a66e48: adrp     x8, #0x2212000
01a66e4c: ldr      x8, [x8, #0x168]
01a66e50: ldr      x0, [x8]
01a66e54: ldr      w8, [x0, #0xe4]
01a66e58: cbnz     w8, #0x1a66e60
01a66e5c: bl       #0xe54d80 ;
01a66e60: cmp      x20, #0
01a66e64: cset     w0, eq
01a66e68: bl       #0x1a67fec ; PairzzleIconTag.Sign
01a66e6c: mov      x1, x0
01a66e70: str      x0, [sp, #0x58]
01a66e74: add      x0, x19, #0x10
01a66e78: bl       #0xe54bf4 ;
01a66e7c: cbz      x21, #0x1a66ff4
01a66e80: ldr      w8, [x21, #0x18]
01a66e84: cbz      w8, #0x1a66ff8
01a66e88: ldur     q0, [sp, #0x48]
01a66e8c: ldr      x8, [sp, #0x58]
01a66e90: add      x0, x21, #0x20
01a66e94: mov      x1, xzr
01a66e98: str      q0, [x21, #0x20]
01a66e9c: str      x8, [x21, #0x30]
01a66ea0: bl       #0xe54bf4 ;
01a66ea4: adrp     x8, #0x2212000
01a66ea8: ldr      x8, [x8, #0x60]
01a66eac: ldr      x0, [x8]
01a66eb0: ldr      w8, [x0, #0xe4]
01a66eb4: cbnz     w8, #0x1a66ebc
01a66eb8: bl       #0xe54d80 ;
01a66ebc: adrp     x8, #0x2212000
01a66ec0: mov      w1, w23
01a66ec4: ldr      x8, [x8, #0x170]
01a66ec8: ldr      x0, [x8]
01a66ecc: add      x8, sp, #0x30
01a66ed0: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a66ed4: ldr      w8, [x21, #0x18]
01a66ed8: tst      w8, #0xfffffffe
01a66edc: b.eq     #0x1a66ff8
01a66ee0: ldr      q0, [sp, #0x30]
01a66ee4: ldr      x8, [sp, #0x40]
01a66ee8: add      x0, x21, #0x38
01a66eec: mov      x1, xzr
01a66ef0: stur     q0, [x21, #0x38]
01a66ef4: str      x8, [x21, #0x48]
01a66ef8: bl       #0xe54bf4 ;
01a66efc: adrp     x8, #0x2212000
01a66f00: ldr      x8, [x8, #0x140]
01a66f04: ldr      w1, [sp, #0x14]
01a66f08: ldr      x0, [x8]
01a66f0c: add      x8, sp, #0x18
01a66f10: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a66f14: ldr      w8, [x21, #0x18]
01a66f18: cmp      w8, #2
01a66f1c: b.ls     #0x1a66ff8
01a66f20: ldur     q0, [sp, #0x18]
01a66f24: ldr      x8, [sp, #0x28]
01a66f28: add      x0, x21, #0x50
01a66f2c: mov      x1, xzr
01a66f30: str      q0, [x21, #0x50]
01a66f34: str      x8, [x21, #0x60]
01a66f38: bl       #0xe54bf4 ;
01a66f3c: add      x8, sp, #0x60
01a66f40: mov      x1, x21
01a66f44: str      x21, [sp, #0x68]
01a66f48: orr      x0, x8, #8
01a66f4c: bl       #0xe54bf4 ;
01a66f50: adrp     x8, #0x21f0000
01a66f54: mov      w1, #1
01a66f58: ldr      x8, [x8, #0x470]
01a66f5c: ldr      x0, [x8]
01a66f60: bl       #0xe54cf0 ;
01a66f64: cbz      x0, #0x1a66ff4
01a66f68: ldr      w8, [x0, #0x18]
01a66f6c: mov      x1, x0
01a66f70: cbz      w8, #0x1a66ff8
01a66f74: add      x8, sp, #0x60
01a66f78: str      w27, [x1, #0x20]
01a66f7c: add      x0, x8, #0x10
01a66f80: str      x1, [sp, #0x70]
01a66f84: bl       #0xe54bf4 ;
01a66f88: adrp     x8, #0x2212000
01a66f8c: mov      w1, #1
01a66f90: ldr      x8, [x8, #0x100]
01a66f94: ldr      x0, [x8]
01a66f98: bl       #0xe54cf0 ;
01a66f9c: cbz      x0, #0x1a66ff4
01a66fa0: ldr      w8, [x0, #0x18]
01a66fa4: mov      x1, x0
01a66fa8: cbz      w8, #0x1a66ff8
01a66fac: add      x8, sp, #0x60
01a66fb0: str      x26, [x1, #0x20]
01a66fb4: add      x0, x8, #0x18
01a66fb8: str      x1, [sp, #0x78]
01a66fbc: bl       #0xe54bf4 ;
01a66fc0: ldp      q1, q2, [sp, #0x60]
01a66fc4: adrp     x8, #0x2212000
01a66fc8: movi     v0.2d, #0000000000000000
01a66fcc: add      x1, sp, #0x80
01a66fd0: str      q1, [sp, #0x80]
01a66fd4: ldr      x8, [x8, #0x148]
01a66fd8: ldr      x0, [sp, #8]
01a66fdc: str      q2, [sp, #0x90]
01a66fe0: ldr      x2, [x8]
01a66fe4: stp      q0, q0, [x0]
01a66fe8: str      xzr, [x0, #0x20]
01a66fec: bl       #0x14ff434 ;
01a66ff0: b        #0x1a66dc0 ;
01a66ff4: bl       #0xe54eac ;
01a66ff8: bl       #0xe54eb4 ;
