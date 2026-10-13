// Data.Pairzzle.PairzzleRuleSet..ctor token=0x6001053 VA=0x1a61a28
01a61a28: str      x30, [sp, #-0x40]!
01a61a2c: stp      x24, x23, [sp, #0x10]
01a61a30: stp      x22, x21, [sp, #0x20]
01a61a34: stp      x20, x19, [sp, #0x30]
01a61a38: adrp     x24, #0x2387000
01a61a3c: adrp     x23, #0x2211000
01a61a40: adrp     x21, #0x2211000
01a61a44: adrp     x22, #0x2211000
01a61a48: ldr      x23, [x23, #0xf70]
01a61a4c: ldrb     w8, [x24, #0xd1a]
01a61a50: ldr      x21, [x21, #0xf78]
01a61a54: ldr      x22, [x22, #0xf80]
01a61a58: mov      x19, x1
01a61a5c: mov      x20, x0
01a61a60: tbnz     w8, #0, #0x1a61afc
01a61a64: adrp     x0, #0x2211000
01a61a68: ldr      x0, [x0, #0xf80]
01a61a6c: bl       #0xe54c48 ; 
01a61a70: adrp     x0, #0x2211000
01a61a74: ldr      x0, [x0, #0xf88]
01a61a78: bl       #0xe54c48 ; 
01a61a7c: adrp     x0, #0x2211000
01a61a80: ldr      x0, [x0, #0xf90]
01a61a84: bl       #0xe54c48 ; 
01a61a88: adrp     x0, #0x2211000
01a61a8c: ldr      x0, [x0, #0xf98]
01a61a90: bl       #0xe54c48 ; 
01a61a94: adrp     x0, #0x2211000
01a61a98: ldr      x0, [x0, #0xfa0]
01a61a9c: bl       #0xe54c48 ; 
01a61aa0: adrp     x0, #0x2211000
01a61aa4: ldr      x0, [x0, #0xf78]
01a61aa8: bl       #0xe54c48 ; 
01a61aac: adrp     x0, #0x220f000
01a61ab0: ldr      x0, [x0, #0x60]
01a61ab4: bl       #0xe54c48 ; 
01a61ab8: adrp     x0, #0x220f000
01a61abc: ldr      x0, [x0, #0x40]
01a61ac0: bl       #0xe54c48 ; 
01a61ac4: adrp     x0, #0x220f000
01a61ac8: ldr      x0, [x0, #0x70]
01a61acc: bl       #0xe54c48 ; 
01a61ad0: adrp     x0, #0x2211000
01a61ad4: ldr      x0, [x0, #0xf70]
01a61ad8: bl       #0xe54c48 ; 
01a61adc: adrp     x0, #0x2211000
01a61ae0: ldr      x0, [x0, #0xfa8]
01a61ae4: bl       #0xe54c48 ; 
01a61ae8: adrp     x0, #0x2211000
01a61aec: ldr      x0, [x0, #0xfb0]
01a61af0: bl       #0xe54c48 ; 
01a61af4: mov      w8, #1
01a61af8: strb     w8, [x24, #0xd1a]
01a61afc: mov      x0, x20
01a61b00: mov      x1, xzr
01a61b04: bl       #0x18ca704 ; Object..ctor
01a61b08: ldr      x0, [x23]
01a61b0c: bl       #0xe54e9c ; 
01a61b10: ldr      x1, [x21]
01a61b14: mov      x21, x0
01a61b18: bl       #0x1453384 ; 
01a61b1c: ldr      x0, [x22]
01a61b20: bl       #0xe54e9c ; 
01a61b24: mov      x1, xzr
01a61b28: mov      x22, x0
01a61b2c: bl       #0x18ca704 ; Object..ctor
01a61b30: mov      x0, x22
01a61b34: mov      x1, x19
01a61b38: str      x19, [x0, #0x10]!
01a61b3c: bl       #0xe54bf4 ; 
01a61b40: cbz      x21, #0x1a61ee8
01a61b44: adrp     x23, #0x2211000
01a61b48: ldr      x23, [x23, #0xfa0]
01a61b4c: ldr      w10, [x21, #0x1c]
01a61b50: ldr      x8, [x21, #0x10]
01a61b54: ldr      x9, [x23]
01a61b58: add      w10, w10, #1
01a61b5c: str      w10, [x21, #0x1c]
01a61b60: cbz      x8, #0x1a61ee8
01a61b64: ldrsw    x10, [x21, #0x18]
01a61b68: ldr      w11, [x8, #0x18]
01a61b6c: adrp     x24, #0x2211000
01a61b70: ldr      x24, [x24, #0xfa8]
01a61b74: cmp      w10, w11
01a61b78: b.hs     #0x1a61b98
01a61b7c: add      x0, x8, x10, lsl #3
01a61b80: add      w9, w10, #1
01a61b84: mov      x1, x22
01a61b88: str      w9, [x21, #0x18]
01a61b8c: str      x22, [x0, #0x20]!
01a61b90: bl       #0xe54bf4 ; 
01a61b94: b        #0x1a61bb0 ; 
01a61b98: ldr      x8, [x9, #0x20]
01a61b9c: mov      x0, x21
01a61ba0: mov      x1, x22
01a61ba4: ldr      x8, [x8, #0xc0]
01a61ba8: ldr      x2, [x8, #0x70]
01a61bac: bl       #0x1453bec ; 
01a61bb0: ldr      x0, [x24]
01a61bb4: bl       #0xe54e9c ; 
01a61bb8: mov      x1, xzr
01a61bbc: mov      x22, x0
01a61bc0: bl       #0x18ca704 ; Object..ctor
01a61bc4: mov      x0, x22
01a61bc8: mov      x1, x19
01a61bcc: str      x19, [x0, #0x10]!
01a61bd0: bl       #0xe54bf4 ; 
01a61bd4: ldr      w10, [x21, #0x1c]
01a61bd8: ldr      x8, [x21, #0x10]
01a61bdc: ldr      x9, [x23]
01a61be0: add      w10, w10, #1
01a61be4: str      w10, [x21, #0x1c]
01a61be8: cbz      x8, #0x1a61ee8
01a61bec: ldrsw    x10, [x21, #0x18]
01a61bf0: ldr      w11, [x8, #0x18]
01a61bf4: cmp      w10, w11
01a61bf8: b.hs     #0x1a61c18
01a61bfc: add      x0, x8, x10, lsl #3
01a61c00: add      w9, w10, #1
01a61c04: mov      x1, x22
01a61c08: str      w9, [x21, #0x18]
01a61c0c: str      x22, [x0, #0x20]!
01a61c10: bl       #0xe54bf4 ; 
01a61c14: b        #0x1a61c30 ; 
01a61c18: ldr      x8, [x9, #0x20]
01a61c1c: mov      x0, x21
01a61c20: mov      x1, x22
01a61c24: ldr      x8, [x8, #0xc0]
01a61c28: ldr      x2, [x8, #0x70]
01a61c2c: bl       #0x1453bec ; 
01a61c30: str      x21, [x20, #0x10]!
01a61c34: mov      x0, x20
01a61c38: mov      x1, x21
01a61c3c: bl       #0xe54bf4 ; 
01a61c40: cbz      x19, #0x1a61ee8
01a61c44: ldr      x8, [x19, #0x40]
01a61c48: cbz      x8, #0x1a61ee8
01a61c4c: ldr      w8, [x8, #0x18]
01a61c50: cmp      w8, #1
01a61c54: b.lt     #0x1a61ce8
01a61c58: adrp     x8, #0x2211000
01a61c5c: ldr      x8, [x8, #0xf98]
01a61c60: ldr      x21, [x20]
01a61c64: ldr      x0, [x8]
01a61c68: bl       #0xe54e9c ; 
01a61c6c: mov      x1, xzr
01a61c70: mov      x22, x0
01a61c74: bl       #0x18ca704 ; Object..ctor
01a61c78: mov      x0, x22
01a61c7c: mov      x1, x19
01a61c80: str      x19, [x0, #0x10]!
01a61c84: bl       #0xe54bf4 ; 
01a61c88: cbz      x21, #0x1a61ee8
01a61c8c: ldr      w10, [x21, #0x1c]
01a61c90: ldr      x8, [x21, #0x10]
01a61c94: ldr      x9, [x23]
01a61c98: add      w10, w10, #1
01a61c9c: str      w10, [x21, #0x1c]
01a61ca0: cbz      x8, #0x1a61ee8
01a61ca4: ldrsw    x10, [x21, #0x18]
01a61ca8: ldr      w11, [x8, #0x18]
01a61cac: cmp      w10, w11
01a61cb0: b.hs     #0x1a61cd0
01a61cb4: add      x0, x8, x10, lsl #3
01a61cb8: add      w9, w10, #1
01a61cbc: mov      x1, x22
01a61cc0: str      w9, [x21, #0x18]
01a61cc4: str      x22, [x0, #0x20]!
01a61cc8: bl       #0xe54bf4 ; 
01a61ccc: b        #0x1a61ce8 ; 
01a61cd0: ldr      x8, [x9, #0x20]
01a61cd4: mov      x0, x21
01a61cd8: mov      x1, x22
01a61cdc: ldr      x8, [x8, #0xc0]
01a61ce0: ldr      x2, [x8, #0x70]
01a61ce4: bl       #0x1453bec ; 
01a61ce8: ldr      x8, [x19, #0x28]
01a61cec: cbz      x8, #0x1a61d70
01a61cf0: adrp     x8, #0x2211000
01a61cf4: ldr      x8, [x8, #0xfb0]
01a61cf8: ldr      x21, [x20]
01a61cfc: ldr      x0, [x8]
01a61d00: bl       #0xe54e9c ; 
01a61d04: mov      x1, x19
01a61d08: mov      x22, x0
01a61d0c: bl       #0x1a6c30c ; RegionConstraint..ctor
01a61d10: cbz      x21, #0x1a61ee8
01a61d14: ldr      w10, [x21, #0x1c]
01a61d18: ldr      x8, [x21, #0x10]
01a61d1c: ldr      x9, [x23]
01a61d20: add      w10, w10, #1
01a61d24: str      w10, [x21, #0x1c]
01a61d28: cbz      x8, #0x1a61ee8
01a61d2c: ldrsw    x10, [x21, #0x18]
01a61d30: ldr      w11, [x8, #0x18]
01a61d34: cmp      w10, w11
01a61d38: b.hs     #0x1a61d58
01a61d3c: add      x0, x8, x10, lsl #3
01a61d40: add      w9, w10, #1
01a61d44: mov      x1, x22
01a61d48: str      w9, [x21, #0x18]
01a61d4c: str      x22, [x0, #0x20]!
01a61d50: bl       #0xe54bf4 ; 
01a61d54: b        #0x1a61d70 ; 
01a61d58: ldr      x8, [x9, #0x20]
01a61d5c: mov      x0, x21
01a61d60: mov      x1, x22
01a61d64: ldr      x8, [x8, #0xc0]
01a61d68: ldr      x2, [x8, #0x70]
01a61d6c: bl       #0x1453bec ; 
01a61d70: ldr      x8, [x19, #0x50]
01a61d74: cbz      x8, #0x1a61ee8
01a61d78: ldr      w8, [x8, #0x18]
01a61d7c: cmp      w8, #1
01a61d80: b.lt     #0x1a61e14
01a61d84: adrp     x8, #0x2211000
01a61d88: ldr      x8, [x8, #0xf88]
01a61d8c: ldr      x21, [x20]
01a61d90: ldr      x0, [x8]
01a61d94: bl       #0xe54e9c ; 
01a61d98: mov      x1, xzr
01a61d9c: mov      x22, x0
01a61da0: bl       #0x18ca704 ; Object..ctor
01a61da4: mov      x0, x22
01a61da8: mov      x1, x19
01a61dac: str      x19, [x0, #0x10]!
01a61db0: bl       #0xe54bf4 ; 
01a61db4: cbz      x21, #0x1a61ee8
01a61db8: ldr      w10, [x21, #0x1c]
01a61dbc: ldr      x8, [x21, #0x10]
01a61dc0: ldr      x9, [x23]
01a61dc4: add      w10, w10, #1
01a61dc8: str      w10, [x21, #0x1c]
01a61dcc: cbz      x8, #0x1a61ee8
01a61dd0: ldrsw    x10, [x21, #0x18]
01a61dd4: ldr      w11, [x8, #0x18]
01a61dd8: cmp      w10, w11
01a61ddc: b.hs     #0x1a61dfc
01a61de0: add      x0, x8, x10, lsl #3
01a61de4: add      w9, w10, #1
01a61de8: mov      x1, x22
01a61dec: str      w9, [x21, #0x18]
01a61df0: str      x22, [x0, #0x20]!
01a61df4: bl       #0xe54bf4 ; 
01a61df8: b        #0x1a61e14 ; 
01a61dfc: ldr      x8, [x9, #0x20]
01a61e00: mov      x0, x21
01a61e04: mov      x1, x22
01a61e08: ldr      x8, [x8, #0xc0]
01a61e0c: ldr      x2, [x8, #0x70]
01a61e10: bl       #0x1453bec ; 
01a61e14: ldr      x8, [x19, #0x48]
01a61e18: cbz      x8, #0x1a61ee8
01a61e1c: ldr      w8, [x8, #0x18]
01a61e20: cmp      w8, #1
01a61e24: b.lt     #0x1a61eac
01a61e28: adrp     x8, #0x2211000
01a61e2c: ldr      x8, [x8, #0xf90]
01a61e30: ldr      x20, [x20]
01a61e34: ldr      x0, [x8]
01a61e38: bl       #0xe54e9c ; 
01a61e3c: mov      x1, xzr
01a61e40: mov      x21, x0
01a61e44: bl       #0x18ca704 ; Object..ctor
01a61e48: mov      x0, x21
01a61e4c: mov      x1, x19
01a61e50: str      x19, [x0, #0x10]!
01a61e54: bl       #0xe54bf4 ; 
01a61e58: cbz      x20, #0x1a61ee8
01a61e5c: ldr      w10, [x20, #0x1c]
01a61e60: ldr      x8, [x20, #0x10]
01a61e64: ldr      x9, [x23]
01a61e68: add      w10, w10, #1
01a61e6c: str      w10, [x20, #0x1c]
01a61e70: cbz      x8, #0x1a61ee8
01a61e74: ldrsw    x10, [x20, #0x18]
01a61e78: ldr      w11, [x8, #0x18]
01a61e7c: cmp      w10, w11
01a61e80: b.hs     #0x1a61ec0
01a61e84: add      x0, x8, x10, lsl #3
01a61e88: add      w8, w10, #1
01a61e8c: mov      x1, x21
01a61e90: str      w8, [x20, #0x18]
01a61e94: ldp      x20, x19, [sp, #0x30]
01a61e98: str      x21, [x0, #0x20]!
01a61e9c: ldp      x22, x21, [sp, #0x20]
01a61ea0: ldp      x24, x23, [sp, #0x10]
01a61ea4: ldr      x30, [sp], #0x40
01a61ea8: b        #0xe54bf4 ; 
01a61eac: ldp      x20, x19, [sp, #0x30]
01a61eb0: ldp      x22, x21, [sp, #0x20]
01a61eb4: ldp      x24, x23, [sp, #0x10]
01a61eb8: ldr      x30, [sp], #0x40
01a61ebc: ret      
01a61ec0: ldr      x8, [x9, #0x20]
01a61ec4: mov      x0, x20
01a61ec8: mov      x1, x21
01a61ecc: ldp      x20, x19, [sp, #0x30]
01a61ed0: ldr      x8, [x8, #0xc0]
01a61ed4: ldp      x22, x21, [sp, #0x20]
01a61ed8: ldp      x24, x23, [sp, #0x10]
01a61edc: ldr      x2, [x8, #0x70]
01a61ee0: ldr      x30, [sp], #0x40
01a61ee4: b        #0x1453bec ; 
01a61ee8: bl       #0xe54eac ; 