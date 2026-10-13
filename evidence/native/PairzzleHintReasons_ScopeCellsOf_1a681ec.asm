// Data.Pairzzle.PairzzleHintReasons.ScopeCellsOf token=0x6000fee VA=0x1a681ec
01a681ec: sub      sp, sp, #0x50
01a681f0: str      x30, [sp, #0x20]
01a681f4: stp      x22, x21, [sp, #0x30]
01a681f8: stp      x20, x19, [sp, #0x40]
01a681fc: adrp     x21, #0x2387000
01a68200: mov      w20, w1
01a68204: mov      x19, x0
01a68208: ldrb     w8, [x21, #0xcd2]
01a6820c: tbnz     w8, #0, #0x1a6823c
01a68210: adrp     x0, #0x21f0000
01a68214: ldr      x0, [x0, #0x470]
01a68218: bl       #0xe54c48 ;
01a6821c: adrp     x0, #0x220b000
01a68220: ldr      x0, [x0, #0x3e0]
01a68224: bl       #0xe54c48 ;
01a68228: adrp     x0, #0x2212000
01a6822c: ldr      x0, [x0, #0x1d8]
01a68230: bl       #0xe54c48 ;
01a68234: mov      w8, #1
01a68238: strb     w8, [x21, #0xcd2]
01a6823c: cbz      x19, #0x1a682cc
01a68240: ldr      w8, [x19, #0x18]
01a68244: cmp      w8, #1
01a68248: b.lt     #0x1a68288
01a6824c: adrp     x22, #0x2212000
01a68250: mov      w21, wzr
01a68254: ldr      x22, [x22, #0x1d8]
01a68258: ldr      x2, [x22]
01a6825c: add      x8, sp, #8
01a68260: mov      x0, x19
01a68264: mov      w1, w21
01a68268: bl       #0x1461d24 ;
01a6826c: ldr      w8, [sp, #0x18]
01a68270: cmp      w8, w20
01a68274: b.eq     #0x1a682a0
01a68278: ldr      w8, [x19, #0x18]
01a6827c: add      w21, w21, #1
01a68280: cmp      w21, w8
01a68284: b.lt     #0x1a68258
01a68288: adrp     x8, #0x21f0000
01a6828c: mov      w1, wzr
01a68290: ldr      x8, [x8, #0x470]
01a68294: ldr      x0, [x8]
01a68298: bl       #0xe54cf0 ;
01a6829c: b        #0x1a682b8 ;
01a682a0: ldr      x2, [x22]
01a682a4: add      x8, sp, #8
01a682a8: mov      x0, x19
01a682ac: mov      w1, w21
01a682b0: bl       #0x1461d24 ;
01a682b4: ldr      x0, [sp, #0x10]
01a682b8: ldp      x20, x19, [sp, #0x40]
01a682bc: ldr      x30, [sp, #0x20]
01a682c0: ldp      x22, x21, [sp, #0x30]
01a682c4: add      sp, sp, #0x50
01a682c8: ret
01a682cc: bl       #0xe54eac ;
