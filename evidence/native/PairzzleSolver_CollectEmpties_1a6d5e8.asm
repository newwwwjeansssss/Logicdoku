// Data.Pairzzle.PairzzleSolver.CollectEmpties token=0x600105f VA=0x1a6d5e8
01a6d5e8: str      x30, [sp, #-0x40]!
01a6d5ec: stp      x24, x23, [sp, #0x10]
01a6d5f0: stp      x22, x21, [sp, #0x20]
01a6d5f4: stp      x20, x19, [sp, #0x30]
01a6d5f8: adrp     x21, #0x2387000
01a6d5fc: adrp     x22, #0x21f1000
01a6d600: adrp     x20, #0x2206000
01a6d604: ldrb     w8, [x21, #0xd25]
01a6d608: ldr      x22, [x22, #0x688]
01a6d60c: ldr      x20, [x20, #0x210]
01a6d610: mov      x19, x0
01a6d614: tbnz     w8, #0, #0x1a6d644
01a6d618: adrp     x0, #0x21f1000
01a6d61c: ldr      x0, [x0, #0x3f0]
01a6d620: bl       #0xe54c48 ; 
01a6d624: adrp     x0, #0x2206000
01a6d628: ldr      x0, [x0, #0x210]
01a6d62c: bl       #0xe54c48 ; 
01a6d630: adrp     x0, #0x21f1000
01a6d634: ldr      x0, [x0, #0x688]
01a6d638: bl       #0xe54c48 ; 
01a6d63c: mov      w8, #1
01a6d640: strb     w8, [x21, #0xd25]
01a6d644: ldr      x0, [x22]
01a6d648: bl       #0xe54e9c ; 
01a6d64c: ldr      x1, [x20]
01a6d650: mov      x20, x0
01a6d654: bl       #0x1403fc4 ; 
01a6d658: cbz      x19, #0x1a6d728
01a6d65c: ldr      x22, [x19, #0x18]
01a6d660: cbz      x22, #0x1a6d728
01a6d664: ldr      w8, [x22, #0x18]
01a6d668: cmp      w8, #1
01a6d66c: b.lt     #0x1a6d710
01a6d670: adrp     x23, #0x21f1000
01a6d674: mov      x21, xzr
01a6d678: add      x24, x22, #0x20
01a6d67c: ldr      x23, [x23, #0x3f0]
01a6d680: ldr      x0, [x19, #0x10]
01a6d684: cbz      x0, #0x1a6d728
01a6d688: mov      w1, w21
01a6d68c: bl       #0x1a609fc ; PairzzlePuzzle.IsHole
01a6d690: tbnz     w0, #0, #0x1a6d700
01a6d694: ldr      w8, [x22, #0x18]
01a6d698: cmp      x21, x8
01a6d69c: b.hs     #0x1a6d72c
01a6d6a0: ldrb     w8, [x24, x21]
01a6d6a4: cbnz     w8, #0x1a6d700
01a6d6a8: cbz      x20, #0x1a6d728
01a6d6ac: ldr      w10, [x20, #0x1c]
01a6d6b0: ldr      x8, [x20, #0x10]
01a6d6b4: ldr      x9, [x23]
01a6d6b8: add      w10, w10, #1
01a6d6bc: str      w10, [x20, #0x1c]
01a6d6c0: cbz      x8, #0x1a6d728
01a6d6c4: ldrsw    x10, [x20, #0x18]
01a6d6c8: ldr      w11, [x8, #0x18]
01a6d6cc: cmp      w10, w11
01a6d6d0: b.hs     #0x1a6d6e8
01a6d6d4: add      x8, x8, x10, lsl #2
01a6d6d8: add      w9, w10, #1
01a6d6dc: str      w9, [x20, #0x18]
01a6d6e0: str      w21, [x8, #0x20]
01a6d6e4: b        #0x1a6d700 ; 
01a6d6e8: ldr      x8, [x9, #0x20]
01a6d6ec: mov      x0, x20
01a6d6f0: mov      w1, w21
01a6d6f4: ldr      x8, [x8, #0xc0]
01a6d6f8: ldr      x2, [x8, #0x70]
01a6d6fc: bl       #0x1404854 ; 
01a6d700: ldrsw    x8, [x22, #0x18]
01a6d704: add      x21, x21, #1
01a6d708: cmp      x21, x8
01a6d70c: b.lt     #0x1a6d680
01a6d710: mov      x0, x20
01a6d714: ldp      x20, x19, [sp, #0x30]
01a6d718: ldp      x22, x21, [sp, #0x20]
01a6d71c: ldp      x24, x23, [sp, #0x10]
01a6d720: ldr      x30, [sp], #0x40
01a6d724: ret      
01a6d728: bl       #0xe54eac ; 
01a6d72c: bl       #0xe54eb4 ; 