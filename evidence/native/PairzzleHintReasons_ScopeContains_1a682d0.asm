// Data.Pairzzle.PairzzleHintReasons.ScopeContains token=0x6000fef VA=0x1a682d0
01a682d0: str      x30, [sp, #-0x10]!
01a682d4: cbz      x0, #0x1a6832c
01a682d8: ldr      w8, [x0, #0x18]
01a682dc: cmp      w8, #1
01a682e0: b.lt     #0x1a68314
01a682e4: bic      w10, w8, w8, asr #31
01a682e8: mov      w9, wzr
01a682ec: cmp      w8, w9
01a682f0: b.eq     #0x1a68328
01a682f4: add      x11, x0, w9, sxtw #2
01a682f8: ldr      w11, [x11, #0x20]
01a682fc: cmp      w11, w1
01a68300: b.eq     #0x1a68318
01a68304: add      w9, w9, #1
01a68308: cmp      w10, w9
01a6830c: b.ne     #0x1a682ec
01a68310: b        #0x1a68318 ; 
01a68314: mov      w9, wzr
01a68318: cmp      w9, w8
01a6831c: cset     w0, lt
01a68320: ldr      x30, [sp], #0x10
01a68324: ret      
01a68328: bl       #0xe54eb4 ; 
01a6832c: bl       #0xe54eac ; 