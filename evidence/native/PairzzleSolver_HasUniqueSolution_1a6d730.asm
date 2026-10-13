// Data.Pairzzle.PairzzleSolver.HasUniqueSolution token=0x6001059 VA=0x1a6d730
01a6d730: str      x30, [sp, #-0x30]!
01a6d734: stp      x22, x21, [sp, #0x10]
01a6d738: stp      x20, x19, [sp, #0x20]
01a6d73c: adrp     x20, #0x2387000
01a6d740: adrp     x22, #0x2211000
01a6d744: adrp     x21, #0x2211000
01a6d748: ldrb     w8, [x20, #0xd1f]
01a6d74c: ldr      x22, [x22, #0xf60]
01a6d750: ldr      x21, [x21, #0xf48]
01a6d754: mov      x19, x0
01a6d758: tbnz     w8, #0, #0x1a6d77c
01a6d75c: adrp     x0, #0x2211000
01a6d760: ldr      x0, [x0, #0xf48]
01a6d764: bl       #0xe54c48 ; 
01a6d768: adrp     x0, #0x2211000
01a6d76c: ldr      x0, [x0, #0xf60]
01a6d770: bl       #0xe54c48 ; 
01a6d774: mov      w8, #1
01a6d778: strb     w8, [x20, #0xd1f]
01a6d77c: ldr      x0, [x22]
01a6d780: bl       #0xe54e9c ; 
01a6d784: mov      x1, x19
01a6d788: mov      x20, x0
01a6d78c: bl       #0x1a61a28 ; PairzzleRuleSet..ctor
01a6d790: ldr      x0, [x21]
01a6d794: bl       #0xe54e9c ; 
01a6d798: mov      x1, x19
01a6d79c: mov      x21, x0
01a6d7a0: bl       #0x1a6076c ; PairzzleBoardState..ctor
01a6d7a4: mov      x0, x21
01a6d7a8: mov      x1, x20
01a6d7ac: mov      w2, #2
01a6d7b0: bl       #0x1a6d3d8 ; PairzzleSolver.CountCompletions
01a6d7b4: ldp      x20, x19, [sp, #0x20]
01a6d7b8: cmp      w0, #1
01a6d7bc: ldp      x22, x21, [sp, #0x10]
01a6d7c0: cset     w0, eq
01a6d7c4: ldr      x30, [sp], #0x30
01a6d7c8: ret      