// Data.Pairzzle.PairzzleHintReasons.WithoutTarget token=0x6000fe6 VA=0x1a66278
01a66278: stp      x30, x27, [sp, #-0x50]!
01a6627c: stp      x26, x25, [sp, #0x10]
01a66280: stp      x24, x23, [sp, #0x20]
01a66284: stp      x22, x21, [sp, #0x30]
01a66288: stp      x20, x19, [sp, #0x40]
01a6628c: adrp     x22, #0x2387000
01a66290: mov      w21, w1
01a66294: mov      x19, x0
01a66298: ldrb     w9, [x22, #0xcca]
01a6629c: mov      x20, x8
01a662a0: tbnz     w9, #0, #0x1a662e8
01a662a4: adrp     x0, #0x21f0000
01a662a8: ldr      x0, [x0, #0x470]
01a662ac: bl       #0xe54c48 ; 
01a662b0: adrp     x0, #0x21f1000
01a662b4: ldr      x0, [x0, #0x3f0]
01a662b8: bl       #0xe54c48 ; 
01a662bc: adrp     x0, #0x2206000
01a662c0: ldr      x0, [x0, #0x218]
01a662c4: bl       #0xe54c48 ; 
01a662c8: adrp     x0, #0x21f1000
01a662cc: ldr      x0, [x0, #0x690]
01a662d0: bl       #0xe54c48 ; 
01a662d4: adrp     x0, #0x21f1000
01a662d8: ldr      x0, [x0, #0x688]
01a662dc: bl       #0xe54c48 ; 
01a662e0: mov      w8, #1
01a662e4: strb     w8, [x22, #0xcca]
01a662e8: mov      x22, x19
01a662ec: ldr      x24, [x22, #0x10]!
01a662f0: cbz      x24, #0x1a663d8
01a662f4: ldr      x8, [x24, #0x18]
01a662f8: cbz      x8, #0x1a663d8
01a662fc: adrp     x8, #0x21f1000
01a66300: ldr      x8, [x8, #0x688]
01a66304: ldr      x0, [x8]
01a66308: bl       #0xe54e9c ; 
01a6630c: adrp     x8, #0x21f1000
01a66310: mov      x23, x0
01a66314: ldr      x8, [x8, #0x690]
01a66318: ldr      w1, [x24, #0x18]
01a6631c: ldr      x2, [x8]
01a66320: bl       #0x140403c ; 
01a66324: ldr      x8, [x24, #0x18]
01a66328: cmp      w8, #1
01a6632c: b.lt     #0x1a663bc
01a66330: adrp     x26, #0x21f1000
01a66334: mov      x25, xzr
01a66338: and      x8, x8, #0xffffffff
01a6633c: ldr      x26, [x26, #0x3f0]
01a66340: add      x27, x24, #0x20
01a66344: cmp      x25, w8, uxtw
01a66348: b.hs     #0x1a66420
01a6634c: ldr      w1, [x27, x25, lsl #2]
01a66350: cmp      w1, w21
01a66354: b.eq     #0x1a663b0
01a66358: cbz      x23, #0x1a6641c
01a6635c: ldr      w11, [x23, #0x1c]
01a66360: ldr      x9, [x23, #0x10]
01a66364: ldr      x10, [x26]
01a66368: add      w11, w11, #1
01a6636c: str      w11, [x23, #0x1c]
01a66370: cbz      x9, #0x1a6641c
01a66374: ldrsw    x11, [x23, #0x18]
01a66378: ldr      w12, [x9, #0x18]
01a6637c: cmp      w11, w12
01a66380: b.hs     #0x1a66398
01a66384: add      x9, x9, x11, lsl #2
01a66388: add      w10, w11, #1
01a6638c: str      w10, [x23, #0x18]
01a66390: str      w1, [x9, #0x20]
01a66394: b        #0x1a663b0 ; 
01a66398: ldr      x8, [x10, #0x20]
01a6639c: mov      x0, x23
01a663a0: ldr      x8, [x8, #0xc0]
01a663a4: ldr      x2, [x8, #0x70]
01a663a8: bl       #0x1404854 ; 
01a663ac: ldr      w8, [x24, #0x18]
01a663b0: add      x25, x25, #1
01a663b4: cmp      x25, w8, sxtw
01a663b8: b.lt     #0x1a66344
01a663bc: cbz      x23, #0x1a6641c
01a663c0: adrp     x8, #0x2206000
01a663c4: mov      x0, x23
01a663c8: ldr      x8, [x8, #0x218]
01a663cc: ldr      x1, [x8]
01a663d0: bl       #0x1405f58 ; 
01a663d4: b        #0x1a663ec ; 
01a663d8: adrp     x8, #0x21f0000
01a663dc: mov      w1, wzr
01a663e0: ldr      x8, [x8, #0x470]
01a663e4: ldr      x0, [x8]
01a663e8: bl       #0xe54cf0 ; 
01a663ec: mov      x1, x0
01a663f0: str      x0, [x19, #0x10]
01a663f4: mov      x0, x22
01a663f8: bl       #0xe54bf4 ; 
01a663fc: ldp      q0, q1, [x19]
01a66400: ldp      x22, x21, [sp, #0x30]
01a66404: ldp      x24, x23, [sp, #0x20]
01a66408: stp      q0, q1, [x20]
01a6640c: ldp      x20, x19, [sp, #0x40]
01a66410: ldp      x26, x25, [sp, #0x10]
01a66414: ldp      x30, x27, [sp], #0x50
01a66418: ret      
01a6641c: bl       #0xe54eac ; 
01a66420: bl       #0xe54eb4 ; 