// Data.Pairzzle.PairzzleHintReasons.SymbolArg token=0x6000ff1 VA=0x1a67bc0
01a67bc0: sub      sp, sp, #0x50
01a67bc4: stp      x30, x23, [sp, #0x20]
01a67bc8: stp      x22, x21, [sp, #0x30]
01a67bcc: stp      x20, x19, [sp, #0x40]
01a67bd0: adrp     x23, #0x2387000
01a67bd4: adrp     x22, #0x2212000
01a67bd8: mov      w20, w1
01a67bdc: ldrb     w9, [x23, #0xcd4]
01a67be0: ldr      x22, [x22, #0x168]
01a67be4: mov      x21, x0
01a67be8: mov      x19, x8
01a67bec: tbnz     w9, #0, #0x1a67c04
01a67bf0: adrp     x0, #0x2212000
01a67bf4: ldr      x0, [x0, #0x168]
01a67bf8: bl       #0xe54c48 ; 
01a67bfc: mov      w8, #1
01a67c00: strb     w8, [x23, #0xcd4]
01a67c04: add      x0, sp, #8
01a67c08: mov      x1, x21
01a67c0c: stp      xzr, xzr, [sp, #0x10]
01a67c10: str      x21, [sp, #8]
01a67c14: add      x21, sp, #8
01a67c18: bl       #0xe54bf4 ; 
01a67c1c: ldr      x0, [x22]
01a67c20: ldr      w8, [x0, #0xe4]
01a67c24: cbnz     w8, #0x1a67c2c
01a67c28: bl       #0xe54d80 ; 
01a67c2c: mov      w0, w20
01a67c30: bl       #0x1a68344 ; PairzzleIconTag.Of
01a67c34: mov      x1, x0
01a67c38: str      x0, [sp, #0x18]
01a67c3c: add      x0, x21, #0x10
01a67c40: bl       #0xe54bf4 ; 
01a67c44: ldur     q0, [sp, #8]
01a67c48: ldr      x8, [sp, #0x18]
01a67c4c: ldp      x22, x21, [sp, #0x30]
01a67c50: str      q0, [x19]
01a67c54: ldp      x30, x23, [sp, #0x20]
01a67c58: str      x8, [x19, #0x10]
01a67c5c: ldp      x20, x19, [sp, #0x40]
01a67c60: add      sp, sp, #0x50
01a67c64: ret      