// Data.Pairzzle.PairzzleHintReasons.LineCells token=0x6000ff0 VA=0x1a67d8c
01a67d8c: stp      x30, x23, [sp, #-0x30]!
01a67d90: stp      x22, x21, [sp, #0x10]
01a67d94: stp      x20, x19, [sp, #0x20]
01a67d98: adrp     x22, #0x2387000
01a67d9c: adrp     x23, #0x21f0000
01a67da0: mov      w19, w2
01a67da4: ldrb     w8, [x22, #0xcd3]
01a67da8: ldr      x23, [x23, #0x470]
01a67dac: mov      w20, w1
01a67db0: mov      w21, w0
01a67db4: tbnz     w8, #0, #0x1a67dcc
01a67db8: adrp     x0, #0x21f0000
01a67dbc: ldr      x0, [x0, #0x470]
01a67dc0: bl       #0xe54c48 ; 
01a67dc4: mov      w8, #1
01a67dc8: strb     w8, [x22, #0xcd3]
01a67dcc: ldr      x0, [x23]
01a67dd0: mov      w1, w21
01a67dd4: bl       #0xe54cf0 ; 
01a67dd8: cmp      w21, #1
01a67ddc: b.lt     #0x1a67e18
01a67de0: cbz      x0, #0x1a67e2c
01a67de4: mul      w8, w19, w21
01a67de8: ldr      w9, [x0, #0x18]
01a67dec: mov      w10, w21
01a67df0: add      x11, x0, #0x20
01a67df4: cbz      x9, #0x1a67e28
01a67df8: cmp      w20, #0
01a67dfc: sub      x9, x9, #1
01a67e00: csel     w12, w8, w19, eq
01a67e04: subs     x10, x10, #1
01a67e08: add      w19, w19, w21
01a67e0c: add      w8, w8, #1
01a67e10: str      w12, [x11], #4
01a67e14: b.ne     #0x1a67df4
01a67e18: ldp      x20, x19, [sp, #0x20]
01a67e1c: ldp      x22, x21, [sp, #0x10]
01a67e20: ldp      x30, x23, [sp], #0x30
01a67e24: ret      
01a67e28: bl       #0xe54eb4 ; 
01a67e2c: bl       #0xe54eac ; 