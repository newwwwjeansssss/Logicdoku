// Data.Pairzzle.PairzzleHintReasons.Region token=0x6000feb VA=0x1a66ffc
01a66ffc: sub      sp, sp, #0xd0
01a67000: stp      x29, x30, [sp, #0x70]
01a67004: stp      x28, x27, [sp, #0x80]
01a67008: stp      x26, x25, [sp, #0x90]
01a6700c: stp      x24, x23, [sp, #0xa0]
01a67010: stp      x22, x21, [sp, #0xb0]
01a67014: stp      x20, x19, [sp, #0xc0]
01a67018: adrp     x22, #0x2387000
01a6701c: mov      w21, w4
01a67020: mov      w20, w3
01a67024: ldrb     w9, [x22, #0xccf]
01a67028: mov      w25, w2
01a6702c: mov      x23, x1
01a67030: mov      x24, x0
01a67034: mov      x19, x8
01a67038: tbnz     w9, #0, #0x1a670bc
01a6703c: adrp     x0, #0x21f1000
01a67040: ldr      x0, [x0, #0x3f0]
01a67044: bl       #0xe54c48 ; 
01a67048: adrp     x0, #0x2206000
01a6704c: ldr      x0, [x0, #0x218]
01a67050: bl       #0xe54c48 ; 
01a67054: adrp     x0, #0x2206000
01a67058: ldr      x0, [x0, #0x210]
01a6705c: bl       #0xe54c48 ; 
01a67060: adrp     x0, #0x21f1000
01a67064: ldr      x0, [x0, #0x688]
01a67068: bl       #0xe54c48 ; 
01a6706c: adrp     x0, #0x2212000
01a67070: ldr      x0, [x0, #0x148]
01a67074: bl       #0xe54c48 ; 
01a67078: adrp     x0, #0x2212000
01a6707c: ldr      x0, [x0, #0x108]
01a67080: bl       #0xe54c48 ; 
01a67084: adrp     x0, #0x2212000
01a67088: ldr      x0, [x0, #0x60]
01a6708c: bl       #0xe54c48 ; 
01a67090: adrp     x0, #0x2212000
01a67094: ldr      x0, [x0, #0x190]
01a67098: bl       #0xe54c48 ; 
01a6709c: adrp     x0, #0x2212000
01a670a0: ldr      x0, [x0, #0x140]
01a670a4: bl       #0xe54c48 ; 
01a670a8: adrp     x0, #0x21f9000
01a670ac: ldr      x0, [x0, #0xc20]
01a670b0: bl       #0xe54c48 ; 
01a670b4: mov      w8, #1
01a670b8: strb     w8, [x22, #0xccf]
01a670bc: movi     v0.2d, #0000000000000000
01a670c0: stp      q0, q0, [sp, #0x30]
01a670c4: cbz      x24, #0x1a67374
01a670c8: ldr      x27, [x24, #0x28]
01a670cc: cbz      x27, #0x1a67348
01a670d0: ldr      w8, [x27, #0x18]
01a670d4: cmp      w8, w25
01a670d8: b.le     #0x1a67348
01a670dc: b.ls     #0x1a67370
01a670e0: add      x8, x27, w25, sxtw #2
01a670e4: ldr      w28, [x8, #0x20]
01a670e8: tbnz     w28, #0x1f, #0x1a67348
01a670ec: adrp     x8, #0x21f1000
01a670f0: ldr      x8, [x8, #0x688]
01a670f4: ldr      x0, [x8]
01a670f8: bl       #0xe54e9c ; 
01a670fc: adrp     x8, #0x2206000
01a67100: mov      x22, x0
01a67104: ldr      x8, [x8, #0x210]
01a67108: ldr      x1, [x8]
01a6710c: bl       #0x1403fc4 ; 
01a67110: ldr      x8, [x27, #0x18]
01a67114: cmp      w8, #1
01a67118: b.lt     #0x1a671ec
01a6711c: mov      x26, xzr
01a67120: and      x8, x8, #0xffffffff
01a67124: mov      w25, w25
01a67128: add      x29, x27, #0x20
01a6712c: cmp      x25, x26
01a67130: b.eq     #0x1a671dc
01a67134: cmp      x26, w8, uxtw
01a67138: b.hs     #0x1a67370
01a6713c: ldr      w8, [x29, x26, lsl #2]
01a67140: cmp      w8, w28
01a67144: b.ne     #0x1a671dc
01a67148: mov      x0, x24
01a6714c: mov      w1, w26
01a67150: bl       #0x1a609fc ; PairzzlePuzzle.IsHole
01a67154: tbnz     w0, #0, #0x1a671dc
01a67158: cbz      x23, #0x1a67374
01a6715c: ldr      x8, [x23, #0x18]
01a67160: cbz      x8, #0x1a67374
01a67164: ldr      w9, [x8, #0x18]
01a67168: cmp      x26, x9
01a6716c: b.hs     #0x1a67370
01a67170: add      x8, x8, x26
01a67174: ldrb     w8, [x8, #0x20]
01a67178: cbz      w8, #0x1a671dc
01a6717c: cbz      x22, #0x1a67374
01a67180: adrp     x9, #0x21f1000
01a67184: ldr      w10, [x22, #0x1c]
01a67188: ldr      x8, [x22, #0x10]
01a6718c: ldr      x9, [x9, #0x3f0]
01a67190: add      w10, w10, #1
01a67194: ldr      x9, [x9]
01a67198: str      w10, [x22, #0x1c]
01a6719c: cbz      x8, #0x1a67374
01a671a0: ldrsw    x10, [x22, #0x18]
01a671a4: ldr      w11, [x8, #0x18]
01a671a8: cmp      w10, w11
01a671ac: b.hs     #0x1a671c4
01a671b0: add      x8, x8, x10, lsl #2
01a671b4: add      w9, w10, #1
01a671b8: str      w9, [x22, #0x18]
01a671bc: str      w26, [x8, #0x20]
01a671c0: b        #0x1a671dc ; 
01a671c4: ldr      x8, [x9, #0x20]
01a671c8: mov      x0, x22
01a671cc: mov      w1, w26
01a671d0: ldr      x8, [x8, #0xc0]
01a671d4: ldr      x2, [x8, #0x70]
01a671d8: bl       #0x1404854 ; 
01a671dc: ldr      w8, [x27, #0x18]
01a671e0: add      x26, x26, #1
01a671e4: cmp      x26, w8, sxtw
01a671e8: b.lt     #0x1a6712c
01a671ec: adrp     x8, #0x2212000
01a671f0: movi     v0.2d, #0000000000000000
01a671f4: add      x0, sp, #0x30
01a671f8: ldr      x8, [x8, #0x190]
01a671fc: ldr      x1, [x8]
01a67200: stp      q0, q0, [sp, #0x30]
01a67204: str      x1, [sp, #0x30]
01a67208: bl       #0xe54bf4 ; 
01a6720c: adrp     x8, #0x2212000
01a67210: mov      w1, #2
01a67214: ldr      x8, [x8, #0x108]
01a67218: ldr      x0, [x8]
01a6721c: bl       #0xe54cf0 ; 
01a67220: adrp     x24, #0x2212000
01a67224: mov      x23, x0
01a67228: ldr      x24, [x24, #0x60]
01a6722c: ldr      x8, [x24]
01a67230: ldr      w9, [x8, #0xe4]
01a67234: cbnz     w9, #0x1a67240
01a67238: mov      x0, x8
01a6723c: bl       #0xe54d80 ; 
01a67240: adrp     x8, #0x21f9000
01a67244: mov      w1, w21
01a67248: ldr      x8, [x8, #0xc20]
01a6724c: ldr      x0, [x8]
01a67250: add      x8, sp, #0x18
01a67254: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a67258: cbz      x23, #0x1a67374
01a6725c: ldr      w8, [x23, #0x18]
01a67260: cbz      w8, #0x1a67370
01a67264: ldur     q0, [sp, #0x18]
01a67268: ldr      x8, [sp, #0x28]
01a6726c: add      x0, x23, #0x20
01a67270: mov      x1, xzr
01a67274: str      q0, [x23, #0x20]
01a67278: str      x8, [x23, #0x30]
01a6727c: bl       #0xe54bf4 ; 
01a67280: adrp     x8, #0x2212000
01a67284: mov      w1, w20
01a67288: ldr      x8, [x8, #0x140]
01a6728c: ldr      x0, [x8]
01a67290: mov      x8, sp
01a67294: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a67298: ldr      w8, [x23, #0x18]
01a6729c: tst      w8, #0xfffffffe
01a672a0: b.eq     #0x1a67370
01a672a4: ldr      q0, [sp]
01a672a8: ldr      x8, [sp, #0x10]
01a672ac: add      x0, x23, #0x38
01a672b0: mov      x1, xzr
01a672b4: stur     q0, [x23, #0x38]
01a672b8: str      x8, [x23, #0x48]
01a672bc: bl       #0xe54bf4 ; 
01a672c0: add      x20, sp, #0x30
01a672c4: mov      x1, x23
01a672c8: str      x23, [sp, #0x38]
01a672cc: orr      x0, x20, #8
01a672d0: bl       #0xe54bf4 ; 
01a672d4: cbz      x22, #0x1a67374
01a672d8: adrp     x8, #0x2206000
01a672dc: mov      x0, x22
01a672e0: ldr      x8, [x8, #0x218]
01a672e4: ldr      x1, [x8]
01a672e8: bl       #0x1405f58 ; 
01a672ec: mov      x1, x0
01a672f0: str      x0, [sp, #0x40]
01a672f4: add      x0, x20, #0x10
01a672f8: bl       #0xe54bf4 ; 
01a672fc: ldr      x8, [x24]
01a67300: add      x0, x20, #0x18
01a67304: ldr      x8, [x8, #0xb8]
01a67308: ldr      x1, [x8]
01a6730c: str      x1, [sp, #0x48]
01a67310: bl       #0xe54bf4 ; 
01a67314: ldp      q1, q2, [sp, #0x30]
01a67318: adrp     x8, #0x2212000
01a6731c: movi     v0.2d, #0000000000000000
01a67320: add      x1, sp, #0x50
01a67324: mov      x0, x19
01a67328: str      q1, [sp, #0x50]
01a6732c: ldr      x8, [x8, #0x148]
01a67330: str      q2, [sp, #0x60]
01a67334: stp      q0, q0, [x19]
01a67338: ldr      x2, [x8]
01a6733c: str      xzr, [x19, #0x20]
01a67340: bl       #0x14ff434 ; 
01a67344: b        #0x1a67350 ; 
01a67348: str      xzr, [x19, #0x20]
01a6734c: stp      q0, q0, [x19]
01a67350: ldp      x20, x19, [sp, #0xc0]
01a67354: ldp      x22, x21, [sp, #0xb0]
01a67358: ldp      x24, x23, [sp, #0xa0]
01a6735c: ldp      x26, x25, [sp, #0x90]
01a67360: ldp      x28, x27, [sp, #0x80]
01a67364: ldp      x29, x30, [sp, #0x70]
01a67368: add      sp, sp, #0xd0
01a6736c: ret      
01a67370: bl       #0xe54eb4 ; 
01a67374: bl       #0xe54eac ; 