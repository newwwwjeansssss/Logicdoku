// Data.Pairzzle.PairzzleHintReasons.Build token=0x6000fe4 VA=0x1a65fe4
01a65fe4: sub      sp, sp, #0x80
01a65fe8: stp      x30, x27, [sp, #0x30]
01a65fec: stp      x26, x25, [sp, #0x40]
01a65ff0: stp      x24, x23, [sp, #0x50]
01a65ff4: stp      x22, x21, [sp, #0x60]
01a65ff8: stp      x20, x19, [sp, #0x70]
01a65ffc: adrp     x26, #0x2387000
01a66000: adrp     x27, #0x2212000
01a66004: mov      w24, w5
01a66008: ldrb     w9, [x26, #0xcc8]
01a6600c: ldr      x27, [x27, #0x110]
01a66010: mov      w20, w4
01a66014: mov      w21, w3
01a66018: mov      x25, x2
01a6601c: mov      x23, x1
01a66020: mov      x22, x0
01a66024: mov      x19, x8
01a66028: tbnz     w9, #0, #0x1a66088
01a6602c: adrp     x0, #0x2212000
01a66030: ldr      x0, [x0, #0x60]
01a66034: bl       #0xe54c48 ;
01a66038: adrp     x0, #0x2212000
01a6603c: ldr      x0, [x0, #0x110]
01a66040: bl       #0xe54c48 ;
01a66044: adrp     x0, #0x2212000
01a66048: ldr      x0, [x0, #0x118]
01a6604c: bl       #0xe54c48 ;
01a66050: adrp     x0, #0x2212000
01a66054: ldr      x0, [x0, #0x120]
01a66058: bl       #0xe54c48 ;
01a6605c: adrp     x0, #0x2212000
01a66060: ldr      x0, [x0, #0x128]
01a66064: bl       #0xe54c48 ;
01a66068: adrp     x0, #0x220f000
01a6606c: ldr      x0, [x0, #0x2a8]
01a66070: bl       #0xe54c48 ;
01a66074: adrp     x0, #0x2212000
01a66078: ldr      x0, [x0, #0x130]
01a6607c: bl       #0xe54c48 ;
01a66080: mov      w8, #1
01a66084: strb     w8, [x26, #0xcc8]
01a66088: adrp     x26, #0x2212000
01a6608c: mov      x0, x25
01a66090: mov      x2, xzr
01a66094: ldr      x26, [x26, #0x60]
01a66098: ldr      x1, [x27]
01a6609c: bl       #0x1769bac ; String.op_Equality
01a660a0: tbz      w0, #0, #0x1a660d4
01a660a4: ldr      x0, [x26]
01a660a8: ldr      w8, [x0, #0xe4]
01a660ac: cbnz     w8, #0x1a660b4
01a660b0: bl       #0xe54d80 ;
01a660b4: add      x8, sp, #8
01a660b8: mov      x0, x22
01a660bc: mov      x1, x23
01a660c0: mov      w2, w21
01a660c4: mov      w3, w20
01a660c8: mov      w4, w24
01a660cc: bl       #0x1a665a0 ; PairzzleHintReasons.Balance
01a660d0: b        #0x1a66238 ;
01a660d4: adrp     x8, #0x2212000
01a660d8: mov      x0, x25
01a660dc: mov      x2, xzr
01a660e0: ldr      x8, [x8, #0x130]
01a660e4: ldr      x1, [x8]
01a660e8: bl       #0x1769bac ; String.op_Equality
01a660ec: tbz      w0, #0, #0x1a66120
01a660f0: ldr      x0, [x26]
01a660f4: ldr      w8, [x0, #0xe4]
01a660f8: cbnz     w8, #0x1a66100
01a660fc: bl       #0xe54d80 ;
01a66100: add      x8, sp, #8
01a66104: mov      x0, x22
01a66108: mov      x1, x23
01a6610c: mov      w2, w21
01a66110: mov      w3, w20
01a66114: mov      w4, w24
01a66118: bl       #0x1a66924 ; PairzzleHintReasons.NoThree
01a6611c: b        #0x1a66238 ;
01a66120: adrp     x8, #0x2212000
01a66124: mov      x0, x25
01a66128: mov      x2, xzr
01a6612c: ldr      x8, [x8, #0x120]
01a66130: ldr      x1, [x8]
01a66134: bl       #0x1769bac ; String.op_Equality
01a66138: tbz      w0, #0, #0x1a66168
01a6613c: ldr      x0, [x26]
01a66140: ldr      w8, [x0, #0xe4]
01a66144: cbnz     w8, #0x1a6614c
01a66148: bl       #0xe54d80 ;
01a6614c: add      x8, sp, #8
01a66150: mov      x0, x22
01a66154: mov      x1, x23
01a66158: mov      w2, w21
01a6615c: mov      w3, w20
01a66160: bl       #0x1a66c04 ; PairzzleHintReasons.Edge
01a66164: b        #0x1a66238 ;
01a66168: adrp     x8, #0x2212000
01a6616c: mov      x0, x25
01a66170: mov      x2, xzr
01a66174: ldr      x8, [x8, #0x128]
01a66178: ldr      x1, [x8]
01a6617c: bl       #0x1769bac ; String.op_Equality
01a66180: tbz      w0, #0, #0x1a661b4
01a66184: ldr      x0, [x26]
01a66188: ldr      w8, [x0, #0xe4]
01a6618c: cbnz     w8, #0x1a66194
01a66190: bl       #0xe54d80 ;
01a66194: add      x8, sp, #8
01a66198: mov      x0, x22
01a6619c: mov      x1, x23
01a661a0: mov      w2, w21
01a661a4: mov      w3, w20
01a661a8: mov      w4, w24
01a661ac: bl       #0x1a66ffc ; PairzzleHintReasons.Region
01a661b0: b        #0x1a66238 ;
01a661b4: adrp     x8, #0x220f000
01a661b8: mov      x0, x25
01a661bc: mov      x2, xzr
01a661c0: ldr      x8, [x8, #0x2a8]
01a661c4: ldr      x1, [x8]
01a661c8: bl       #0x1769bac ; String.op_Equality
01a661cc: tbz      w0, #0, #0x1a661f8
01a661d0: ldr      x0, [x26]
01a661d4: ldr      w8, [x0, #0xe4]
01a661d8: cbnz     w8, #0x1a661e0
01a661dc: bl       #0xe54d80 ;
01a661e0: add      x8, sp, #8
01a661e4: mov      x0, x22
01a661e8: mov      w1, w21
01a661ec: mov      w2, w20
01a661f0: bl       #0x1a67378 ; PairzzleHintReasons.EdgeCount
01a661f4: b        #0x1a66238 ;
01a661f8: adrp     x8, #0x2212000
01a661fc: mov      x0, x25
01a66200: mov      x2, xzr
01a66204: ldr      x8, [x8, #0x118]
01a66208: ldr      x1, [x8]
01a6620c: bl       #0x1769bac ; String.op_Equality
01a66210: tbz      w0, #0, #0x1a66268
01a66214: ldr      x0, [x26]
01a66218: ldr      w8, [x0, #0xe4]
01a6621c: cbnz     w8, #0x1a66224
01a66220: bl       #0xe54d80 ;
01a66224: add      x8, sp, #8
01a66228: mov      x0, x22
01a6622c: mov      w1, w21
01a66230: mov      w2, w20
01a66234: bl       #0x1a67870 ; PairzzleHintReasons.Corner
01a66238: ldur     q0, [sp, #8]
01a6623c: ldur     q1, [sp, #0x18]
01a66240: ldr      x8, [sp, #0x28]
01a66244: stp      q0, q1, [x19]
01a66248: str      x8, [x19, #0x20]
01a6624c: ldp      x20, x19, [sp, #0x70]
01a66250: ldp      x22, x21, [sp, #0x60]
01a66254: ldp      x24, x23, [sp, #0x50]
01a66258: ldp      x26, x25, [sp, #0x40]
01a6625c: ldp      x30, x27, [sp, #0x30]
01a66260: add      sp, sp, #0x80
01a66264: ret
01a66268: movi     v0.2d, #0000000000000000
01a6626c: str      xzr, [x19, #0x20]
01a66270: stp      q0, q0, [x19]
01a66274: b        #0x1a6624c ;
