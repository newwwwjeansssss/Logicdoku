// Data.Pairzzle.PairzzleHintReasons.Of token=0x6000fe3 VA=0x1a643d4
01a643d4: sub      sp, sp, #0x110
01a643d8: stp      x29, x30, [sp, #0xb0]
01a643dc: stp      x28, x27, [sp, #0xc0]
01a643e0: stp      x26, x25, [sp, #0xd0]
01a643e4: stp      x24, x23, [sp, #0xe0]
01a643e8: stp      x22, x21, [sp, #0xf0]
01a643ec: stp      x20, x19, [sp, #0x100]
01a643f0: adrp     x19, #0x2387000
01a643f4: mov      w21, w4
01a643f8: mov      w20, w3
01a643fc: ldrb     w9, [x19, #0xcc7]
01a64400: mov      x26, x2
01a64404: mov      x22, x1
01a64408: mov      x23, x8
01a6440c: str      x0, [sp, #0x18]
01a64410: tbnz     w9, #0, #0x1a64470
01a64414: adrp     x0, #0x21f0000
01a64418: ldr      x0, [x0, #0xfd8]
01a6441c: bl       #0xe54c48 ;
01a64420: adrp     x0, #0x2212000
01a64424: ldr      x0, [x0, #0x18]
01a64428: bl       #0xe54c48 ;
01a6442c: adrp     x0, #0x2212000
01a64430: ldr      x0, [x0, #0x20]
01a64434: bl       #0xe54c48 ;
01a64438: adrp     x0, #0x2212000
01a6443c: ldr      x0, [x0, #0x28]
01a64440: bl       #0xe54c48 ;
01a64444: adrp     x0, #0x2212000
01a64448: ldr      x0, [x0, #0x70]
01a6444c: bl       #0xe54c48 ;
01a64450: adrp     x0, #0x2212000
01a64454: ldr      x0, [x0, #0x78]
01a64458: bl       #0xe54c48 ;
01a6445c: adrp     x0, #0x2212000
01a64460: ldr      x0, [x0, #0x60]
01a64464: bl       #0xe54c48 ;
01a64468: mov      w8, #1
01a6446c: strb     w8, [x19, #0xcc7]
01a64470: movi     v0.2d, #0000000000000000
01a64474: and      w8, w21, #0xff
01a64478: mov      w9, #2
01a6447c: cmp      w8, #2
01a64480: str      xzr, [sp, #0xa0]
01a64484: cset     w10, eq
01a64488: cmp      w8, #1
01a6448c: csel     w24, w9, w10, eq
01a64490: stp      q0, q0, [sp, #0x80]
01a64494: cbz      x22, #0x1a646c8
01a64498: mov      x0, x22
01a6449c: bl       #0x1a6128c ; PairzzleBoardState.Clone
01a644a0: cbz      x0, #0x1a646c8
01a644a4: mov      w1, w20
01a644a8: mov      w2, w24
01a644ac: mov      x25, x0
01a644b0: str      x23, [sp, #0x10]
01a644b4: bl       #0x1a60bec ; PairzzleBoardState.Set
01a644b8: cbz      x26, #0x1a646c8
01a644bc: ldr      x26, [x26, #0x10]
01a644c0: cbz      x26, #0x1a646c8
01a644c4: ldr      w8, [x26, #0x18]
01a644c8: cmp      w8, #1
01a644cc: b.lt     #0x1a64628
01a644d0: adrp     x19, #0x2212000
01a644d4: adrp     x29, #0x2212000
01a644d8: adrp     x23, #0x21f0000
01a644dc: ldr      x19, [x19, #0x28]
01a644e0: ldr      x29, [x29, #0x18]
01a644e4: ldr      x23, [x23, #0xfd8]
01a644e8: mov      w27, wzr
01a644ec: ldr      x2, [x19]
01a644f0: mov      x0, x26
01a644f4: mov      w1, w27
01a644f8: bl       #0x145391c ;
01a644fc: cbz      x0, #0x1a646c8
01a64500: ldr      x8, [x0]
01a64504: ldr      x1, [x29]
01a64508: mov      x28, x0
01a6450c: ldrh     w9, [x8, #0x12e]
01a64510: cbz      x9, #0x1a64534
01a64514: ldr      x10, [x8, #0xb0]
01a64518: add      x10, x10, #8
01a6451c: ldur     x11, [x10, #-8]
01a64520: cmp      x11, x1
01a64524: b.eq     #0x1a64544
01a64528: subs     x9, x9, #1
01a6452c: add      x10, x10, #0x10
01a64530: b.ne     #0x1a6451c
01a64534: mov      x0, x28
01a64538: mov      w2, #1
01a6453c: bl       #0xe8c450 ;
01a64540: b        #0x1a64554 ;
01a64544: ldr      w9, [x10]
01a64548: add      w9, w9, #1
01a6454c: add      x8, x8, w9, sxtw #4
01a64550: add      x0, x8, #0x138
01a64554: ldp      x8, x2, [x0]
01a64558: mov      x0, x28
01a6455c: mov      x1, x25
01a64560: blr      x8
01a64564: cbz      x0, #0x1a646c8
01a64568: ldr      x2, [x23]
01a6456c: mov      w1, w20
01a64570: bl       #0x136a094 ;
01a64574: tbz      w0, #0, #0x1a64618
01a64578: ldr      x8, [x28]
01a6457c: ldr      x1, [x29]
01a64580: ldrh     w9, [x8, #0x12e]
01a64584: cbz      x9, #0x1a645a8
01a64588: ldr      x10, [x8, #0xb0]
01a6458c: add      x10, x10, #8
01a64590: ldur     x11, [x10, #-8]
01a64594: cmp      x11, x1
01a64598: b.eq     #0x1a645b8
01a6459c: subs     x9, x9, #1
01a645a0: add      x10, x10, #0x10
01a645a4: b.ne     #0x1a64590
01a645a8: mov      x0, x28
01a645ac: mov      w2, wzr
01a645b0: bl       #0xe8c450 ;
01a645b4: b        #0x1a645c4 ;
01a645b8: ldrsw    x9, [x10]
01a645bc: add      x8, x8, x9, lsl #4
01a645c0: add      x0, x8, #0x138
01a645c4: ldp      x8, x1, [x0]
01a645c8: mov      x0, x28
01a645cc: blr      x8
01a645d0: adrp     x8, #0x2212000
01a645d4: mov      x28, x0
01a645d8: ldr      x8, [x8, #0x60]
01a645dc: ldr      x8, [x8]
01a645e0: ldr      w9, [x8, #0xe4]
01a645e4: cbnz     w9, #0x1a645f0
01a645e8: mov      x0, x8
01a645ec: bl       #0xe54d80 ;
01a645f0: ldr      x0, [sp, #0x18]
01a645f4: add      x8, sp, #0x80
01a645f8: mov      x1, x22
01a645fc: mov      x2, x28
01a64600: mov      w3, w20
01a64604: mov      w4, w21
01a64608: mov      w5, w24
01a6460c: bl       #0x1a65fe4 ; PairzzleHintReasons.Build
01a64610: ldrb     w8, [sp, #0x80]
01a64614: cbnz     w8, #0x1a64654
01a64618: ldr      w8, [x26, #0x18]
01a6461c: add      w27, w27, #1
01a64620: cmp      w27, w8
01a64624: b.lt     #0x1a644ec
01a64628: adrp     x8, #0x2212000
01a6462c: ldr      x8, [x8, #0x60]
01a64630: ldr      x0, [x8]
01a64634: ldr      w8, [x0, #0xe4]
01a64638: cbnz     w8, #0x1a64640
01a6463c: bl       #0xe54d80 ;
01a64640: add      x8, sp, #0x60
01a64644: mov      w0, w21
01a64648: bl       #0x1a66424 ; PairzzleHintReasons.Fallback
01a6464c: ldp      q0, q1, [sp, #0x60]
01a64650: b        #0x1a646a0 ;
01a64654: adrp     x8, #0x2212000
01a64658: add      x0, sp, #0x80
01a6465c: ldr      x8, [x8, #0x78]
01a64660: ldr      x1, [x8]
01a64664: add      x8, sp, #0x60
01a64668: bl       #0x14ff46c ;
01a6466c: adrp     x8, #0x2212000
01a64670: ldr      x8, [x8, #0x60]
01a64674: ldr      x0, [x8]
01a64678: ldr      w8, [x0, #0xe4]
01a6467c: cbnz     w8, #0x1a64684
01a64680: bl       #0xe54d80 ;
01a64684: ldp      q0, q1, [sp, #0x60]
01a64688: add      x8, sp, #0x40
01a6468c: add      x0, sp, #0x20
01a64690: mov      w1, w20
01a64694: stp      q0, q1, [sp, #0x20]
01a64698: bl       #0x1a66278 ; PairzzleHintReasons.WithoutTarget
01a6469c: ldp      q0, q1, [sp, #0x40]
01a646a0: ldr      x8, [sp, #0x10]
01a646a4: ldp      x20, x19, [sp, #0x100]
01a646a8: ldp      x22, x21, [sp, #0xf0]
01a646ac: ldp      x24, x23, [sp, #0xe0]
01a646b0: stp      q0, q1, [x8]
01a646b4: ldp      x26, x25, [sp, #0xd0]
01a646b8: ldp      x28, x27, [sp, #0xc0]
01a646bc: ldp      x29, x30, [sp, #0xb0]
01a646c0: add      sp, sp, #0x110
01a646c4: ret
01a646c8: bl       #0xe54eac ;
