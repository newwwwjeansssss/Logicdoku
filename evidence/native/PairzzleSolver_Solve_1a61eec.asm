// Data.Pairzzle.PairzzleSolver.Solve token=0x600105a VA=0x1a61eec
01a61eec: str      x30, [sp, #-0x60]!
01a61ef0: stp      x28, x27, [sp, #0x10]
01a61ef4: stp      x26, x25, [sp, #0x20]
01a61ef8: stp      x24, x23, [sp, #0x30]
01a61efc: stp      x22, x21, [sp, #0x40]
01a61f00: stp      x20, x19, [sp, #0x50]
01a61f04: adrp     x19, #0x2387000
01a61f08: adrp     x22, #0x2211000
01a61f0c: adrp     x20, #0x2211000
01a61f10: ldrb     w8, [x19, #0xd20]
01a61f14: ldr      x22, [x22, #0xf60]
01a61f18: ldr      x20, [x20, #0xf48]
01a61f1c: mov      x21, x0
01a61f20: tbnz     w8, #0, #0x1a61f68
01a61f24: adrp     x0, #0x21f0000
01a61f28: ldr      x0, [x0, #0x470]
01a61f2c: bl       #0xe54c48 ; 
01a61f30: adrp     x0, #0x220b000
01a61f34: ldr      x0, [x0, #0x218]
01a61f38: bl       #0xe54c48 ; 
01a61f3c: adrp     x0, #0x220b000
01a61f40: ldr      x0, [x0, #0x2f8]
01a61f44: bl       #0xe54c48 ; 
01a61f48: adrp     x0, #0x2211000
01a61f4c: ldr      x0, [x0, #0xf48]
01a61f50: bl       #0xe54c48 ; 
01a61f54: adrp     x0, #0x2211000
01a61f58: ldr      x0, [x0, #0xf60]
01a61f5c: bl       #0xe54c48 ; 
01a61f60: mov      w8, #1
01a61f64: strb     w8, [x19, #0xd20]
01a61f68: ldr      x0, [x22]
01a61f6c: bl       #0xe54e9c ; 
01a61f70: mov      x1, x21
01a61f74: mov      x19, x0
01a61f78: bl       #0x1a61a28 ; PairzzleRuleSet..ctor
01a61f7c: ldr      x0, [x20]
01a61f80: bl       #0xe54e9c ; 
01a61f84: mov      x1, x21
01a61f88: mov      x20, x0
01a61f8c: bl       #0x1a6076c ; PairzzleBoardState..ctor
01a61f90: mov      x0, x20
01a61f94: bl       #0x1a6d5e8 ; PairzzleSolver.CollectEmpties
01a61f98: cbz      x0, #0x1a620f8
01a61f9c: adrp     x8, #0x21f0000
01a61fa0: adrp     x25, #0x220b000
01a61fa4: mov      x21, x0
01a61fa8: ldr      x8, [x8, #0x470]
01a61fac: ldr      x25, [x25, #0x2f8]
01a61fb0: ldr      w1, [x0, #0x18]
01a61fb4: ldr      x0, [x8]
01a61fb8: bl       #0xe54cf0 ; 
01a61fbc: mov      x22, x0
01a61fc0: mov      w23, wzr
01a61fc4: mov      w26, #1
01a61fc8: mov      w27, #2
01a61fcc: ldr      w8, [x21, #0x18]
01a61fd0: cmp      w23, w8
01a61fd4: b.eq     #0x1a620d8
01a61fd8: ldr      x2, [x25]
01a61fdc: mov      x0, x21
01a61fe0: mov      w1, w23
01a61fe4: bl       #0x140455c ; 
01a61fe8: cbz      x22, #0x1a620f8
01a61fec: ldr      w8, [x22, #0x18]
01a61ff0: cmp      w23, w8
01a61ff4: b.hs     #0x1a620fc
01a61ff8: add      x28, x22, w23, uxtw #2
01a61ffc: mov      w24, w0
01a62000: ldr      w8, [x28, #0x20]!
01a62004: cbz      w8, #0x1a62018
01a62008: cmp      w8, #1
01a6200c: b.le     #0x1a62068
01a62010: cbnz     x20, #0x1a620a0
01a62014: b        #0x1a620f8 ; 
01a62018: str      w26, [x28]
01a6201c: cbz      x20, #0x1a620f8
01a62020: mov      x0, x20
01a62024: mov      w1, w24
01a62028: mov      w2, #1
01a6202c: bl       #0x1a60bec ; PairzzleBoardState.Set
01a62030: cbz      x19, #0x1a620f8
01a62034: mov      x0, x19
01a62038: mov      x1, x20
01a6203c: bl       #0x1a6d2a4 ; PairzzleRuleSet.HasViolation
01a62040: tbz      w0, #0, #0x1a620c8
01a62044: ldr      w8, [x22, #0x18]
01a62048: cmp      w23, w8
01a6204c: b.hs     #0x1a620fc
01a62050: mov      x0, x20
01a62054: mov      w1, w24
01a62058: mov      w2, #2
01a6205c: str      w27, [x28]
01a62060: bl       #0x1a60bec ; PairzzleBoardState.Set
01a62064: b        #0x1a62090 ; 
01a62068: ldr      w8, [x22, #0x18]
01a6206c: cmp      w23, w8
01a62070: b.hs     #0x1a620fc
01a62074: str      w27, [x28]
01a62078: cbz      x20, #0x1a620f8
01a6207c: mov      x0, x20
01a62080: mov      w1, w24
01a62084: mov      w2, #2
01a62088: bl       #0x1a60bec ; PairzzleBoardState.Set
01a6208c: cbz      x19, #0x1a620f8
01a62090: mov      x0, x19
01a62094: mov      x1, x20
01a62098: bl       #0x1a6d2a4 ; PairzzleRuleSet.HasViolation
01a6209c: tbz      w0, #0, #0x1a620c8
01a620a0: mov      x0, x20
01a620a4: mov      w1, w24
01a620a8: mov      w2, wzr
01a620ac: bl       #0x1a60bec ; PairzzleBoardState.Set
01a620b0: ldr      w8, [x22, #0x18]
01a620b4: cmp      w23, w8
01a620b8: b.hs     #0x1a620fc
01a620bc: mov      w8, #-1
01a620c0: str      wzr, [x28]
01a620c4: b        #0x1a620cc ; 
01a620c8: mov      w8, #1
01a620cc: adds     w23, w23, w8
01a620d0: b.pl     #0x1a61fcc
01a620d4: mov      x20, xzr
01a620d8: mov      x0, x20
01a620dc: ldp      x20, x19, [sp, #0x50]
01a620e0: ldp      x22, x21, [sp, #0x40]
01a620e4: ldp      x24, x23, [sp, #0x30]
01a620e8: ldp      x26, x25, [sp, #0x20]
01a620ec: ldp      x28, x27, [sp, #0x10]
01a620f0: ldr      x30, [sp], #0x60
01a620f4: ret      
01a620f8: bl       #0xe54eac ; 
01a620fc: bl       #0xe54eb4 ; 