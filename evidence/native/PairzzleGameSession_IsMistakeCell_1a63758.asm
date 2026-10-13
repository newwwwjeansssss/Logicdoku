// Data.Pairzzle.PairzzleGameSession.IsMistakeCell token=0x6000fca VA=0x1a63758
01a63758: str      x30, [sp, #-0x10]!
01a6375c: ldr      x8, [x0, #0x28]
01a63760: cbz      x8, #0x1a637b0
01a63764: ldr      x9, [x0, #0x20]
01a63768: cbz      x9, #0x1a637bc
01a6376c: ldr      x9, [x9, #0x18]
01a63770: cbz      x9, #0x1a637bc
01a63774: ldr      w10, [x9, #0x18]
01a63778: cmp      w10, w1
01a6377c: b.ls     #0x1a637c0
01a63780: sxtw     x10, w1
01a63784: add      x9, x9, x10
01a63788: ldrb     w9, [x9, #0x20]
01a6378c: cbz      w9, #0x1a637b0
01a63790: ldr      w11, [x8, #0x18]
01a63794: cmp      w11, w1
01a63798: b.ls     #0x1a637c0
01a6379c: add      x8, x8, x10
01a637a0: ldrb     w8, [x8, #0x20]
01a637a4: cmp      w9, w8
01a637a8: cset     w0, ne
01a637ac: b        #0x1a637b4 ; 
01a637b0: mov      w0, wzr
01a637b4: ldr      x30, [sp], #0x10
01a637b8: ret      
01a637bc: bl       #0xe54eac ; 
01a637c0: bl       #0xe54eb4 ; 