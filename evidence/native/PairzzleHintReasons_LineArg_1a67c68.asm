// Data.Pairzzle.PairzzleHintReasons.LineArg token=0x6000ff2 VA=0x1a67c68
01a67c68: sub      sp, sp, #0x60
01a67c6c: str      x30, [sp, #0x20]
01a67c70: stp      x24, x23, [sp, #0x30]
01a67c74: stp      x22, x21, [sp, #0x40]
01a67c78: stp      x20, x19, [sp, #0x50]
01a67c7c: adrp     x24, #0x2387000
01a67c80: adrp     x23, #0x21f8000
01a67c84: adrp     x21, #0x2212000
01a67c88: adrp     x22, #0x2212000
01a67c8c: ldr      x23, [x23, #0x8b0]
01a67c90: ldrb     w9, [x24, #0xcd5]
01a67c94: ldr      x21, [x21, #0x1b8]
01a67c98: ldr      x22, [x22, #0x1c0]
01a67c9c: mov      w20, w0
01a67ca0: mov      x19, x8
01a67ca4: tbnz     w9, #0, #0x1a67cd4
01a67ca8: adrp     x0, #0x2212000
01a67cac: ldr      x0, [x0, #0x1b8]
01a67cb0: bl       #0xe54c48 ; 
01a67cb4: adrp     x0, #0x21f8000
01a67cb8: ldr      x0, [x0, #0x8b0]
01a67cbc: bl       #0xe54c48 ; 
01a67cc0: adrp     x0, #0x2212000
01a67cc4: ldr      x0, [x0, #0x1c0]
01a67cc8: bl       #0xe54c48 ; 
01a67ccc: mov      w8, #1
01a67cd0: strb     w8, [x24, #0xcd5]
01a67cd4: ldr      x1, [x23]
01a67cd8: add      x0, sp, #8
01a67cdc: stp      xzr, xzr, [sp, #0x10]
01a67ce0: add      x23, sp, #8
01a67ce4: str      x1, [sp, #8]
01a67ce8: bl       #0xe54bf4 ; 
01a67cec: cmp      w20, #0
01a67cf0: add      x0, x23, #8
01a67cf4: csel     x8, x21, x22, eq
01a67cf8: ldr      x1, [x8]
01a67cfc: str      x1, [sp, #0x10]
01a67d00: bl       #0xe54bf4 ; 
01a67d04: ldp      x8, x30, [sp, #0x18]
01a67d08: ldur     q0, [sp, #8]
01a67d0c: ldp      x22, x21, [sp, #0x40]
01a67d10: str      q0, [x19]
01a67d14: ldp      x24, x23, [sp, #0x30]
01a67d18: str      x8, [x19, #0x10]
01a67d1c: ldp      x20, x19, [sp, #0x50]
01a67d20: add      sp, sp, #0x60
01a67d24: ret      