// Data.Pairzzle.PairzzleRuleSet.ViolationsByRule token=0x6001055 VA=0x1a65998
01a65998: sub      sp, sp, #0x70
01a6599c: str      x30, [sp, #0x10]
01a659a0: stp      x28, x27, [sp, #0x20]
01a659a4: stp      x26, x25, [sp, #0x30]
01a659a8: stp      x24, x23, [sp, #0x40]
01a659ac: stp      x22, x21, [sp, #0x50]
01a659b0: stp      x20, x19, [sp, #0x60]
01a659b4: adrp     x23, #0x2387000
01a659b8: adrp     x22, #0x2212000
01a659bc: adrp     x21, #0x2212000
01a659c0: ldrb     w8, [x23, #0xd1c]
01a659c4: ldr      x22, [x22, #0xc8]
01a659c8: ldr      x21, [x21, #0xd0]
01a659cc: mov      x19, x1
01a659d0: mov      x20, x0
01a659d4: tbnz     w8, #0, #0x1a65a34
01a659d8: adrp     x0, #0x2212000
01a659dc: ldr      x0, [x0, #0xd8]
01a659e0: bl       #0xe54c48 ; 
01a659e4: adrp     x0, #0x2212000
01a659e8: ldr      x0, [x0, #0x18]
01a659ec: bl       #0xe54c48 ; 
01a659f0: adrp     x0, #0x2212000
01a659f4: ldr      x0, [x0, #0xe0]
01a659f8: bl       #0xe54c48 ; 
01a659fc: adrp     x0, #0x2212000
01a65a00: ldr      x0, [x0, #0xd0]
01a65a04: bl       #0xe54c48 ; 
01a65a08: adrp     x0, #0x2212000
01a65a0c: ldr      x0, [x0, #0x20]
01a65a10: bl       #0xe54c48 ; 
01a65a14: adrp     x0, #0x2212000
01a65a18: ldr      x0, [x0, #0x28]
01a65a1c: bl       #0xe54c48 ; 
01a65a20: adrp     x0, #0x2212000
01a65a24: ldr      x0, [x0, #0xc8]
01a65a28: bl       #0xe54c48 ; 
01a65a2c: mov      w8, #1
01a65a30: strb     w8, [x23, #0xd1c]
01a65a34: ldr      x0, [x22]
01a65a38: stp      xzr, xzr, [sp]
01a65a3c: bl       #0xe54e9c ; 
01a65a40: ldr      x1, [x21]
01a65a44: mov      x21, x0
01a65a48: bl       #0x1463fe4 ; 
01a65a4c: ldr      x0, [x20, #0x10]
01a65a50: cbz      x0, #0x1a65c0c
01a65a54: adrp     x25, #0x2212000
01a65a58: adrp     x26, #0x2212000
01a65a5c: adrp     x27, #0x2212000
01a65a60: ldr      x25, [x25, #0x28]
01a65a64: ldr      x26, [x26, #0x18]
01a65a68: ldr      x27, [x27, #0xe0]
01a65a6c: mov      w22, wzr
01a65a70: mov      x28, sp
01a65a74: ldr      w8, [x0, #0x18]
01a65a78: cmp      w22, w8
01a65a7c: b.ge     #0x1a65c10
01a65a80: ldr      x2, [x25]
01a65a84: mov      w1, w22
01a65a88: bl       #0x145391c ; 
01a65a8c: cbz      x0, #0x1a65c0c
01a65a90: ldr      x8, [x0]
01a65a94: ldr      x1, [x26]
01a65a98: mov      x23, x0
01a65a9c: ldrh     w9, [x8, #0x12e]
01a65aa0: cbz      x9, #0x1a65ac4
01a65aa4: ldr      x10, [x8, #0xb0]
01a65aa8: add      x10, x10, #8
01a65aac: ldur     x11, [x10, #-8]
01a65ab0: cmp      x11, x1
01a65ab4: b.eq     #0x1a65ad4
01a65ab8: subs     x9, x9, #1
01a65abc: add      x10, x10, #0x10
01a65ac0: b.ne     #0x1a65aac
01a65ac4: mov      x0, x23
01a65ac8: mov      w2, #1
01a65acc: bl       #0xe8c450 ; 
01a65ad0: b        #0x1a65ae4 ; 
01a65ad4: ldr      w9, [x10]
01a65ad8: add      w9, w9, #1
01a65adc: add      x8, x8, w9, sxtw #4
01a65ae0: add      x0, x8, #0x138
01a65ae4: ldp      x8, x2, [x0]
01a65ae8: mov      x0, x23
01a65aec: mov      x1, x19
01a65af0: blr      x8
01a65af4: cbz      x0, #0x1a65c0c
01a65af8: ldr      w8, [x0, #0x20]
01a65afc: mov      x23, x0
01a65b00: cmp      w8, #1
01a65b04: b.lt     #0x1a65c00
01a65b08: ldr      x0, [x20, #0x10]
01a65b0c: stp      xzr, xzr, [sp]
01a65b10: cbz      x0, #0x1a65c0c
01a65b14: ldr      x2, [x25]
01a65b18: mov      w1, w22
01a65b1c: bl       #0x145391c ; 
01a65b20: cbz      x0, #0x1a65c0c
01a65b24: ldr      x8, [x0]
01a65b28: ldr      x1, [x26]
01a65b2c: mov      x24, x0
01a65b30: ldrh     w9, [x8, #0x12e]
01a65b34: cbz      x9, #0x1a65b58
01a65b38: ldr      x10, [x8, #0xb0]
01a65b3c: add      x10, x10, #8
01a65b40: ldur     x11, [x10, #-8]
01a65b44: cmp      x11, x1
01a65b48: b.eq     #0x1a65b68
01a65b4c: subs     x9, x9, #1
01a65b50: add      x10, x10, #0x10
01a65b54: b.ne     #0x1a65b40
01a65b58: mov      x0, x24
01a65b5c: mov      w2, wzr
01a65b60: bl       #0xe8c450 ; 
01a65b64: b        #0x1a65b74 ; 
01a65b68: ldrsw    x9, [x10]
01a65b6c: add      x8, x8, x9, lsl #4
01a65b70: add      x0, x8, #0x138
01a65b74: ldp      x8, x1, [x0]
01a65b78: mov      x0, x24
01a65b7c: blr      x8
01a65b80: mov      x1, x0
01a65b84: str      x0, [sp]
01a65b88: mov      x0, sp
01a65b8c: bl       #0xe54bf4 ; 
01a65b90: add      x0, x28, #8
01a65b94: mov      x1, x23
01a65b98: str      x23, [sp, #8]
01a65b9c: bl       #0xe54bf4 ; 
01a65ba0: cbz      x21, #0x1a65c0c
01a65ba4: ldr      w10, [x21, #0x1c]
01a65ba8: ldp      x1, x2, [sp]
01a65bac: ldr      x8, [x21, #0x10]
01a65bb0: ldr      x9, [x27]
01a65bb4: add      w10, w10, #1
01a65bb8: str      w10, [x21, #0x1c]
01a65bbc: cbz      x8, #0x1a65c0c
01a65bc0: ldrsw    x10, [x21, #0x18]
01a65bc4: ldr      w11, [x8, #0x18]
01a65bc8: cmp      w10, w11
01a65bcc: b.hs     #0x1a65bec
01a65bd0: add      x0, x8, x10, lsl #4
01a65bd4: add      w9, w10, #1
01a65bd8: str      w9, [x21, #0x18]
01a65bdc: stp      x1, x2, [x0, #0x20]!
01a65be0: mov      x1, xzr
01a65be4: bl       #0xe54bf4 ; 
01a65be8: b        #0x1a65c00 ; 
01a65bec: ldr      x8, [x9, #0x20]
01a65bf0: mov      x0, x21
01a65bf4: ldr      x8, [x8, #0xc0]
01a65bf8: ldr      x3, [x8, #0x70]
01a65bfc: bl       #0x1464890 ; 
01a65c00: ldr      x0, [x20, #0x10]
01a65c04: add      w22, w22, #1
01a65c08: cbnz     x0, #0x1a65a74
01a65c0c: bl       #0xe54eac ; 
01a65c10: mov      x0, x21
01a65c14: ldp      x20, x19, [sp, #0x60]
01a65c18: ldp      x22, x21, [sp, #0x50]
01a65c1c: ldr      x30, [sp, #0x10]
01a65c20: ldp      x24, x23, [sp, #0x40]
01a65c24: ldp      x26, x25, [sp, #0x30]
01a65c28: ldp      x28, x27, [sp, #0x20]
01a65c2c: add      sp, sp, #0x70
01a65c30: ret      