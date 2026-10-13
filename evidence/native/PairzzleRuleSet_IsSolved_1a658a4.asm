// Data.Pairzzle.PairzzleRuleSet.IsSolved token=0x6001057 VA=0x1a658a4
01a658a4: str      x30, [sp, #-0x20]!
01a658a8: stp      x20, x19, [sp, #0x10]
01a658ac: cbz      x1, #0x1a658ec
01a658b0: mov      x20, x0
01a658b4: mov      x0, x1
01a658b8: mov      x19, x1
01a658bc: bl       #0x1a610a4 ; PairzzleBoardState.IsFull
01a658c0: tbz      w0, #0, #0x1a658d8
01a658c4: mov      x0, x20
01a658c8: mov      x1, x19
01a658cc: bl       #0x1a6d2a4 ; PairzzleRuleSet.HasViolation
01a658d0: eor      w8, w0, #1
01a658d4: b        #0x1a658dc ; 
01a658d8: mov      w8, wzr
01a658dc: ldp      x20, x19, [sp, #0x10]
01a658e0: and      w0, w8, #1
01a658e4: ldr      x30, [sp], #0x20
01a658e8: ret      
01a658ec: bl       #0xe54eac ; 