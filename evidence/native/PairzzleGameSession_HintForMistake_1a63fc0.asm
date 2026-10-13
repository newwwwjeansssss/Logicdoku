// Data.Pairzzle.PairzzleGameSession.HintForMistake token=0x6000fc7 VA=0x1a63fc0
01a63fc0: sub      sp, sp, #0x80
01a63fc4: stp      x30, x25, [sp, #0x40]
01a63fc8: stp      x24, x23, [sp, #0x50]
01a63fcc: stp      x22, x21, [sp, #0x60]
01a63fd0: stp      x20, x19, [sp, #0x70]
01a63fd4: adrp     x20, #0x2387000
01a63fd8: mov      x19, x0
01a63fdc: ldrb     w8, [x20, #0xcb4]
01a63fe0: tbnz     w8, #0, #0x1a64028
01a63fe4: adrp     x0, #0x2212000
01a63fe8: ldr      x0, [x0, #0x10]
01a63fec: bl       #0xe54c48 ; 
01a63ff0: adrp     x0, #0x2212000
01a63ff4: ldr      x0, [x0, #0x48]
01a63ff8: bl       #0xe54c48 ; 
01a63ffc: adrp     x0, #0x2212000
01a64000: ldr      x0, [x0, #0x50]
01a64004: bl       #0xe54c48 ; 
01a64008: adrp     x0, #0x2212000
01a6400c: ldr      x0, [x0, #0x58]
01a64010: bl       #0xe54c48 ; 
01a64014: adrp     x0, #0x2212000
01a64018: ldr      x0, [x0, #0x60]
01a6401c: bl       #0xe54c48 ; 
01a64020: mov      w8, #1
01a64024: strb     w8, [x20, #0xcb4]
01a64028: movi     v0.2d, #0000000000000000
01a6402c: mov      x0, x19
01a64030: str      wzr, [sp, #0x38]
01a64034: str      xzr, [sp, #0x30]
01a64038: stp      q0, q0, [sp, #0x10]
01a6403c: bl       #0x1a64e38 ; PairzzleGameSession.FindMistake
01a64040: tst      x0, #0xff
01a64044: str      x0, [sp, #0x30]
01a64048: str      w1, [sp, #0x38]
01a6404c: b.eq     #0x1a641b8
01a64050: adrp     x8, #0x2212000
01a64054: add      x0, sp, #0x30
01a64058: ldr      x8, [x8, #0x50]
01a6405c: ldr      x1, [x8]
01a64060: bl       #0x14feff0 ; 
01a64064: ldr      x8, [x19, #0x28]
01a64068: cbz      x8, #0x1a641d8
01a6406c: ldr      w9, [x8, #0x18]
01a64070: mov      x20, x0
01a64074: cmp      w20, w9
01a64078: b.hs     #0x1a641dc
01a6407c: sxtw     x25, w20
01a64080: adrp     x23, #0x2212000
01a64084: mov      x0, x19
01a64088: ldr      x23, [x23, #0x60]
01a6408c: mov      w1, w20
01a64090: add      x8, x8, x25
01a64094: ldrb     w21, [x8, #0x20]
01a64098: mov      w2, w21
01a6409c: bl       #0x1a6318c ; PairzzleGameSession.DetermineReasoningRuleKey
01a640a0: mov      x1, x0
01a640a4: mov      x0, x19
01a640a8: str      x1, [x0, #0x80]!
01a640ac: bl       #0xe54bf4 ; 
01a640b0: ldr      x22, [x19, #0x10]
01a640b4: mov      x0, x19
01a640b8: bl       #0x1a641e0 ; PairzzleGameSession.BuildReasoningState
01a640bc: ldr      x8, [x23]
01a640c0: ldr      x23, [x19, #0x18]
01a640c4: mov      x24, x0
01a640c8: ldr      w9, [x8, #0xe4]
01a640cc: cbnz     w9, #0x1a640d8
01a640d0: mov      x0, x8
01a640d4: bl       #0xe54d80 ; 
01a640d8: add      x8, sp, #0x10
01a640dc: mov      x0, x22
01a640e0: mov      x1, x24
01a640e4: mov      x2, x23
01a640e8: mov      w3, w20
01a640ec: mov      w4, w21
01a640f0: bl       #0x1a643d4 ; PairzzleHintReasons.Of
01a640f4: ldr      x0, [x19, #0x20]
01a640f8: cbz      x0, #0x1a641d8
01a640fc: ldr      x8, [x0, #0x18]
01a64100: cbz      x8, #0x1a641d8
01a64104: ldr      w9, [x8, #0x18]
01a64108: cmp      w20, w9
01a6410c: b.hs     #0x1a641dc
01a64110: adrp     x22, #0x2212000
01a64114: add      x8, x8, x25
01a64118: adrp     x23, #0x2212000
01a6411c: ldr      x22, [x22, #0x10]
01a64120: ldr      x23, [x23, #0x58]
01a64124: ldrb     w24, [x8, #0x20]
01a64128: mov      w1, w20
01a6412c: mov      w2, w21
01a64130: bl       #0x1a60b68 ; PairzzleBoardState.Lock
01a64134: and      x8, x20, #0xffffffff
01a64138: ldr      x2, [x22]
01a6413c: mov      x0, sp
01a64140: orr      x1, x8, x24, lsl #32
01a64144: str      wzr, [sp, #8]
01a64148: str      xzr, [sp]
01a6414c: bl       #0x14ff910 ; 
01a64150: ldr      x8, [sp]
01a64154: ldr      w10, [x19, #0x40]
01a64158: mov      x0, x19
01a6415c: ldr      w9, [sp, #8]
01a64160: str      x8, [x19, #0xa0]
01a64164: stur     x8, [x19, #0xac]
01a64168: add      w8, w10, #1
01a6416c: str      w9, [x19, #0xa8]
01a64170: str      w9, [x19, #0xb4]
01a64174: str      w8, [x19, #0x40]
01a64178: bl       #0x1a635a0 ; PairzzleGameSession.CheckSolved
01a6417c: ldr      x0, [x23]
01a64180: bl       #0xe54e9c ; 
01a64184: mov      x1, xzr
01a64188: mov      x19, x0
01a6418c: bl       #0x18ca704 ; Object..ctor
01a64190: cbz      x19, #0x1a641d8
01a64194: ldp      q0, q1, [sp, #0x10]
01a64198: add      x0, x19, #0x18
01a6419c: mov      x1, xzr
01a641a0: str      w20, [x19, #0x10]
01a641a4: strb     w21, [x19, #0x14]
01a641a8: stur     q0, [x19, #0x18]
01a641ac: stur     q1, [x19, #0x28]
01a641b0: bl       #0xe54bf4 ; 
01a641b4: b        #0x1a641bc ; 
01a641b8: mov      x19, xzr
01a641bc: mov      x0, x19
01a641c0: ldp      x20, x19, [sp, #0x70]
01a641c4: ldp      x22, x21, [sp, #0x60]
01a641c8: ldp      x24, x23, [sp, #0x50]
01a641cc: ldp      x30, x25, [sp, #0x40]
01a641d0: add      sp, sp, #0x80
01a641d4: ret      
01a641d8: bl       #0xe54eac ; 
01a641dc: bl       #0xe54eb4 ; 