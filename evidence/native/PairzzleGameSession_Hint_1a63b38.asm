// Data.Pairzzle.PairzzleGameSession.Hint token=0x6000fc4 VA=0x1a63b38
01a63b38: sub      sp, sp, #0x80
01a63b3c: stp      x30, x25, [sp, #0x40]
01a63b40: stp      x24, x23, [sp, #0x50]
01a63b44: stp      x22, x21, [sp, #0x60]
01a63b48: stp      x20, x19, [sp, #0x70]
01a63b4c: adrp     x20, #0x2387000
01a63b50: mov      x19, x0
01a63b54: ldrb     w8, [x20, #0xcb1]
01a63b58: tbnz     w8, #0, #0x1a63bc4
01a63b5c: adrp     x0, #0x220b000
01a63b60: ldr      x0, [x0, #0x218]
01a63b64: bl       #0xe54c48 ; 
01a63b68: adrp     x0, #0x220b000
01a63b6c: ldr      x0, [x0, #0x2f8]
01a63b70: bl       #0xe54c48 ; 
01a63b74: adrp     x0, #0x2212000
01a63b78: ldr      x0, [x0, #0x10]
01a63b7c: bl       #0xe54c48 ; 
01a63b80: adrp     x0, #0x2212000
01a63b84: ldr      x0, [x0, #0x48]
01a63b88: bl       #0xe54c48 ; 
01a63b8c: adrp     x0, #0x2212000
01a63b90: ldr      x0, [x0, #0x50]
01a63b94: bl       #0xe54c48 ; 
01a63b98: adrp     x0, #0x2212000
01a63b9c: ldr      x0, [x0, #0x58]
01a63ba0: bl       #0xe54c48 ; 
01a63ba4: adrp     x0, #0x220b000
01a63ba8: ldr      x0, [x0, #0x3d8]
01a63bac: bl       #0xe54c48 ; 
01a63bb0: adrp     x0, #0x2212000
01a63bb4: ldr      x0, [x0, #0x60]
01a63bb8: bl       #0xe54c48 ; 
01a63bbc: mov      w8, #1
01a63bc0: strb     w8, [x20, #0xcb1]
01a63bc4: movi     v0.2d, #0000000000000000
01a63bc8: ldrb     w8, [x19, #0x6e]
01a63bcc: mov      x22, xzr
01a63bd0: str      wzr, [sp, #0x38]
01a63bd4: str      xzr, [sp, #0x30]
01a63bd8: stp      q0, q0, [sp, #0x10]
01a63bdc: cbz      w8, #0x1a63bfc
01a63be0: mov      x0, x22
01a63be4: ldp      x20, x19, [sp, #0x70]
01a63be8: ldp      x22, x21, [sp, #0x60]
01a63bec: ldp      x24, x23, [sp, #0x50]
01a63bf0: ldp      x30, x25, [sp, #0x40]
01a63bf4: add      sp, sp, #0x80
01a63bf8: ret      
01a63bfc: ldr      x8, [x19, #0x28]
01a63c00: cbz      x8, #0x1a63cb0
01a63c04: mov      x0, x19
01a63c08: bl       #0x1a63e74 ; PairzzleGameSession.CollectEditableBlanks
01a63c0c: cbz      x0, #0x1a63e6c
01a63c10: ldr      w8, [x0, #0x18]
01a63c14: mov      x20, x0
01a63c18: cbz      w8, #0x1a63cb8
01a63c1c: mov      x0, x19
01a63c20: bl       #0x1a641e0 ; PairzzleGameSession.BuildReasoningState
01a63c24: ldr      x1, [x19, #0x18]
01a63c28: bl       #0x1a64258 ; PairzzleSolver.GetLocalHint
01a63c2c: tst      x0, #0xff
01a63c30: str      x0, [sp, #0x30]
01a63c34: str      w1, [sp, #0x38]
01a63c38: b.eq     #0x1a63c78
01a63c3c: ldr      x8, [x19, #0x20]
01a63c40: cbz      x8, #0x1a63e6c
01a63c44: adrp     x21, #0x2212000
01a63c48: add      x0, sp, #0x30
01a63c4c: ldr      x21, [x21, #0x50]
01a63c50: ldr      x22, [x8, #0x18]
01a63c54: ldr      x1, [x21]
01a63c58: bl       #0x14feff0 ; 
01a63c5c: cbz      x22, #0x1a63e6c
01a63c60: ldr      w8, [x22, #0x18]
01a63c64: cmp      w0, w8
01a63c68: b.hs     #0x1a63e70
01a63c6c: add      x8, x22, w0, sxtw
01a63c70: ldrb     w8, [x8, #0x20]
01a63c74: cbz      w8, #0x1a63cd4
01a63c78: ldr      x0, [x19, #0x38]
01a63c7c: cbz      x0, #0x1a63e6c
01a63c80: ldr      x8, [x0]
01a63c84: ldr      w1, [x20, #0x18]
01a63c88: ldp      x9, x2, [x8, #0x1a8]
01a63c8c: blr      x9
01a63c90: adrp     x8, #0x220b000
01a63c94: mov      w1, w0
01a63c98: mov      x0, x20
01a63c9c: ldr      x8, [x8, #0x2f8]
01a63ca0: ldr      x2, [x8]
01a63ca4: bl       #0x140455c ; 
01a63ca8: mov      w20, w0
01a63cac: b        #0x1a63ce4 ; 
01a63cb0: mov      x22, xzr
01a63cb4: b        #0x1a63be0 ; 
01a63cb8: mov      x0, x19
01a63cbc: ldp      x20, x19, [sp, #0x70]
01a63cc0: ldp      x22, x21, [sp, #0x60]
01a63cc4: ldp      x24, x23, [sp, #0x50]
01a63cc8: ldp      x30, x25, [sp, #0x40]
01a63ccc: add      sp, sp, #0x80
01a63cd0: b        #0x1a63fc0 ; PairzzleGameSession.HintForMistake
01a63cd4: ldr      x1, [x21]
01a63cd8: add      x0, sp, #0x30
01a63cdc: bl       #0x14feff0 ; 
01a63ce0: mov      x20, x0
01a63ce4: ldr      x8, [x19, #0x28]
01a63ce8: cbz      x8, #0x1a63e6c
01a63cec: ldr      w9, [x8, #0x18]
01a63cf0: cmp      w20, w9
01a63cf4: b.hs     #0x1a63e70
01a63cf8: add      x8, x8, w20, sxtw
01a63cfc: mov      x0, x19
01a63d00: mov      w1, w20
01a63d04: ldrb     w21, [x8, #0x20]
01a63d08: mov      w2, w21
01a63d0c: bl       #0x1a6318c ; PairzzleGameSession.DetermineReasoningRuleKey
01a63d10: mov      x22, x0
01a63d14: mov      x0, x19
01a63d18: mov      x1, x22
01a63d1c: str      x22, [x0, #0x80]!
01a63d20: bl       #0xe54bf4 ; 
01a63d24: ldr      x23, [x19, #0x10]
01a63d28: mov      x0, x19
01a63d2c: bl       #0x1a641e0 ; PairzzleGameSession.BuildReasoningState
01a63d30: adrp     x8, #0x2212000
01a63d34: mov      x25, x0
01a63d38: ldr      x8, [x8, #0x60]
01a63d3c: ldr      x24, [x19, #0x18]
01a63d40: ldr      x8, [x8]
01a63d44: ldr      w9, [x8, #0xe4]
01a63d48: cbnz     w9, #0x1a63d54
01a63d4c: mov      x0, x8
01a63d50: bl       #0xe54d80 ; 
01a63d54: add      x8, sp, #0x10
01a63d58: mov      x0, x23
01a63d5c: mov      x1, x25
01a63d60: mov      x2, x24
01a63d64: mov      w3, w20
01a63d68: mov      w4, w21
01a63d6c: bl       #0x1a643d4 ; PairzzleHintReasons.Of
01a63d70: ldr      x0, [x19, #0x20]
01a63d74: cbz      x0, #0x1a63e6c
01a63d78: mov      w1, w20
01a63d7c: mov      w2, w21
01a63d80: bl       #0x1a60b68 ; PairzzleBoardState.Lock
01a63d84: adrp     x8, #0x2212000
01a63d88: mov      w1, w20
01a63d8c: mov      x0, sp
01a63d90: ldr      x8, [x8, #0x10]
01a63d94: str      wzr, [sp, #8]
01a63d98: str      xzr, [sp]
01a63d9c: ldr      x2, [x8]
01a63da0: bl       #0x14ff910 ; 
01a63da4: ldr      x8, [sp]
01a63da8: ldr      w10, [x19, #0x40]
01a63dac: mov      x0, x19
01a63db0: ldr      w9, [sp, #8]
01a63db4: str      x8, [x19, #0xa0]
01a63db8: stur     x8, [x19, #0xac]
01a63dbc: add      w8, w10, #1
01a63dc0: str      w9, [x19, #0xa8]
01a63dc4: str      w9, [x19, #0xb4]
01a63dc8: str      w8, [x19, #0x40]
01a63dcc: bl       #0x1a637c4 ; PairzzleGameSession.AdvanceBehaviorRecorderTime
01a63dd0: ldr      x8, [x19, #0x10]
01a63dd4: cbz      x8, #0x1a63e6c
01a63dd8: adrp     x9, #0x220b000
01a63ddc: ldr      x9, [x9, #0x3d8]
01a63de0: ldr      x23, [x19, #0xb8]
01a63de4: ldr      w24, [x8, #0x10]
01a63de8: ldr      x0, [x9]
01a63dec: ldr      w9, [x0, #0xe4]
01a63df0: cbnz     w9, #0x1a63df8
01a63df4: bl       #0xe54d80 ; 
01a63df8: mov      w0, w21
01a63dfc: bl       #0x1a646cc ; PairzzleGameSession.SymbolChar
01a63e00: cbz      x23, #0x1a63e6c
01a63e04: sdiv     w1, w20, w24
01a63e08: mov      x3, x0
01a63e0c: mov      x0, x23
01a63e10: mov      w4, #1
01a63e14: mov      x5, x22
01a63e18: msub     w2, w1, w24, w20
01a63e1c: bl       #0x1a64738 ; PairzzleLevelBehaviorRecorder.RecordHint
01a63e20: mov      x0, x19
01a63e24: bl       #0x1a635a0 ; PairzzleGameSession.CheckSolved
01a63e28: adrp     x8, #0x2212000
01a63e2c: ldr      x8, [x8, #0x58]
01a63e30: ldr      x0, [x8]
01a63e34: bl       #0xe54e9c ; 
01a63e38: mov      x1, xzr
01a63e3c: mov      x22, x0
01a63e40: bl       #0x18ca704 ; Object..ctor
01a63e44: cbz      x22, #0x1a63e6c
01a63e48: ldp      q0, q1, [sp, #0x10]
01a63e4c: add      x0, x22, #0x18
01a63e50: mov      x1, xzr
01a63e54: str      w20, [x22, #0x10]
01a63e58: strb     w21, [x22, #0x14]
01a63e5c: stur     q0, [x22, #0x18]
01a63e60: stur     q1, [x22, #0x28]
01a63e64: bl       #0xe54bf4 ; 
01a63e68: b        #0x1a63be0 ; 
01a63e6c: bl       #0xe54eac ; 
01a63e70: bl       #0xe54eb4 ; 