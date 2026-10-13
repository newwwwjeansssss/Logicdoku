// Data.Pairzzle.PairzzleHintReasons..cctor token=0x6000ff4 VA=0x1a683b4
01a683b4: stp      x30, x21, [sp, #-0x20]!
01a683b8: stp      x20, x19, [sp, #0x10]
01a683bc: adrp     x20, #0x2387000
01a683c0: adrp     x21, #0x2212000
01a683c4: adrp     x19, #0x2212000
01a683c8: ldrb     w8, [x20, #0xcd6]
01a683cc: ldr      x21, [x21, #0x100]
01a683d0: ldr      x19, [x19, #0x60]
01a683d4: tbnz     w8, #0, #0x1a683f8
01a683d8: adrp     x0, #0x2212000
01a683dc: ldr      x0, [x0, #0x100]
01a683e0: bl       #0xe54c48 ; 
01a683e4: adrp     x0, #0x2212000
01a683e8: ldr      x0, [x0, #0x60]
01a683ec: bl       #0xe54c48 ; 
01a683f0: mov      w8, #1
01a683f4: strb     w8, [x20, #0xcd6]
01a683f8: ldr      x0, [x21]
01a683fc: mov      w1, wzr
01a68400: bl       #0xe54cf0 ; 
01a68404: ldr      x8, [x19]
01a68408: mov      x1, x0
01a6840c: ldr      x8, [x8, #0xb8]
01a68410: str      x0, [x8]
01a68414: ldr      x8, [x19]
01a68418: ldp      x20, x19, [sp, #0x10]
01a6841c: ldr      x0, [x8, #0xb8]
01a68420: ldp      x30, x21, [sp], #0x20
01a68424: b        #0xe54bf4 ; 