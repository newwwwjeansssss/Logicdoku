// Data.Pairzzle.PairzzleRuleSet.HasViolation token=0x6001056 VA=0x1a6d2a4
01a6d2a4: stp      x30, x25, [sp, #-0x40]!
01a6d2a8: stp      x24, x23, [sp, #0x10]
01a6d2ac: stp      x22, x21, [sp, #0x20]
01a6d2b0: stp      x20, x19, [sp, #0x30]
01a6d2b4: adrp     x21, #0x2387000
01a6d2b8: mov      x19, x1
01a6d2bc: mov      x20, x0
01a6d2c0: ldrb     w8, [x21, #0xd1d]
01a6d2c4: tbnz     w8, #0, #0x1a6d300
01a6d2c8: adrp     x0, #0x2212000
01a6d2cc: ldr      x0, [x0, #0xd8]
01a6d2d0: bl       #0xe54c48 ;
01a6d2d4: adrp     x0, #0x2212000
01a6d2d8: ldr      x0, [x0, #0x18]
01a6d2dc: bl       #0xe54c48 ;
01a6d2e0: adrp     x0, #0x2212000
01a6d2e4: ldr      x0, [x0, #0x20]
01a6d2e8: bl       #0xe54c48 ;
01a6d2ec: adrp     x0, #0x2212000
01a6d2f0: ldr      x0, [x0, #0x28]
01a6d2f4: bl       #0xe54c48 ;
01a6d2f8: mov      w8, #1
01a6d2fc: strb     w8, [x21, #0xd1d]
01a6d300: ldr      x0, [x20, #0x10]
01a6d304: cbz      x0, #0x1a6d3b8
01a6d308: adrp     x23, #0x2212000
01a6d30c: adrp     x24, #0x2212000
01a6d310: mov      w21, wzr
01a6d314: ldr      x23, [x23, #0x28]
01a6d318: ldr      x24, [x24, #0x18]
01a6d31c: ldr      w25, [x0, #0x18]
01a6d320: cmp      w21, w25
01a6d324: b.ge     #0x1a6d3bc
01a6d328: ldr      x2, [x23]
01a6d32c: mov      w1, w21
01a6d330: bl       #0x145391c ;
01a6d334: cbz      x0, #0x1a6d3b8
01a6d338: ldr      x8, [x0]
01a6d33c: ldr      x1, [x24]
01a6d340: mov      x22, x0
01a6d344: ldrh     w9, [x8, #0x12e]
01a6d348: cbz      x9, #0x1a6d36c
01a6d34c: ldr      x10, [x8, #0xb0]
01a6d350: add      x10, x10, #8
01a6d354: ldur     x11, [x10, #-8]
01a6d358: cmp      x11, x1
01a6d35c: b.eq     #0x1a6d37c
01a6d360: subs     x9, x9, #1
01a6d364: add      x10, x10, #0x10
01a6d368: b.ne     #0x1a6d354
01a6d36c: mov      x0, x22
01a6d370: mov      w2, #1
01a6d374: bl       #0xe8c450 ;
01a6d378: b        #0x1a6d38c ;
01a6d37c: ldr      w9, [x10]
01a6d380: add      w9, w9, #1
01a6d384: add      x8, x8, w9, sxtw #4
01a6d388: add      x0, x8, #0x138
01a6d38c: ldp      x8, x2, [x0]
01a6d390: mov      x0, x22
01a6d394: mov      x1, x19
01a6d398: blr      x8
01a6d39c: cbz      x0, #0x1a6d3b8
01a6d3a0: ldr      w8, [x0, #0x20]
01a6d3a4: cmp      w8, #0
01a6d3a8: b.gt     #0x1a6d3bc
01a6d3ac: ldr      x0, [x20, #0x10]
01a6d3b0: add      w21, w21, #1
01a6d3b4: cbnz     x0, #0x1a6d31c
01a6d3b8: bl       #0xe54eac ;
01a6d3bc: cmp      w21, w25
01a6d3c0: ldp      x20, x19, [sp, #0x30]
01a6d3c4: ldp      x22, x21, [sp, #0x20]
01a6d3c8: cset     w0, lt
01a6d3cc: ldp      x24, x23, [sp, #0x10]
01a6d3d0: ldp      x30, x25, [sp], #0x40
01a6d3d4: ret
