// Data.Pairzzle.PairzzleHintReasons.Balance token=0x6000fe7 VA=0x1a665a0
01a665a0: sub      sp, sp, #0x130
01a665a4: stp      x29, x30, [sp, #0xd0]
01a665a8: stp      x28, x27, [sp, #0xe0]
01a665ac: stp      x26, x25, [sp, #0xf0]
01a665b0: stp      x24, x23, [sp, #0x100]
01a665b4: stp      x22, x21, [sp, #0x110]
01a665b8: stp      x20, x19, [sp, #0x120]
01a665bc: adrp     x19, #0x2387000
01a665c0: mov      w23, w2
01a665c4: mov      x24, x1
01a665c8: ldrb     w9, [x19, #0xccb]
01a665cc: mov      x25, x0
01a665d0: str      w4, [sp, #0x2c]
01a665d4: str      w3, [sp, #0x10]
01a665d8: str      x8, [sp, #0x18]
01a665dc: tbnz     w9, #0, #0x1a6663c
01a665e0: adrp     x0, #0x2212000
01a665e4: ldr      x0, [x0, #0x148]
01a665e8: bl       #0xe54c48 ;
01a665ec: adrp     x0, #0x2212000
01a665f0: ldr      x0, [x0, #0x108]
01a665f4: bl       #0xe54c48 ;
01a665f8: adrp     x0, #0x2212000
01a665fc: ldr      x0, [x0, #0x60]
01a66600: bl       #0xe54c48 ;
01a66604: adrp     x0, #0x2212000
01a66608: ldr      x0, [x0, #0x150]
01a6660c: bl       #0xe54c48 ;
01a66610: adrp     x0, #0x2212000
01a66614: ldr      x0, [x0, #0x158]
01a66618: bl       #0xe54c48 ;
01a6661c: adrp     x0, #0x2212000
01a66620: ldr      x0, [x0, #0x140]
01a66624: bl       #0xe54c48 ;
01a66628: adrp     x0, #0x21f9000
01a6662c: ldr      x0, [x0, #0xc20]
01a66630: bl       #0xe54c48 ;
01a66634: mov      w8, #1
01a66638: strb     w8, [x19, #0xccb]
01a6663c: movi     v0.2d, #0000000000000000
01a66640: stp      q0, q0, [sp, #0x90]
01a66644: cbz      x25, #0x1a6691c
01a66648: ldr      w29, [x25, #0x10]
01a6664c: mov      w20, wzr
01a66650: sdiv     w8, w23, w29
01a66654: msub     w9, w8, w29, w23
01a66658: str      w8, [sp, #0x14]
01a6665c: mul      w8, w8, w29
01a66660: stp      w8, w9, [sp, #0x24]
01a66664: cmp      w29, #1
01a66668: b.lt     #0x1a666e8
01a6666c: ldp      w27, w21, [sp, #0x24]
01a66670: mov      w28, wzr
01a66674: mov      w19, wzr
01a66678: mov      w22, w29
01a6667c: cmp      w20, #0
01a66680: mov      x0, x25
01a66684: csel     w26, w21, w27, ne
01a66688: mov      w1, w26
01a6668c: bl       #0x1a609fc ; PairzzlePuzzle.IsHole
01a66690: tbnz     w0, #0, #0x1a666d4
01a66694: cmp      w26, w23
01a66698: add      w28, w28, #1
01a6669c: b.eq     #0x1a666d4
01a666a0: cbz      x24, #0x1a6691c
01a666a4: ldr      x8, [x24, #0x18]
01a666a8: cbz      x8, #0x1a6691c
01a666ac: ldr      w9, [x8, #0x18]
01a666b0: cmp      w26, w9
01a666b4: b.hs     #0x1a66920
01a666b8: add      x8, x8, w26, sxtw
01a666bc: ldr      w9, [sp, #0x2c]
01a666c0: ldrb     w8, [x8, #0x20]
01a666c4: and      w9, w9, #0xff
01a666c8: cmp      w8, #0
01a666cc: ccmp     w8, w9, #0, ne
01a666d0: cinc     w19, w19, eq
01a666d4: subs     w22, w22, #1
01a666d8: add      w21, w21, w29
01a666dc: add      w27, w27, #1
01a666e0: b.ne     #0x1a6667c
01a666e4: b        #0x1a666f0 ;
01a666e8: mov      w19, wzr
01a666ec: mov      w28, wzr
01a666f0: cmp      w28, #0
01a666f4: cinc     w21, w28, lt
01a666f8: cmp      w19, w21, asr #1
01a666fc: b.ge     #0x1a66720
01a66700: add      w20, w20, #1
01a66704: cmp      w20, #2
01a66708: b.ne     #0x1a66664
01a6670c: movi     v0.2d, #0000000000000000
01a66710: ldr      x8, [sp, #0x18]
01a66714: str      xzr, [x8, #0x20]
01a66718: stp      q0, q0, [x8]
01a6671c: b        #0x1a668fc ;
01a66720: adrp     x8, #0x2212000
01a66724: movi     v0.2d, #0000000000000000
01a66728: cmp      w20, #0
01a6672c: ldr      x8, [x8, #0x158]
01a66730: ldr      w9, [sp, #0x28]
01a66734: add      x0, sp, #0x90
01a66738: cset     w23, ne
01a6673c: ldr      x1, [x8]
01a66740: ldr      w8, [sp, #0x14]
01a66744: stp      q0, q0, [sp, #0x90]
01a66748: csel     w24, w9, w8, ne
01a6674c: str      x1, [sp, #0x90]
01a66750: bl       #0xe54bf4 ;
01a66754: adrp     x8, #0x2212000
01a66758: mov      w1, #4
01a6675c: ldr      x8, [x8, #0x108]
01a66760: ldr      x0, [x8]
01a66764: bl       #0xe54cf0 ;
01a66768: adrp     x20, #0x2212000
01a6676c: mov      x25, x0
01a66770: ldr      x20, [x20, #0x60]
01a66774: ldr      x8, [x20]
01a66778: ldr      w9, [x8, #0xe4]
01a6677c: cbnz     w9, #0x1a66788
01a66780: mov      x0, x8
01a66784: bl       #0xe54d80 ;
01a66788: add      x8, sp, #0x78
01a6678c: mov      w0, w23
01a66790: bl       #0x1a67c68 ; PairzzleHintReasons.LineArg
01a66794: cbz      x25, #0x1a6691c
01a66798: ldr      w8, [x25, #0x18]
01a6679c: cbz      w8, #0x1a66920
01a667a0: ldur     q0, [sp, #0x78]
01a667a4: ldr      x8, [sp, #0x88]
01a667a8: add      x0, x25, #0x20
01a667ac: mov      x1, xzr
01a667b0: asr      w26, w21, #1
01a667b4: str      q0, [x25, #0x20]
01a667b8: str      x8, [x25, #0x30]
01a667bc: bl       #0xe54bf4 ;
01a667c0: adrp     x8, #0x2212000
01a667c4: mov      w1, w26
01a667c8: ldr      x8, [x8, #0x150]
01a667cc: ldr      x0, [x8]
01a667d0: add      x8, sp, #0x60
01a667d4: bl       #0x1a67d28 ; PairzzleHintReasons.NumberArg
01a667d8: ldr      w8, [x25, #0x18]
01a667dc: tst      w8, #0xfffffffe
01a667e0: b.eq     #0x1a66920
01a667e4: ldr      q0, [sp, #0x60]
01a667e8: ldr      x8, [sp, #0x70]
01a667ec: add      x0, x25, #0x38
01a667f0: mov      x1, xzr
01a667f4: stur     q0, [x25, #0x38]
01a667f8: str      x8, [x25, #0x48]
01a667fc: bl       #0xe54bf4 ;
01a66800: adrp     x8, #0x21f9000
01a66804: ldr      x8, [x8, #0xc20]
01a66808: ldr      w1, [sp, #0x2c]
01a6680c: ldr      x0, [x8]
01a66810: add      x8, sp, #0x48
01a66814: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a66818: ldr      w8, [x25, #0x18]
01a6681c: cmp      w8, #2
01a66820: b.ls     #0x1a66920
01a66824: ldur     q0, [sp, #0x48]
01a66828: ldr      x8, [sp, #0x58]
01a6682c: add      x0, x25, #0x50
01a66830: mov      x1, xzr
01a66834: str      q0, [x25, #0x50]
01a66838: str      x8, [x25, #0x60]
01a6683c: bl       #0xe54bf4 ;
01a66840: adrp     x8, #0x2212000
01a66844: ldr      x8, [x8, #0x140]
01a66848: ldr      w1, [sp, #0x10]
01a6684c: ldr      x0, [x8]
01a66850: add      x8, sp, #0x30
01a66854: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a66858: ldr      w8, [x25, #0x18]
01a6685c: tst      w8, #0xfffffffc
01a66860: b.eq     #0x1a66920
01a66864: ldr      q0, [sp, #0x30]
01a66868: ldr      x8, [sp, #0x40]
01a6686c: add      x0, x25, #0x68
01a66870: mov      x1, xzr
01a66874: stur     q0, [x25, #0x68]
01a66878: str      x8, [x25, #0x78]
01a6687c: bl       #0xe54bf4 ;
01a66880: add      x19, sp, #0x90
01a66884: mov      x1, x25
01a66888: str      x25, [sp, #0x98]
01a6688c: orr      x0, x19, #8
01a66890: bl       #0xe54bf4 ;
01a66894: mov      w0, w29
01a66898: mov      w1, w23
01a6689c: mov      w2, w24
01a668a0: bl       #0x1a67d8c ; PairzzleHintReasons.LineCells
01a668a4: mov      x1, x0
01a668a8: str      x0, [sp, #0xa0]
01a668ac: add      x0, x19, #0x10
01a668b0: bl       #0xe54bf4 ;
01a668b4: ldr      x8, [x20]
01a668b8: add      x0, x19, #0x18
01a668bc: ldr      x8, [x8, #0xb8]
01a668c0: ldr      x1, [x8]
01a668c4: str      x1, [sp, #0xa8]
01a668c8: bl       #0xe54bf4 ;
01a668cc: movi     v0.2d, #0000000000000000
01a668d0: ldp      q1, q2, [sp, #0x90]
01a668d4: ldr      x0, [sp, #0x18]
01a668d8: adrp     x8, #0x2212000
01a668dc: add      x1, sp, #0xb0
01a668e0: stp      q1, q2, [sp, #0xb0]
01a668e4: str      q0, [x0]
01a668e8: ldr      x8, [x8, #0x148]
01a668ec: str      q0, [x0, #0x10]
01a668f0: str      xzr, [x0, #0x20]
01a668f4: ldr      x2, [x8]
01a668f8: bl       #0x14ff434 ;
01a668fc: ldp      x20, x19, [sp, #0x120]
01a66900: ldp      x22, x21, [sp, #0x110]
01a66904: ldp      x24, x23, [sp, #0x100]
01a66908: ldp      x26, x25, [sp, #0xf0]
01a6690c: ldp      x28, x27, [sp, #0xe0]
01a66910: ldp      x29, x30, [sp, #0xd0]
01a66914: add      sp, sp, #0x130
01a66918: ret
01a6691c: bl       #0xe54eac ;
01a66920: bl       #0xe54eb4 ;
