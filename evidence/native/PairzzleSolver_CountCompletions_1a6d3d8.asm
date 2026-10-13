// Data.Pairzzle.PairzzleSolver.CountCompletions token=0x6001058 VA=0x1a6d3d8
01a6d3d8: sub      sp, sp, #0x70
01a6d3dc: stp      x29, x30, [sp, #0x10]
01a6d3e0: stp      x28, x27, [sp, #0x20]
01a6d3e4: stp      x26, x25, [sp, #0x30]
01a6d3e8: stp      x24, x23, [sp, #0x40]
01a6d3ec: stp      x22, x21, [sp, #0x50]
01a6d3f0: stp      x20, x19, [sp, #0x60]
01a6d3f4: adrp     x19, #0x2387000
01a6d3f8: mov      w23, w2
01a6d3fc: mov      x20, x1
01a6d400: ldrb     w8, [x19, #0xd1e]
01a6d404: mov      x21, x0
01a6d408: tbnz     w8, #0, #0x1a6d438
01a6d40c: adrp     x0, #0x21f0000
01a6d410: ldr      x0, [x0, #0x470]
01a6d414: bl       #0xe54c48 ;
01a6d418: adrp     x0, #0x220b000
01a6d41c: ldr      x0, [x0, #0x218]
01a6d420: bl       #0xe54c48 ;
01a6d424: adrp     x0, #0x220b000
01a6d428: ldr      x0, [x0, #0x2f8]
01a6d42c: bl       #0xe54c48 ;
01a6d430: mov      w8, #1
01a6d434: strb     w8, [x19, #0xd1e]
01a6d438: cbz      x21, #0x1a6d5e0
01a6d43c: mov      x0, x21
01a6d440: bl       #0x1a6128c ; PairzzleBoardState.Clone
01a6d444: mov      x21, x0
01a6d448: bl       #0x1a6d5e8 ; PairzzleSolver.CollectEmpties
01a6d44c: cbz      x0, #0x1a6d5e0
01a6d450: adrp     x8, #0x21f0000
01a6d454: mov      x22, x0
01a6d458: ldr      x8, [x8, #0x470]
01a6d45c: ldr      w1, [x0, #0x18]
01a6d460: ldr      x0, [x8]
01a6d464: bl       #0xe54cf0 ;
01a6d468: cmp      w23, #1
01a6d46c: b.lt     #0x1a6d5b8
01a6d470: str      w23, [sp, #0xc]
01a6d474: adrp     x27, #0x220b000
01a6d478: mov      x24, x0
01a6d47c: ldr      x27, [x27, #0x2f8]
01a6d480: mov      w23, wzr
01a6d484: mov      w25, wzr
01a6d488: mov      w28, #1
01a6d48c: mov      w29, #2
01a6d490: ldr      w8, [x22, #0x18]
01a6d494: cmp      w25, w8
01a6d498: b.eq     #0x1a6d59c
01a6d49c: ldr      x2, [x27]
01a6d4a0: mov      x0, x22
01a6d4a4: mov      w1, w25
01a6d4a8: bl       #0x140455c ;
01a6d4ac: cbz      x24, #0x1a6d5e0
01a6d4b0: ldr      w8, [x24, #0x18]
01a6d4b4: cmp      w25, w8
01a6d4b8: b.hs     #0x1a6d5e4
01a6d4bc: add      x19, x24, w25, uxtw #2
01a6d4c0: mov      w26, w0
01a6d4c4: ldr      w8, [x19, #0x20]!
01a6d4c8: cbz      w8, #0x1a6d4dc
01a6d4cc: cmp      w8, #1
01a6d4d0: b.le     #0x1a6d52c
01a6d4d4: cbnz     x21, #0x1a6d564
01a6d4d8: b        #0x1a6d5e0 ;
01a6d4dc: str      w28, [x19]
01a6d4e0: cbz      x21, #0x1a6d5e0
01a6d4e4: mov      x0, x21
01a6d4e8: mov      w1, w26
01a6d4ec: mov      w2, #1
01a6d4f0: bl       #0x1a60bec ; PairzzleBoardState.Set
01a6d4f4: cbz      x20, #0x1a6d5e0
01a6d4f8: mov      x0, x20
01a6d4fc: mov      x1, x21
01a6d500: bl       #0x1a6d2a4 ; PairzzleRuleSet.HasViolation
01a6d504: tbz      w0, #0, #0x1a6d58c
01a6d508: ldr      w8, [x24, #0x18]
01a6d50c: cmp      w25, w8
01a6d510: b.hs     #0x1a6d5e4
01a6d514: mov      x0, x21
01a6d518: mov      w1, w26
01a6d51c: mov      w2, #2
01a6d520: str      w29, [x19]
01a6d524: bl       #0x1a60bec ; PairzzleBoardState.Set
01a6d528: b        #0x1a6d554 ;
01a6d52c: ldr      w8, [x24, #0x18]
01a6d530: cmp      w25, w8
01a6d534: b.hs     #0x1a6d5e4
01a6d538: str      w29, [x19]
01a6d53c: cbz      x21, #0x1a6d5e0
01a6d540: mov      x0, x21
01a6d544: mov      w1, w26
01a6d548: mov      w2, #2
01a6d54c: bl       #0x1a60bec ; PairzzleBoardState.Set
01a6d550: cbz      x20, #0x1a6d5e0
01a6d554: mov      x0, x20
01a6d558: mov      x1, x21
01a6d55c: bl       #0x1a6d2a4 ; PairzzleRuleSet.HasViolation
01a6d560: tbz      w0, #0, #0x1a6d58c
01a6d564: mov      x0, x21
01a6d568: mov      w1, w26
01a6d56c: mov      w2, wzr
01a6d570: bl       #0x1a60bec ; PairzzleBoardState.Set
01a6d574: ldr      w8, [x24, #0x18]
01a6d578: cmp      w25, w8
01a6d57c: b.hs     #0x1a6d5e4
01a6d580: mov      w8, #-1
01a6d584: str      wzr, [x19]
01a6d588: b        #0x1a6d590 ;
01a6d58c: mov      w8, #1
01a6d590: adds     w25, w25, w8
01a6d594: b.pl     #0x1a6d490
01a6d598: b        #0x1a6d5bc ;
01a6d59c: subs     w25, w25, #1
01a6d5a0: add      w23, w23, #1
01a6d5a4: b.lt     #0x1a6d5bc
01a6d5a8: ldr      w8, [sp, #0xc]
01a6d5ac: cmp      w23, w8
01a6d5b0: b.lt     #0x1a6d490
01a6d5b4: b        #0x1a6d5bc ;
01a6d5b8: mov      w23, wzr
01a6d5bc: mov      w0, w23
01a6d5c0: ldp      x20, x19, [sp, #0x60]
01a6d5c4: ldp      x22, x21, [sp, #0x50]
01a6d5c8: ldp      x24, x23, [sp, #0x40]
01a6d5cc: ldp      x26, x25, [sp, #0x30]
01a6d5d0: ldp      x28, x27, [sp, #0x20]
01a6d5d4: ldp      x29, x30, [sp, #0x10]
01a6d5d8: add      sp, sp, #0x70
01a6d5dc: ret
01a6d5e0: bl       #0xe54eac ;
01a6d5e4: bl       #0xe54eb4 ;
