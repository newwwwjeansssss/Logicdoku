// Data.Pairzzle.PairzzleHintReasons.NoThree token=0x6000fe8 VA=0x1a66924
01a66924: sub      sp, sp, #0xf0
01a66928: stp      x29, x30, [sp, #0x90]
01a6692c: stp      x28, x27, [sp, #0xa0]
01a66930: stp      x26, x25, [sp, #0xb0]
01a66934: stp      x24, x23, [sp, #0xc0]
01a66938: stp      x22, x21, [sp, #0xd0]
01a6693c: stp      x20, x19, [sp, #0xe0]
01a66940: adrp     x19, #0x2387000
01a66944: mov      w21, w4
01a66948: mov      w22, w2
01a6694c: ldrb     w9, [x19, #0xccc]
01a66950: mov      x23, x1
01a66954: mov      x24, x0
01a66958: str      w3, [sp, #0x14]
01a6695c: str      x8, [sp, #0x18]
01a66960: tbnz     w9, #0, #0x1a669c0
01a66964: adrp     x0, #0x2206000
01a66968: ldr      x0, [x0, #0x218]
01a6696c: bl       #0xe54c48 ; 
01a66970: adrp     x0, #0x2212000
01a66974: ldr      x0, [x0, #0x148]
01a66978: bl       #0xe54c48 ; 
01a6697c: adrp     x0, #0x2212000
01a66980: ldr      x0, [x0, #0x108]
01a66984: bl       #0xe54c48 ; 
01a66988: adrp     x0, #0x2212000
01a6698c: ldr      x0, [x0, #0x60]
01a66990: bl       #0xe54c48 ; 
01a66994: adrp     x0, #0x2212000
01a66998: ldr      x0, [x0, #0x160]
01a6699c: bl       #0xe54c48 ; 
01a669a0: adrp     x0, #0x2212000
01a669a4: ldr      x0, [x0, #0x140]
01a669a8: bl       #0xe54c48 ; 
01a669ac: adrp     x0, #0x21f9000
01a669b0: ldr      x0, [x0, #0xc20]
01a669b4: bl       #0xe54c48 ; 
01a669b8: mov      w8, #1
01a669bc: strb     w8, [x19, #0xccc]
01a669c0: movi     v0.2d, #0000000000000000
01a669c4: stp      q0, q0, [sp, #0x50]
01a669c8: cbz      x24, #0x1a66bfc
01a669cc: ldr      w28, [x24, #0x10]
01a669d0: mov      w20, wzr
01a669d4: sdiv     w26, w22, w28
01a669d8: msub     w27, w26, w28, w22
01a669dc: cmp      w20, #0
01a669e0: mov      w8, #2
01a669e4: csel     w29, w27, w26, eq
01a669e8: movk     w8, #0x8000, lsl #16
01a669ec: cmp      w29, w8
01a669f0: b.lt     #0x1a66a5c
01a669f4: mov      w19, w29
01a669f8: subs     w25, w19, #2
01a669fc: b.mi     #0x1a66a4c
01a66a00: cmp      w19, w28
01a66a04: b.ge     #0x1a66a4c
01a66a08: adrp     x8, #0x2212000
01a66a0c: ldr      x8, [x8, #0x60]
01a66a10: ldr      x0, [x8]
01a66a14: ldr      w8, [x0, #0xe4]
01a66a18: cbnz     w8, #0x1a66a20
01a66a1c: bl       #0xe54d80 ; 
01a66a20: cmp      w20, #0
01a66a24: mov      x0, x24
01a66a28: mov      x1, x23
01a66a2c: cset     w4, eq
01a66a30: mov      w2, w26
01a66a34: mov      w3, w27
01a66a38: mov      w5, w25
01a66a3c: mov      w6, w22
01a66a40: mov      w7, w21
01a66a44: bl       #0x1a67e30 ; PairzzleHintReasons.CollectTriplePair
01a66a48: cbnz     x0, #0x1a66a7c
01a66a4c: sub      w8, w19, #1
01a66a50: add      w19, w19, #1
01a66a54: cmp      w8, w29
01a66a58: b.le     #0x1a669f8
01a66a5c: add      w20, w20, #1
01a66a60: cmp      w20, #2
01a66a64: b.ne     #0x1a669dc
01a66a68: movi     v0.2d, #0000000000000000
01a66a6c: ldr      x8, [sp, #0x18]
01a66a70: str      xzr, [x8, #0x20]
01a66a74: stp      q0, q0, [x8]
01a66a78: b        #0x1a66bdc ; 
01a66a7c: adrp     x8, #0x2212000
01a66a80: movi     v0.2d, #0000000000000000
01a66a84: mov      x25, x0
01a66a88: ldr      x8, [x8, #0x160]
01a66a8c: add      x0, sp, #0x50
01a66a90: ldr      x1, [x8]
01a66a94: stp      q0, q0, [sp, #0x50]
01a66a98: str      x1, [sp, #0x50]
01a66a9c: bl       #0xe54bf4 ; 
01a66aa0: adrp     x8, #0x2212000
01a66aa4: mov      w1, #2
01a66aa8: ldr      x8, [x8, #0x108]
01a66aac: ldr      x0, [x8]
01a66ab0: bl       #0xe54cf0 ; 
01a66ab4: adrp     x8, #0x2212000
01a66ab8: mov      x22, x0
01a66abc: ldr      x8, [x8, #0x60]
01a66ac0: ldr      x8, [x8]
01a66ac4: ldr      w9, [x8, #0xe4]
01a66ac8: cbnz     w9, #0x1a66ad4
01a66acc: mov      x0, x8
01a66ad0: bl       #0xe54d80 ; 
01a66ad4: adrp     x8, #0x21f9000
01a66ad8: mov      w1, w21
01a66adc: ldr      x8, [x8, #0xc20]
01a66ae0: ldr      x0, [x8]
01a66ae4: add      x8, sp, #0x38
01a66ae8: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a66aec: cbz      x22, #0x1a66bfc
01a66af0: ldr      w8, [x22, #0x18]
01a66af4: cbz      w8, #0x1a66c00
01a66af8: ldur     q0, [sp, #0x38]
01a66afc: ldr      x8, [sp, #0x48]
01a66b00: add      x0, x22, #0x20
01a66b04: mov      x1, xzr
01a66b08: str      q0, [x22, #0x20]
01a66b0c: str      x8, [x22, #0x30]
01a66b10: bl       #0xe54bf4 ; 
01a66b14: adrp     x8, #0x2212000
01a66b18: ldr      x8, [x8, #0x140]
01a66b1c: ldr      w1, [sp, #0x14]
01a66b20: ldr      x0, [x8]
01a66b24: add      x8, sp, #0x20
01a66b28: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a66b2c: ldr      w8, [x22, #0x18]
01a66b30: tst      w8, #0xfffffffe
01a66b34: b.eq     #0x1a66c00
01a66b38: ldr      q0, [sp, #0x20]
01a66b3c: ldr      x8, [sp, #0x30]
01a66b40: add      x0, x22, #0x38
01a66b44: mov      x1, xzr
01a66b48: stur     q0, [x22, #0x38]
01a66b4c: str      x8, [x22, #0x48]
01a66b50: bl       #0xe54bf4 ; 
01a66b54: add      x19, sp, #0x50
01a66b58: mov      x1, x22
01a66b5c: str      x22, [sp, #0x58]
01a66b60: orr      x0, x19, #8
01a66b64: bl       #0xe54bf4 ; 
01a66b68: adrp     x8, #0x2206000
01a66b6c: mov      x0, x25
01a66b70: ldr      x8, [x8, #0x218]
01a66b74: ldr      x1, [x8]
01a66b78: bl       #0x1405f58 ; 
01a66b7c: mov      x1, x0
01a66b80: str      x0, [sp, #0x60]
01a66b84: add      x0, x19, #0x10
01a66b88: bl       #0xe54bf4 ; 
01a66b8c: adrp     x8, #0x2212000
01a66b90: add      x0, x19, #0x18
01a66b94: ldr      x8, [x8, #0x60]
01a66b98: ldr      x8, [x8]
01a66b9c: ldr      x8, [x8, #0xb8]
01a66ba0: ldr      x1, [x8]
01a66ba4: str      x1, [sp, #0x68]
01a66ba8: bl       #0xe54bf4 ; 
01a66bac: movi     v0.2d, #0000000000000000
01a66bb0: ldp      q1, q2, [sp, #0x50]
01a66bb4: ldr      x0, [sp, #0x18]
01a66bb8: adrp     x8, #0x2212000
01a66bbc: add      x1, sp, #0x70
01a66bc0: stp      q1, q2, [sp, #0x70]
01a66bc4: str      q0, [x0]
01a66bc8: ldr      x8, [x8, #0x148]
01a66bcc: str      q0, [x0, #0x10]
01a66bd0: str      xzr, [x0, #0x20]
01a66bd4: ldr      x2, [x8]
01a66bd8: bl       #0x14ff434 ; 
01a66bdc: ldp      x20, x19, [sp, #0xe0]
01a66be0: ldp      x22, x21, [sp, #0xd0]
01a66be4: ldp      x24, x23, [sp, #0xc0]
01a66be8: ldp      x26, x25, [sp, #0xb0]
01a66bec: ldp      x28, x27, [sp, #0xa0]
01a66bf0: ldp      x29, x30, [sp, #0x90]
01a66bf4: add      sp, sp, #0xf0
01a66bf8: ret      
01a66bfc: bl       #0xe54eac ; 
01a66c00: bl       #0xe54eb4 ; 