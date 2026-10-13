// Data.Pairzzle.PairzzleHintReasons.Corner token=0x6000fed VA=0x1a67870
01a67870: sub      sp, sp, #0xf0
01a67874: stp      x29, x30, [sp, #0x90]
01a67878: stp      x28, x27, [sp, #0xa0]
01a6787c: stp      x26, x25, [sp, #0xb0]
01a67880: stp      x24, x23, [sp, #0xc0]
01a67884: stp      x22, x21, [sp, #0xd0]
01a67888: stp      x20, x19, [sp, #0xe0]
01a6788c: adrp     x22, #0x2387000
01a67890: mov      w20, w2
01a67894: mov      w23, w1
01a67898: ldrb     w9, [x22, #0xcd1]
01a6789c: mov      x21, x0
01a678a0: mov      x19, x8
01a678a4: tbnz     w9, #0, #0x1a67934
01a678a8: adrp     x0, #0x220f000
01a678ac: ldr      x0, [x0, #0x70]
01a678b0: bl       #0xe54c48 ;
01a678b4: adrp     x0, #0x220f000
01a678b8: ldr      x0, [x0, #0x78]
01a678bc: bl       #0xe54c48 ;
01a678c0: adrp     x0, #0x2212000
01a678c4: ldr      x0, [x0, #0x148]
01a678c8: bl       #0xe54c48 ;
01a678cc: adrp     x0, #0x2212000
01a678d0: ldr      x0, [x0, #0x100]
01a678d4: bl       #0xe54c48 ;
01a678d8: adrp     x0, #0x2212000
01a678dc: ldr      x0, [x0, #0x108]
01a678e0: bl       #0xe54c48 ;
01a678e4: adrp     x0, #0x2212000
01a678e8: ldr      x0, [x0, #0x60]
01a678ec: bl       #0xe54c48 ;
01a678f0: adrp     x0, #0x2212000
01a678f4: ldr      x0, [x0, #0x1b0]
01a678f8: bl       #0xe54c48 ;
01a678fc: adrp     x0, #0x2212000
01a67900: ldr      x0, [x0, #0x150]
01a67904: bl       #0xe54c48 ;
01a67908: adrp     x0, #0x2212000
01a6790c: ldr      x0, [x0, #0x118]
01a67910: bl       #0xe54c48 ;
01a67914: adrp     x0, #0x2212000
01a67918: ldr      x0, [x0, #0x140]
01a6791c: bl       #0xe54c48 ;
01a67920: adrp     x0, #0x2212000
01a67924: ldr      x0, [x0, #0x1a8]
01a67928: bl       #0xe54c48 ;
01a6792c: mov      w8, #1
01a67930: strb     w8, [x22, #0xcd1]
01a67934: movi     v0.2d, #0000000000000000
01a67938: stp      q0, q0, [sp, #0x50]
01a6793c: cbz      x21, #0x1a67bb8
01a67940: adrp     x8, #0x2212000
01a67944: mov      x0, x21
01a67948: ldr      x8, [x8, #0x118]
01a6794c: ldr      w24, [x21, #0x10]
01a67950: ldr      x25, [x21, #0x50]
01a67954: ldr      x1, [x8]
01a67958: bl       #0x1a68048 ; PairzzleRuleScopes.Of
01a6795c: cbz      x25, #0x1a67bb8
01a67960: ldr      w8, [x25, #0x18]
01a67964: cmp      w8, #1
01a67968: b.lt     #0x1a679d4
01a6796c: sdiv     w27, w23, w24
01a67970: adrp     x28, #0x220f000
01a67974: mov      x21, x0
01a67978: ldr      x28, [x28, #0x78]
01a6797c: mov      w22, wzr
01a67980: mov      w26, #2
01a67984: mov      x29, #0x100000000
01a67988: msub     w23, w27, w24, w23
01a6798c: ldr      x2, [x28]
01a67990: mov      x0, x25
01a67994: mov      w1, w22
01a67998: bl       #0x1455e28 ;
01a6799c: add      w8, w0, #1
01a679a0: cmp      w27, w0
01a679a4: ccmp     w8, w27, #4, ne
01a679a8: b.ne     #0x1a679c0
01a679ac: lsr      x8, x0, #0x20
01a679b0: add      w9, w8, #1
01a679b4: cmp      w23, w8
01a679b8: ccmp     w9, w23, #4, ne
01a679bc: b.eq     #0x1a679e4
01a679c0: ldr      w8, [x25, #0x18]
01a679c4: add      w22, w22, #1
01a679c8: add      x26, x26, x29
01a679cc: cmp      w22, w8
01a679d0: b.lt     #0x1a6798c
01a679d4: movi     v0.2d, #0000000000000000
01a679d8: str      xzr, [x19, #0x20]
01a679dc: stp      q0, q0, [x19]
01a679e0: b        #0x1a67b98 ;
01a679e4: adrp     x8, #0x2212000
01a679e8: movi     v0.2d, #0000000000000000
01a679ec: mov      x24, x1
01a679f0: ldr      x8, [x8, #0x1b0]
01a679f4: add      x0, sp, #0x50
01a679f8: ldr      x1, [x8]
01a679fc: stp      q0, q0, [sp, #0x50]
01a67a00: str      x1, [sp, #0x50]
01a67a04: bl       #0xe54bf4 ;
01a67a08: adrp     x8, #0x2212000
01a67a0c: mov      w1, #3
01a67a10: ldr      x8, [x8, #0x108]
01a67a14: ldr      x0, [x8]
01a67a18: bl       #0xe54cf0 ;
01a67a1c: adrp     x8, #0x2212000
01a67a20: lsr      x25, x24, #0x20
01a67a24: mov      x23, x0
01a67a28: ldr      x8, [x8, #0x60]
01a67a2c: ldr      x8, [x8]
01a67a30: ldr      w9, [x8, #0xe4]
01a67a34: cbnz     w9, #0x1a67a40
01a67a38: mov      x0, x8
01a67a3c: bl       #0xe54d80 ;
01a67a40: adrp     x8, #0x2212000
01a67a44: mov      w1, w25
01a67a48: ldr      x8, [x8, #0x150]
01a67a4c: ldr      x0, [x8]
01a67a50: add      x8, sp, #0x38
01a67a54: bl       #0x1a67d28 ; PairzzleHintReasons.NumberArg
01a67a58: cbz      x23, #0x1a67bb8
01a67a5c: ldr      w8, [x23, #0x18]
01a67a60: cbz      w8, #0x1a67bbc
01a67a64: ldur     q0, [sp, #0x38]
01a67a68: ldr      x8, [sp, #0x48]
01a67a6c: add      x0, x23, #0x20
01a67a70: mov      x1, xzr
01a67a74: str      q0, [x23, #0x20]
01a67a78: str      x8, [x23, #0x30]
01a67a7c: bl       #0xe54bf4 ;
01a67a80: adrp     x8, #0x2212000
01a67a84: mov      w1, w24
01a67a88: ldr      x8, [x8, #0x1a8]
01a67a8c: ldr      x0, [x8]
01a67a90: add      x8, sp, #0x20
01a67a94: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a67a98: ldr      w8, [x23, #0x18]
01a67a9c: tst      w8, #0xfffffffe
01a67aa0: b.eq     #0x1a67bbc
01a67aa4: ldr      q0, [sp, #0x20]
01a67aa8: ldr      x8, [sp, #0x30]
01a67aac: add      x0, x23, #0x38
01a67ab0: mov      x1, xzr
01a67ab4: stur     q0, [x23, #0x38]
01a67ab8: str      x8, [x23, #0x48]
01a67abc: bl       #0xe54bf4 ;
01a67ac0: adrp     x8, #0x2212000
01a67ac4: mov      w1, w20
01a67ac8: ldr      x8, [x8, #0x140]
01a67acc: ldr      x0, [x8]
01a67ad0: add      x8, sp, #8
01a67ad4: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a67ad8: ldr      w8, [x23, #0x18]
01a67adc: cmp      w8, #2
01a67ae0: b.ls     #0x1a67bbc
01a67ae4: ldur     q0, [sp, #8]
01a67ae8: ldr      x8, [sp, #0x18]
01a67aec: add      x0, x23, #0x50
01a67af0: mov      x1, xzr
01a67af4: str      q0, [x23, #0x50]
01a67af8: str      x8, [x23, #0x60]
01a67afc: bl       #0xe54bf4 ;
01a67b00: add      x20, sp, #0x50
01a67b04: mov      x1, x23
01a67b08: str      x23, [sp, #0x58]
01a67b0c: orr      x0, x20, #8
01a67b10: bl       #0xe54bf4 ;
01a67b14: mov      x0, x21
01a67b18: mov      w1, w22
01a67b1c: bl       #0x1a681ec ; PairzzleHintReasons.ScopeCellsOf
01a67b20: mov      x1, x0
01a67b24: str      x0, [sp, #0x60]
01a67b28: add      x0, x20, #0x10
01a67b2c: bl       #0xe54bf4 ;
01a67b30: adrp     x8, #0x2212000
01a67b34: mov      w1, #1
01a67b38: ldr      x8, [x8, #0x100]
01a67b3c: ldr      x0, [x8]
01a67b40: bl       #0xe54cf0 ;
01a67b44: cbz      x0, #0x1a67bb8
01a67b48: ldr      w8, [x0, #0x18]
01a67b4c: mov      x1, x0
01a67b50: cbz      w8, #0x1a67bbc
01a67b54: add      x8, sp, #0x50
01a67b58: str      x26, [x1, #0x20]
01a67b5c: add      x0, x8, #0x18
01a67b60: str      x1, [sp, #0x68]
01a67b64: bl       #0xe54bf4 ;
01a67b68: ldp      q1, q2, [sp, #0x50]
01a67b6c: adrp     x8, #0x2212000
01a67b70: movi     v0.2d, #0000000000000000
01a67b74: add      x1, sp, #0x70
01a67b78: mov      x0, x19
01a67b7c: str      q1, [sp, #0x70]
01a67b80: ldr      x8, [x8, #0x148]
01a67b84: str      q2, [sp, #0x80]
01a67b88: stp      q0, q0, [x19]
01a67b8c: ldr      x2, [x8]
01a67b90: str      xzr, [x19, #0x20]
01a67b94: bl       #0x14ff434 ;
01a67b98: ldp      x20, x19, [sp, #0xe0]
01a67b9c: ldp      x22, x21, [sp, #0xd0]
01a67ba0: ldp      x24, x23, [sp, #0xc0]
01a67ba4: ldp      x26, x25, [sp, #0xb0]
01a67ba8: ldp      x28, x27, [sp, #0xa0]
01a67bac: ldp      x29, x30, [sp, #0x90]
01a67bb0: add      sp, sp, #0xf0
01a67bb4: ret
01a67bb8: bl       #0xe54eac ;
01a67bbc: bl       #0xe54eb4 ;
