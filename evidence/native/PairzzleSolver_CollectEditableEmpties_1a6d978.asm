// Data.Pairzzle.PairzzleSolver.CollectEditableEmpties token=0x6001060 VA=0x1a6d978
01a6d978: str      x30, [sp, #-0x40]!
01a6d97c: stp      x24, x23, [sp, #0x10]
01a6d980: stp      x22, x21, [sp, #0x20]
01a6d984: stp      x20, x19, [sp, #0x30]
01a6d988: adrp     x21, #0x2387000
01a6d98c: adrp     x22, #0x21f1000
01a6d990: adrp     x20, #0x2206000
01a6d994: ldrb     w8, [x21, #0xd26]
01a6d998: ldr      x22, [x22, #0x688]
01a6d99c: ldr      x20, [x20, #0x210]
01a6d9a0: mov      x19, x0
01a6d9a4: tbnz     w8, #0, #0x1a6d9d4
01a6d9a8: adrp     x0, #0x21f1000
01a6d9ac: ldr      x0, [x0, #0x3f0]
01a6d9b0: bl       #0xe54c48 ;
01a6d9b4: adrp     x0, #0x2206000
01a6d9b8: ldr      x0, [x0, #0x210]
01a6d9bc: bl       #0xe54c48 ;
01a6d9c0: adrp     x0, #0x21f1000
01a6d9c4: ldr      x0, [x0, #0x688]
01a6d9c8: bl       #0xe54c48 ;
01a6d9cc: mov      w8, #1
01a6d9d0: strb     w8, [x21, #0xd26]
01a6d9d4: ldr      x0, [x22]
01a6d9d8: bl       #0xe54e9c ;
01a6d9dc: ldr      x1, [x20]
01a6d9e0: mov      x20, x0
01a6d9e4: bl       #0x1403fc4 ;
01a6d9e8: cbz      x19, #0x1a6dab8
01a6d9ec: ldr      x22, [x19, #0x18]
01a6d9f0: cbz      x22, #0x1a6dab8
01a6d9f4: ldr      w8, [x22, #0x18]
01a6d9f8: cmp      w8, #1
01a6d9fc: b.lt     #0x1a6da9c
01a6da00: adrp     x23, #0x21f1000
01a6da04: mov      x21, xzr
01a6da08: add      x24, x22, #0x20
01a6da0c: ldr      x23, [x23, #0x3f0]
01a6da10: mov      x0, x19
01a6da14: mov      w1, w21
01a6da18: bl       #0x1a60b0c ; PairzzleBoardState.IsEditable
01a6da1c: tbz      w0, #0, #0x1a6da8c
01a6da20: ldr      w8, [x22, #0x18]
01a6da24: cmp      x21, x8
01a6da28: b.hs     #0x1a6dab4
01a6da2c: ldrb     w8, [x24, x21]
01a6da30: cbnz     w8, #0x1a6da8c
01a6da34: cbz      x20, #0x1a6dab8
01a6da38: ldr      w10, [x20, #0x1c]
01a6da3c: ldr      x8, [x20, #0x10]
01a6da40: ldr      x9, [x23]
01a6da44: add      w10, w10, #1
01a6da48: str      w10, [x20, #0x1c]
01a6da4c: cbz      x8, #0x1a6dab8
01a6da50: ldrsw    x10, [x20, #0x18]
01a6da54: ldr      w11, [x8, #0x18]
01a6da58: cmp      w10, w11
01a6da5c: b.hs     #0x1a6da74
01a6da60: add      x8, x8, x10, lsl #2
01a6da64: add      w9, w10, #1
01a6da68: str      w9, [x20, #0x18]
01a6da6c: str      w21, [x8, #0x20]
01a6da70: b        #0x1a6da8c ;
01a6da74: ldr      x8, [x9, #0x20]
01a6da78: mov      x0, x20
01a6da7c: mov      w1, w21
01a6da80: ldr      x8, [x8, #0xc0]
01a6da84: ldr      x2, [x8, #0x70]
01a6da88: bl       #0x1404854 ;
01a6da8c: ldrsw    x8, [x22, #0x18]
01a6da90: add      x21, x21, #1
01a6da94: cmp      x21, x8
01a6da98: b.lt     #0x1a6da10
01a6da9c: mov      x0, x20
01a6daa0: ldp      x20, x19, [sp, #0x30]
01a6daa4: ldp      x22, x21, [sp, #0x20]
01a6daa8: ldp      x24, x23, [sp, #0x10]
01a6daac: ldr      x30, [sp], #0x40
01a6dab0: ret
01a6dab4: bl       #0xe54eb4 ;
01a6dab8: bl       #0xe54eac ;
