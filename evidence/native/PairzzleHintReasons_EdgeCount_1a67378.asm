// Data.Pairzzle.PairzzleHintReasons.EdgeCount token=0x6000fec VA=0x1a67378
01a67378: sub      sp, sp, #0x170
01a6737c: stp      x29, x30, [sp, #0x110]
01a67380: stp      x28, x27, [sp, #0x120]
01a67384: stp      x26, x25, [sp, #0x130]
01a67388: stp      x24, x23, [sp, #0x140]
01a6738c: stp      x22, x21, [sp, #0x150]
01a67390: stp      x20, x19, [sp, #0x160]
01a67394: adrp     x19, #0x2387000
01a67398: mov      x20, x8
01a6739c: mov      w23, w2
01a673a0: ldrb     w8, [x19, #0xcd0]
01a673a4: mov      x22, x0
01a673a8: add      x21, sp, #0xd0
01a673ac: str      w1, [sp, #0x24]
01a673b0: tbnz     w8, #0, #0x1a6744c
01a673b4: adrp     x0, #0x220f000
01a673b8: ldr      x0, [x0, #0x60]
01a673bc: bl       #0xe54c48 ;
01a673c0: adrp     x0, #0x220f000
01a673c4: ldr      x0, [x0, #0x68]
01a673c8: bl       #0xe54c48 ;
01a673cc: adrp     x0, #0x2212000
01a673d0: ldr      x0, [x0, #0x148]
01a673d4: bl       #0xe54c48 ;
01a673d8: adrp     x0, #0x2212000
01a673dc: ldr      x0, [x0, #0x100]
01a673e0: bl       #0xe54c48 ;
01a673e4: adrp     x0, #0x2212000
01a673e8: ldr      x0, [x0, #0x108]
01a673ec: bl       #0xe54c48 ;
01a673f0: adrp     x0, #0x2212000
01a673f4: ldr      x0, [x0, #0x60]
01a673f8: bl       #0xe54c48 ;
01a673fc: adrp     x0, #0x2212000
01a67400: ldr      x0, [x0, #0x198]
01a67404: bl       #0xe54c48 ;
01a67408: adrp     x0, #0x2212000
01a6740c: ldr      x0, [x0, #0x150]
01a67410: bl       #0xe54c48 ;
01a67414: adrp     x0, #0x2212000
01a67418: ldr      x0, [x0, #0x1a0]
01a6741c: bl       #0xe54c48 ;
01a67420: adrp     x0, #0x220f000
01a67424: ldr      x0, [x0, #0x2a8]
01a67428: bl       #0xe54c48 ;
01a6742c: adrp     x0, #0x2212000
01a67430: ldr      x0, [x0, #0x140]
01a67434: bl       #0xe54c48 ;
01a67438: adrp     x0, #0x2212000
01a6743c: ldr      x0, [x0, #0x1a8]
01a67440: bl       #0xe54c48 ;
01a67444: mov      w8, #1
01a67448: strb     w8, [x19, #0xcd0]
01a6744c: movi     v0.2d, #0000000000000000
01a67450: stp      q0, q0, [x21]
01a67454: cbz      x22, #0x1a67868
01a67458: str      w23, [sp, #0x10]
01a6745c: adrp     x8, #0x220f000
01a67460: mov      x0, x22
01a67464: str      x20, [sp, #0x18]
01a67468: ldr      x8, [x8, #0x2a8]
01a6746c: ldr      w9, [x22, #0x10]
01a67470: ldr      x26, [x22, #0x48]
01a67474: ldr      x1, [x8]
01a67478: str      w9, [sp, #0x14]
01a6747c: bl       #0x1a68048 ; PairzzleRuleScopes.Of
01a67480: cbz      x26, #0x1a67868
01a67484: ldr      w8, [x26, #0x18]
01a67488: cmp      w8, #1
01a6748c: b.lt     #0x1a67544
01a67490: ldr      w8, [sp, #0x14]
01a67494: ldr      w9, [sp, #0x24]
01a67498: mov      x27, x0
01a6749c: mov      w28, wzr
01a674a0: mov      w21, #1
01a674a4: mov      x24, #0x100000000
01a674a8: sdiv     w29, w9, w8
01a674ac: msub     w8, w29, w8, w9
01a674b0: str      w8, [sp, #0x20]
01a674b4: adrp     x8, #0x220f000
01a674b8: mov      x0, x26
01a674bc: mov      w1, w28
01a674c0: ldr      x8, [x8, #0x68]
01a674c4: ldr      x2, [x8]
01a674c8: add      x8, sp, #0xf0
01a674cc: bl       #0x145a890 ;
01a674d0: ldp      w22, w23, [sp, #0xf0]
01a674d4: ldr      w20, [sp, #0xf8]
01a674d8: ldrb     w25, [sp, #0xfc]
01a674dc: ldr      w19, [sp, #0x100]
01a674e0: cbnz     w22, #0x1a674ec
01a674e4: cmp      w23, w29
01a674e8: b.eq     #0x1a67500
01a674ec: cmp      w22, #1
01a674f0: b.ne     #0x1a67530
01a674f4: ldr      w8, [sp, #0x20]
01a674f8: cmp      w23, w8
01a674fc: b.ne     #0x1a67530
01a67500: adrp     x8, #0x2212000
01a67504: ldr      x8, [x8, #0x60]
01a67508: ldr      x0, [x8]
01a6750c: ldr      w8, [x0, #0xe4]
01a67510: cbnz     w8, #0x1a67518
01a67514: bl       #0xe54d80 ;
01a67518: mov      x0, x27
01a6751c: mov      w1, w28
01a67520: bl       #0x1a681ec ; PairzzleHintReasons.ScopeCellsOf
01a67524: ldr      w1, [sp, #0x24]
01a67528: bl       #0x1a682d0 ; PairzzleHintReasons.ScopeContains
01a6752c: tbnz     w0, #0, #0x1a67558
01a67530: ldr      w8, [x26, #0x18]
01a67534: add      w28, w28, #1
01a67538: add      x21, x21, x24
01a6753c: cmp      w28, w8
01a67540: b.lt     #0x1a674b4
01a67544: movi     v0.2d, #0000000000000000
01a67548: ldr      x8, [sp, #0x18]
01a6754c: str      xzr, [x8, #0x20]
01a67550: stp      q0, q0, [x8]
01a67554: b        #0x1a67848 ;
01a67558: adrp     x8, #0x2212000
01a6755c: cmp      w20, #2
01a67560: ldr      x8, [x8, #0x108]
01a67564: ldr      x0, [x8]
01a67568: b.ne     #0x1a67650
01a6756c: mov      w1, #3
01a67570: bl       #0xe54cf0 ;
01a67574: adrp     x8, #0x2212000
01a67578: mov      x24, x0
01a6757c: ldr      x8, [x8, #0x60]
01a67580: ldr      x8, [x8]
01a67584: ldr      w9, [x8, #0xe4]
01a67588: cbnz     w9, #0x1a67594
01a6758c: mov      x0, x8
01a67590: bl       #0xe54d80 ;
01a67594: add      x8, sp, #0x58
01a67598: mov      w0, w22
01a6759c: bl       #0x1a67c68 ; PairzzleHintReasons.LineArg
01a675a0: cbz      x24, #0x1a67868
01a675a4: ldr      w8, [x24, #0x18]
01a675a8: cbz      w8, #0x1a6786c
01a675ac: ldur     q0, [sp, #0x58]
01a675b0: ldr      x8, [sp, #0x68]
01a675b4: add      x0, x24, #0x20
01a675b8: mov      x1, xzr
01a675bc: str      q0, [x24, #0x20]
01a675c0: str      x8, [x24, #0x30]
01a675c4: bl       #0xe54bf4 ;
01a675c8: adrp     x8, #0x2212000
01a675cc: mov      w1, w25
01a675d0: ldr      x8, [x8, #0x1a8]
01a675d4: ldr      x0, [x8]
01a675d8: add      x8, sp, #0x40
01a675dc: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a675e0: ldr      w8, [x24, #0x18]
01a675e4: tst      w8, #0xfffffffe
01a675e8: b.eq     #0x1a6786c
01a675ec: ldr      q0, [sp, #0x40]
01a675f0: ldr      x8, [sp, #0x50]
01a675f4: add      x0, x24, #0x38
01a675f8: mov      x1, xzr
01a675fc: stur     q0, [x24, #0x38]
01a67600: str      x8, [x24, #0x48]
01a67604: bl       #0xe54bf4 ;
01a67608: adrp     x8, #0x2212000
01a6760c: ldr      x8, [x8, #0x140]
01a67610: ldr      w1, [sp, #0x10]
01a67614: ldr      x0, [x8]
01a67618: add      x8, sp, #0x28
01a6761c: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a67620: ldr      w8, [x24, #0x18]
01a67624: add      x20, sp, #0xd0
01a67628: cmp      w8, #2
01a6762c: b.ls     #0x1a6786c
01a67630: adrp     x19, #0x2212000
01a67634: ldur     q0, [sp, #0x28]
01a67638: ldr      x8, [sp, #0x38]
01a6763c: ldr      x19, [x19, #0x1a0]
01a67640: add      x0, x24, #0x50
01a67644: str      q0, [x24, #0x50]
01a67648: str      x8, [x24, #0x60]
01a6764c: b        #0x1a67774 ;
01a67650: mov      w1, #4
01a67654: bl       #0xe54cf0 ;
01a67658: adrp     x8, #0x2212000
01a6765c: mov      x24, x0
01a67660: ldr      x8, [x8, #0x60]
01a67664: ldr      x8, [x8]
01a67668: ldr      w9, [x8, #0xe4]
01a6766c: cbnz     w9, #0x1a67678
01a67670: mov      x0, x8
01a67674: bl       #0xe54d80 ;
01a67678: add      x8, sp, #0xb8
01a6767c: mov      w0, w22
01a67680: bl       #0x1a67c68 ; PairzzleHintReasons.LineArg
01a67684: cbz      x24, #0x1a67868
01a67688: ldr      w8, [x24, #0x18]
01a6768c: cbz      w8, #0x1a6786c
01a67690: ldur     q0, [sp, #0xb8]
01a67694: ldr      x8, [sp, #0xc8]
01a67698: add      x0, x24, #0x20
01a6769c: mov      x1, xzr
01a676a0: str      q0, [x24, #0x20]
01a676a4: str      x8, [x24, #0x30]
01a676a8: bl       #0xe54bf4 ;
01a676ac: adrp     x8, #0x2212000
01a676b0: cmp      w20, #1
01a676b4: ldr      x8, [x8, #0x150]
01a676b8: cinc     w1, w19, eq
01a676bc: ldr      x0, [x8]
01a676c0: add      x8, sp, #0xa0
01a676c4: bl       #0x1a67d28 ; PairzzleHintReasons.NumberArg
01a676c8: ldr      w8, [x24, #0x18]
01a676cc: tst      w8, #0xfffffffe
01a676d0: b.eq     #0x1a6786c
01a676d4: ldr      q0, [sp, #0xa0]
01a676d8: ldr      x8, [sp, #0xb0]
01a676dc: add      x0, x24, #0x38
01a676e0: mov      x1, xzr
01a676e4: stur     q0, [x24, #0x38]
01a676e8: str      x8, [x24, #0x48]
01a676ec: bl       #0xe54bf4 ;
01a676f0: adrp     x8, #0x2212000
01a676f4: mov      w1, w25
01a676f8: ldr      x8, [x8, #0x1a8]
01a676fc: ldr      x0, [x8]
01a67700: add      x8, sp, #0x88
01a67704: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a67708: ldr      w8, [x24, #0x18]
01a6770c: cmp      w8, #2
01a67710: b.ls     #0x1a6786c
01a67714: ldur     q0, [sp, #0x88]
01a67718: ldr      x8, [sp, #0x98]
01a6771c: add      x0, x24, #0x50
01a67720: mov      x1, xzr
01a67724: str      q0, [x24, #0x50]
01a67728: str      x8, [x24, #0x60]
01a6772c: bl       #0xe54bf4 ;
01a67730: adrp     x8, #0x2212000
01a67734: ldr      x8, [x8, #0x140]
01a67738: ldr      w1, [sp, #0x10]
01a6773c: ldr      x0, [x8]
01a67740: add      x8, sp, #0x70
01a67744: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a67748: ldr      w8, [x24, #0x18]
01a6774c: add      x20, sp, #0xd0
01a67750: tst      w8, #0xfffffffc
01a67754: b.eq     #0x1a6786c
01a67758: ldr      q0, [sp, #0x70]
01a6775c: ldr      x8, [sp, #0x80]
01a67760: adrp     x19, #0x2212000
01a67764: ldr      x19, [x19, #0x198]
01a67768: add      x0, x24, #0x68
01a6776c: stur     q0, [x24, #0x68]
01a67770: str      x8, [x24, #0x78]
01a67774: mov      x1, xzr
01a67778: bl       #0xe54bf4 ;
01a6777c: movi     v0.2d, #0000000000000000
01a67780: ldr      x1, [x19]
01a67784: add      x0, sp, #0xd0
01a67788: add      x19, sp, #0xd0
01a6778c: stp      q0, q0, [x20]
01a67790: str      x1, [sp, #0xd0]
01a67794: bl       #0xe54bf4 ;
01a67798: orr      x0, x19, #8
01a6779c: mov      x1, x24
01a677a0: str      x24, [sp, #0xd8]
01a677a4: bl       #0xe54bf4 ;
01a677a8: adrp     x8, #0x2212000
01a677ac: ldr      x8, [x8, #0x60]
01a677b0: ldr      x0, [x8]
01a677b4: ldr      w8, [x0, #0xe4]
01a677b8: cbnz     w8, #0x1a677c0
01a677bc: bl       #0xe54d80 ;
01a677c0: ldr      w0, [sp, #0x14]
01a677c4: mov      w1, w22
01a677c8: mov      w2, w23
01a677cc: bl       #0x1a67d8c ; PairzzleHintReasons.LineCells
01a677d0: mov      x1, x0
01a677d4: str      x0, [sp, #0xe0]
01a677d8: add      x0, x19, #0x10
01a677dc: bl       #0xe54bf4 ;
01a677e0: adrp     x8, #0x2212000
01a677e4: mov      w1, #1
01a677e8: ldr      x8, [x8, #0x100]
01a677ec: ldr      x0, [x8]
01a677f0: bl       #0xe54cf0 ;
01a677f4: cbz      x0, #0x1a67868
01a677f8: ldr      w8, [x0, #0x18]
01a677fc: mov      x1, x0
01a67800: cbz      w8, #0x1a6786c
01a67804: add      x8, sp, #0xd0
01a67808: str      x21, [x1, #0x20]
01a6780c: add      x0, x8, #0x18
01a67810: str      x1, [sp, #0xe8]
01a67814: bl       #0xe54bf4 ;
01a67818: ldp      q1, q2, [x20]
01a6781c: adrp     x8, #0x2212000
01a67820: movi     v0.2d, #0000000000000000
01a67824: add      x1, sp, #0xf0
01a67828: str      q1, [x20, #0x20]
01a6782c: ldr      x8, [x8, #0x148]
01a67830: ldr      x0, [sp, #0x18]
01a67834: str      q2, [x20, #0x30]
01a67838: ldr      x2, [x8]
01a6783c: stp      q0, q0, [x0]
01a67840: str      xzr, [x0, #0x20]
01a67844: bl       #0x14ff434 ;
01a67848: ldp      x20, x19, [sp, #0x160]
01a6784c: ldp      x22, x21, [sp, #0x150]
01a67850: ldp      x24, x23, [sp, #0x140]
01a67854: ldp      x26, x25, [sp, #0x130]
01a67858: ldp      x28, x27, [sp, #0x120]
01a6785c: ldp      x29, x30, [sp, #0x110]
01a67860: add      sp, sp, #0x170
01a67864: ret
01a67868: bl       #0xe54eac ;
01a6786c: bl       #0xe54eb4 ;
