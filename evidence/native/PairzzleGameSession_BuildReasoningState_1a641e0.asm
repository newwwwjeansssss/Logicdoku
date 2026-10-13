// Data.Pairzzle.PairzzleGameSession.BuildReasoningState token=0x6000fcd VA=0x1a641e0
01a641e0: stp      x30, x21, [sp, #-0x20]!
01a641e4: stp      x20, x19, [sp, #0x10]
01a641e8: mov      x19, x0
01a641ec: ldr      x0, [x0, #0x20]
01a641f0: cbz      x0, #0x1a64244
01a641f4: bl       #0x1a6128c ; PairzzleBoardState.Clone
01a641f8: cbz      x0, #0x1a64244
01a641fc: ldr      x8, [x0, #0x18]
01a64200: mov      x20, x0
01a64204: cbz      x8, #0x1a64244
01a64208: mov      w21, wzr
01a6420c: ldr      w8, [x8, #0x18]
01a64210: cmp      w21, w8
01a64214: b.ge     #0x1a64248
01a64218: mov      x0, x19
01a6421c: mov      w1, w21
01a64220: bl       #0x1a63758 ; PairzzleGameSession.IsMistakeCell
01a64224: tbz      w0, #0, #0x1a64238
01a64228: mov      x0, x20
01a6422c: mov      w1, w21
01a64230: mov      w2, wzr
01a64234: bl       #0x1a60b68 ; PairzzleBoardState.Lock
01a64238: ldr      x8, [x20, #0x18]
01a6423c: add      w21, w21, #1
01a64240: cbnz     x8, #0x1a6420c
01a64244: bl       #0xe54eac ; 
01a64248: mov      x0, x20
01a6424c: ldp      x20, x19, [sp, #0x10]
01a64250: ldp      x30, x21, [sp], #0x20
01a64254: ret      