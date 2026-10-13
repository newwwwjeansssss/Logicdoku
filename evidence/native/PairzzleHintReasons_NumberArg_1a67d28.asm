// Data.Pairzzle.PairzzleHintReasons.NumberArg token=0x6000ff3 VA=0x1a67d28
01a67d28: sub      sp, sp, #0x40
01a67d2c: stp      xzr, x30, [sp, #0x18]
01a67d30: stp      x20, x19, [sp, #0x30]
01a67d34: mov      x9, x0
01a67d38: str      w1, [sp, #0x2c]
01a67d3c: mov      x19, x8
01a67d40: stp      x0, xzr, [sp, #8]
01a67d44: add      x0, sp, #8
01a67d48: mov      x1, x9
01a67d4c: add      x20, sp, #8
01a67d50: bl       #0xe54bf4 ; 
01a67d54: add      x0, sp, #0x2c
01a67d58: mov      x1, xzr
01a67d5c: bl       #0x188a8f4 ; Int32.ToString
01a67d60: mov      x1, x0
01a67d64: str      x0, [sp, #0x18]
01a67d68: add      x0, x20, #0x10
01a67d6c: bl       #0xe54bf4 ; 
01a67d70: ldp      x8, x30, [sp, #0x18]
01a67d74: ldur     q0, [sp, #8]
01a67d78: str      q0, [x19]
01a67d7c: str      x8, [x19, #0x10]
01a67d80: ldp      x20, x19, [sp, #0x30]
01a67d84: add      sp, sp, #0x40
01a67d88: ret      