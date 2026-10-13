// Data.Pairzzle.PairzzleSolver.GetHint token=0x600105b VA=0x1a6d7cc
01a6d7cc: sub      sp, sp, #0x70
01a6d7d0: str      x30, [sp, #0x10]
01a6d7d4: stp      x28, x27, [sp, #0x20]
01a6d7d8: stp      x26, x25, [sp, #0x30]
01a6d7dc: stp      x24, x23, [sp, #0x40]
01a6d7e0: stp      x22, x21, [sp, #0x50]
01a6d7e4: stp      x20, x19, [sp, #0x60]
01a6d7e8: adrp     x20, #0x2387000
01a6d7ec: mov      x19, x1
01a6d7f0: mov      x21, x0
01a6d7f4: ldrb     w8, [x20, #0xd21]
01a6d7f8: tbnz     w8, #0, #0x1a6d834
01a6d7fc: adrp     x0, #0x220b000
01a6d800: ldr      x0, [x0, #0x218]
01a6d804: bl       #0xe54c48 ;
01a6d808: adrp     x0, #0x220b000
01a6d80c: ldr      x0, [x0, #0x2f8]
01a6d810: bl       #0xe54c48 ;
01a6d814: adrp     x0, #0x2212000
01a6d818: ldr      x0, [x0, #0x68]
01a6d81c: bl       #0xe54c48 ;
01a6d820: adrp     x0, #0x2212000
01a6d824: ldr      x0, [x0, #0x48]
01a6d828: bl       #0xe54c48 ;
01a6d82c: mov      w8, #1
01a6d830: strb     w8, [x20, #0xd21]
01a6d834: mov      x0, x21
01a6d838: mov      x1, x19
01a6d83c: bl       #0x1a64258 ; PairzzleSolver.GetLocalHint
01a6d840: tst      x0, #0xff
01a6d844: b.eq     #0x1a6d854
01a6d848: str      x0, [sp]
01a6d84c: str      w1, [sp, #8]
01a6d850: b        #0x1a6d94c ;
01a6d854: mov      x0, x21
01a6d858: bl       #0x1a6d978 ; PairzzleSolver.CollectEditableEmpties
01a6d85c: cbz      x21, #0x1a6d974
01a6d860: mov      x20, x0
01a6d864: mov      x0, x21
01a6d868: bl       #0x1a6128c ; PairzzleBoardState.Clone
01a6d86c: cbz      x20, #0x1a6d974
01a6d870: ldr      w8, [x20, #0x18]
01a6d874: cmp      w8, #1
01a6d878: b.lt     #0x1a6d910
01a6d87c: adrp     x25, #0x220b000
01a6d880: mov      x21, x0
01a6d884: mov      w22, wzr
01a6d888: ldr      x25, [x25, #0x2f8]
01a6d88c: mov      w26, #1
01a6d890: ldr      x2, [x25]
01a6d894: mov      x0, x20
01a6d898: mov      w1, w22
01a6d89c: bl       #0x140455c ;
01a6d8a0: cbz      x21, #0x1a6d974
01a6d8a4: mov      w23, w0
01a6d8a8: mov      x27, xzr
01a6d8ac: mov      w8, #1
01a6d8b0: tst      w8, #1
01a6d8b4: mov      x0, x21
01a6d8b8: mov      w1, w23
01a6d8bc: cinc     w2, w26, eq
01a6d8c0: mov      w28, w8
01a6d8c4: bl       #0x1a60bec ; PairzzleBoardState.Set
01a6d8c8: mov      x0, x21
01a6d8cc: mov      x1, x19
01a6d8d0: mov      w2, #1
01a6d8d4: bl       #0x1a6d3d8 ; PairzzleSolver.CountCompletions
01a6d8d8: mov      w24, w0
01a6d8dc: mov      x0, x21
01a6d8e0: mov      w1, w23
01a6d8e4: mov      w2, wzr
01a6d8e8: bl       #0x1a60bec ; PairzzleBoardState.Set
01a6d8ec: cmp      w24, #0
01a6d8f0: b.le     #0x1a6d91c
01a6d8f4: mov      w8, wzr
01a6d8f8: mov      x27, #0x100000000
01a6d8fc: tbnz     w28, #0, #0x1a6d8b0
01a6d900: ldr      w8, [x20, #0x18]
01a6d904: add      w22, w22, #1
01a6d908: cmp      w22, w8
01a6d90c: b.lt     #0x1a6d890
01a6d910: str      wzr, [sp, #8]
01a6d914: str      xzr, [sp]
01a6d918: b        #0x1a6d94c ;
01a6d91c: adrp     x8, #0x2212000
01a6d920: tst      w28, #1
01a6d924: mov      x9, #0x200000000
01a6d928: ldr      x8, [x8, #0x68]
01a6d92c: mov      x0, sp
01a6d930: str      wzr, [sp, #8]
01a6d934: str      xzr, [sp]
01a6d938: ldr      x2, [x8]
01a6d93c: csel     x8, x9, x27, ne
01a6d940: mov      w9, w23
01a6d944: orr      x1, x8, x9
01a6d948: bl       #0x14fefd8 ;
01a6d94c: ldp      x20, x19, [sp, #0x60]
01a6d950: ldr      x0, [sp]
01a6d954: ldp      x22, x21, [sp, #0x50]
01a6d958: ldr      w1, [sp, #8]
01a6d95c: ldr      x30, [sp, #0x10]
01a6d960: ldp      x24, x23, [sp, #0x40]
01a6d964: ldp      x26, x25, [sp, #0x30]
01a6d968: ldp      x28, x27, [sp, #0x20]
01a6d96c: add      sp, sp, #0x70
01a6d970: ret
01a6d974: bl       #0xe54eac ;
