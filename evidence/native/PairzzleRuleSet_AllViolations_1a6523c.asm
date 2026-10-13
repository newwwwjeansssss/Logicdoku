// Data.Pairzzle.PairzzleRuleSet.AllViolations token=0x6001054 VA=0x1a6523c
01a6523c: sub      sp, sp, #0xa0
01a65240: stp      x29, x30, [sp, #0x40]
01a65244: stp      x28, x27, [sp, #0x50]
01a65248: stp      x26, x25, [sp, #0x60]
01a6524c: stp      x24, x23, [sp, #0x70]
01a65250: stp      x22, x21, [sp, #0x80]
01a65254: stp      x20, x19, [sp, #0x90]
01a65258: adrp     x23, #0x2387000
01a6525c: adrp     x22, #0x21f1000
01a65260: adrp     x21, #0x21f1000
01a65264: ldrb     w8, [x23, #0xd1b]
01a65268: ldr      x22, [x22, #0x10]
01a6526c: ldr      x21, [x21, #0x18]
01a65270: mov      x19, x1
01a65274: mov      x20, x0
01a65278: tbnz     w8, #0, #0x1a652fc
01a6527c: adrp     x0, #0x2211000
01a65280: ldr      x0, [x0, #0xf08]
01a65284: bl       #0xe54c48 ;
01a65288: adrp     x0, #0x2211000
01a6528c: ldr      x0, [x0, #0xf10]
01a65290: bl       #0xe54c48 ;
01a65294: adrp     x0, #0x2211000
01a65298: ldr      x0, [x0, #0xf18]
01a6529c: bl       #0xe54c48 ;
01a652a0: adrp     x0, #0x21f0000
01a652a4: ldr      x0, [x0, #0xfc8]
01a652a8: bl       #0xe54c48 ;
01a652ac: adrp     x0, #0x2211000
01a652b0: ldr      x0, [x0, #0xf20]
01a652b4: bl       #0xe54c48 ;
01a652b8: adrp     x0, #0x21f1000
01a652bc: ldr      x0, [x0, #0x18]
01a652c0: bl       #0xe54c48 ;
01a652c4: adrp     x0, #0x21f1000
01a652c8: ldr      x0, [x0, #0x10]
01a652cc: bl       #0xe54c48 ;
01a652d0: adrp     x0, #0x2212000
01a652d4: ldr      x0, [x0, #0x18]
01a652d8: bl       #0xe54c48 ;
01a652dc: adrp     x0, #0x2212000
01a652e0: ldr      x0, [x0, #0x20]
01a652e4: bl       #0xe54c48 ;
01a652e8: adrp     x0, #0x2212000
01a652ec: ldr      x0, [x0, #0x28]
01a652f0: bl       #0xe54c48 ;
01a652f4: mov      w8, #1
01a652f8: strb     w8, [x23, #0xd1b]
01a652fc: ldr      x0, [x22]
01a65300: stp      xzr, xzr, [sp, #0x20]
01a65304: str      xzr, [sp, #0x30]
01a65308: bl       #0xe54e9c ;
01a6530c: ldr      x1, [x21]
01a65310: mov      x21, x0
01a65314: bl       #0x1369a80 ;
01a65318: ldr      x0, [x20, #0x10]
01a6531c: cbz      x0, #0x1a654ac
01a65320: adrp     x25, #0x2212000
01a65324: adrp     x26, #0x2211000
01a65328: adrp     x27, #0x2211000
01a6532c: adrp     x28, #0x21f0000
01a65330: adrp     x29, #0x2211000
01a65334: ldr      x25, [x25, #0x18]
01a65338: ldr      x26, [x26, #0xf20]
01a6533c: ldr      x27, [x27, #0xf10]
01a65340: ldr      x28, [x28, #0xfc8]
01a65344: ldr      x29, [x29, #0xf08]
01a65348: mov      w22, wzr
01a6534c: add      x24, sp, #0x20
01a65350: ldr      w8, [x0, #0x18]
01a65354: cmp      w22, w8
01a65358: b.ge     #0x1a65488
01a6535c: adrp     x8, #0x2212000
01a65360: mov      w1, w22
01a65364: ldr      x8, [x8, #0x28]
01a65368: ldr      x2, [x8]
01a6536c: bl       #0x145391c ;
01a65370: cbz      x0, #0x1a654ac
01a65374: ldr      x8, [x0]
01a65378: ldr      x1, [x25]
01a6537c: mov      x23, x0
01a65380: ldrh     w9, [x8, #0x12e]
01a65384: cbz      x9, #0x1a653a8
01a65388: ldr      x10, [x8, #0xb0]
01a6538c: add      x10, x10, #8
01a65390: ldur     x11, [x10, #-8]
01a65394: cmp      x11, x1
01a65398: b.eq     #0x1a653b8
01a6539c: subs     x9, x9, #1
01a653a0: add      x10, x10, #0x10
01a653a4: b.ne     #0x1a65390
01a653a8: mov      x0, x23
01a653ac: mov      w2, #1
01a653b0: bl       #0xe8c450 ;
01a653b4: b        #0x1a653c8 ;
01a653b8: ldr      w9, [x10]
01a653bc: add      w9, w9, #1
01a653c0: add      x8, x8, w9, sxtw #4
01a653c4: add      x0, x8, #0x138
01a653c8: ldp      x8, x2, [x0]
01a653cc: mov      x0, x23
01a653d0: mov      x1, x19
01a653d4: blr      x8
01a653d8: cbz      x0, #0x1a654ac
01a653dc: ldr      x1, [x26]
01a653e0: add      x8, sp, #8
01a653e4: bl       #0x136a554 ;
01a653e8: ldur     q0, [sp, #8]
01a653ec: ldr      x8, [sp, #0x18]
01a653f0: stp      xzr, x24, [sp, #8]
01a653f4: str      q0, [sp, #0x20]
01a653f8: str      x8, [sp, #0x30]
01a653fc: ldr      x1, [x27]
01a65400: add      x0, sp, #0x20
01a65404: bl       #0x129f8ec ;
01a65408: tbz      w0, #0, #0x1a65424
01a6540c: cbz      x21, #0x1a65440
01a65410: ldr      w1, [sp, #0x30]
01a65414: ldr      x2, [x28]
01a65418: mov      x0, x21
01a6541c: bl       #0x136abd0 ;
01a65420: b        #0x1a653fc ;
01a65424: ldr      x1, [x29]
01a65428: add      x0, sp, #0x20
01a6542c: bl       #0x129f8e8 ;
01a65430: ldr      x0, [x20, #0x10]
01a65434: add      w22, w22, #1
01a65438: cbnz     x0, #0x1a65350
01a6543c: b        #0x1a654ac ;
01a65440: bl       #0xe54eac ;
01a65444: b        #0x1a654b0 ;
01a65448: b        #0x1a65450 ;
01a6544c: b        #0x1a65450 ;
01a65450: mov      x23, x0
01a65454: cmp      w1, #1
01a65458: b.ne     #0x1a654b4
01a6545c: mov      x0, x23
01a65460: bl       #0x20e7080 ;
01a65464: ldr      x23, [x0]
01a65468: str      x23, [sp, #8]
01a6546c: bl       #0x20e7090 ;
01a65470: ldr      x0, [sp, #0x10]
01a65474: ldr      x1, [x29]
01a65478: bl       #0x129f8e8 ;
01a6547c: cbz      x23, #0x1a65430
01a65480: mov      x0, x23
01a65484: bl       #0xe54ea4 ;
01a65488: mov      x0, x21
01a6548c: ldp      x20, x19, [sp, #0x90]
01a65490: ldp      x22, x21, [sp, #0x80]
01a65494: ldp      x24, x23, [sp, #0x70]
01a65498: ldp      x26, x25, [sp, #0x60]
01a6549c: ldp      x28, x27, [sp, #0x50]
01a654a0: ldp      x29, x30, [sp, #0x40]
01a654a4: add      sp, sp, #0xa0
01a654a8: ret
01a654ac: bl       #0xe54eac ;
01a654b0: mov      x23, x0
01a654b4: add      x0, sp, #8
01a654b8: bl       #0xe2c2f0 ;
01a654bc: mov      x0, x23
01a654c0: bl       #0xf424fc ;
01a654c4: bl       #0xd2ead8 ;
