// Data.Pairzzle.PairzzleSolver.CausesOwnViolation token=0x600105e VA=0x1a6dabc
01a6dabc: stp      x30, x27, [sp, #-0x50]!
01a6dac0: stp      x26, x25, [sp, #0x10]
01a6dac4: stp      x24, x23, [sp, #0x20]
01a6dac8: stp      x22, x21, [sp, #0x30]
01a6dacc: stp      x20, x19, [sp, #0x40]
01a6dad0: adrp     x22, #0x2387000
01a6dad4: mov      w19, w2
01a6dad8: mov      x20, x1
01a6dadc: ldrb     w8, [x22, #0xd24]
01a6dae0: mov      x21, x0
01a6dae4: tbnz     w8, #0, #0x1a6db20
01a6dae8: adrp     x0, #0x21f0000
01a6daec: ldr      x0, [x0, #0xfd8]
01a6daf0: bl       #0xe54c48 ;
01a6daf4: adrp     x0, #0x2212000
01a6daf8: ldr      x0, [x0, #0x18]
01a6dafc: bl       #0xe54c48 ;
01a6db00: adrp     x0, #0x2212000
01a6db04: ldr      x0, [x0, #0x20]
01a6db08: bl       #0xe54c48 ;
01a6db0c: adrp     x0, #0x2212000
01a6db10: ldr      x0, [x0, #0x28]
01a6db14: bl       #0xe54c48 ;
01a6db18: mov      w8, #1
01a6db1c: strb     w8, [x22, #0xd24]
01a6db20: cbz      x21, #0x1a6dc18
01a6db24: ldr      x21, [x21, #0x10]
01a6db28: cbz      x21, #0x1a6dc18
01a6db2c: ldr      w8, [x21, #0x18]
01a6db30: cmp      w8, #0
01a6db34: cset     w24, gt
01a6db38: cmp      w8, #1
01a6db3c: b.lt     #0x1a6dbfc
01a6db40: adrp     x25, #0x2212000
01a6db44: adrp     x26, #0x2212000
01a6db48: adrp     x27, #0x21f0000
01a6db4c: ldr      x25, [x25, #0x28]
01a6db50: ldr      x26, [x26, #0x18]
01a6db54: ldr      x27, [x27, #0xfd8]
01a6db58: mov      w22, wzr
01a6db5c: ldr      x2, [x25]
01a6db60: mov      x0, x21
01a6db64: mov      w1, w22
01a6db68: bl       #0x145391c ;
01a6db6c: cbz      x0, #0x1a6dc18
01a6db70: ldr      x8, [x0]
01a6db74: ldr      x1, [x26]
01a6db78: mov      x23, x0
01a6db7c: ldrh     w9, [x8, #0x12e]
01a6db80: cbz      x9, #0x1a6dba4
01a6db84: ldr      x10, [x8, #0xb0]
01a6db88: add      x10, x10, #8
01a6db8c: ldur     x11, [x10, #-8]
01a6db90: cmp      x11, x1
01a6db94: b.eq     #0x1a6dbb4
01a6db98: subs     x9, x9, #1
01a6db9c: add      x10, x10, #0x10
01a6dba0: b.ne     #0x1a6db8c
01a6dba4: mov      x0, x23
01a6dba8: mov      w2, #1
01a6dbac: bl       #0xe8c450 ;
01a6dbb0: b        #0x1a6dbc4 ;
01a6dbb4: ldr      w9, [x10]
01a6dbb8: add      w9, w9, #1
01a6dbbc: add      x8, x8, w9, sxtw #4
01a6dbc0: add      x0, x8, #0x138
01a6dbc4: ldp      x8, x2, [x0]
01a6dbc8: mov      x0, x23
01a6dbcc: mov      x1, x20
01a6dbd0: blr      x8
01a6dbd4: cbz      x0, #0x1a6dc18
01a6dbd8: ldr      x2, [x27]
01a6dbdc: mov      w1, w19
01a6dbe0: bl       #0x136a094 ;
01a6dbe4: tbnz     w0, #0, #0x1a6dbfc
01a6dbe8: ldr      w8, [x21, #0x18]
01a6dbec: add      w22, w22, #1
01a6dbf0: cmp      w22, w8
01a6dbf4: cset     w24, lt
01a6dbf8: b.lt     #0x1a6db5c
01a6dbfc: and      w0, w24, #1
01a6dc00: ldp      x20, x19, [sp, #0x40]
01a6dc04: ldp      x22, x21, [sp, #0x30]
01a6dc08: ldp      x24, x23, [sp, #0x20]
01a6dc0c: ldp      x26, x25, [sp, #0x10]
01a6dc10: ldp      x30, x27, [sp], #0x50
01a6dc14: ret
01a6dc18: bl       #0xe54eac ;
