// Data.Pairzzle.PairzzleHintReasons.Fallback token=0x6000fe5 VA=0x1a66424
01a66424: sub      sp, sp, #0x80
01a66428: str      x30, [sp, #0x40]
01a6642c: stp      x24, x23, [sp, #0x50]
01a66430: stp      x22, x21, [sp, #0x60]
01a66434: stp      x20, x19, [sp, #0x70]
01a66438: adrp     x24, #0x2387000
01a6643c: adrp     x23, #0x2212000
01a66440: adrp     x21, #0x2212000
01a66444: adrp     x22, #0x2212000
01a66448: ldr      x23, [x23, #0x138]
01a6644c: ldrb     w9, [x24, #0xcc9]
01a66450: ldr      x21, [x21, #0x108]
01a66454: ldr      x22, [x22, #0x60]
01a66458: mov      w20, w0
01a6645c: mov      x19, x8
01a66460: tbnz     w9, #0, #0x1a664a8
01a66464: adrp     x0, #0x21f0000
01a66468: ldr      x0, [x0, #0x470]
01a6646c: bl       #0xe54c48 ; 
01a66470: adrp     x0, #0x2212000
01a66474: ldr      x0, [x0, #0x108]
01a66478: bl       #0xe54c48 ; 
01a6647c: adrp     x0, #0x2212000
01a66480: ldr      x0, [x0, #0x60]
01a66484: bl       #0xe54c48 ; 
01a66488: adrp     x0, #0x2212000
01a6648c: ldr      x0, [x0, #0x138]
01a66490: bl       #0xe54c48 ; 
01a66494: adrp     x0, #0x2212000
01a66498: ldr      x0, [x0, #0x140]
01a6649c: bl       #0xe54c48 ; 
01a664a0: mov      w8, #1
01a664a4: strb     w8, [x24, #0xcc9]
01a664a8: movi     v0.2d, #0000000000000000
01a664ac: ldr      x1, [x23]
01a664b0: adrp     x23, #0x2212000
01a664b4: add      x0, sp, #0x20
01a664b8: str      q0, [sp, #0x20]
01a664bc: ldr      x23, [x23, #0x140]
01a664c0: str      q0, [sp, #0x30]
01a664c4: str      x1, [sp, #0x20]
01a664c8: bl       #0xe54bf4 ; 
01a664cc: ldr      x0, [x21]
01a664d0: mov      w1, #1
01a664d4: bl       #0xe54cf0 ; 
01a664d8: ldr      x8, [x22]
01a664dc: mov      x21, x0
01a664e0: ldr      w9, [x8, #0xe4]
01a664e4: cbnz     w9, #0x1a664f0
01a664e8: mov      x0, x8
01a664ec: bl       #0xe54d80 ; 
01a664f0: ldr      x0, [x23]
01a664f4: add      x8, sp, #8
01a664f8: mov      w1, w20
01a664fc: bl       #0x1a67bc0 ; PairzzleHintReasons.SymbolArg
01a66500: cbz      x21, #0x1a66598
01a66504: ldr      w8, [x21, #0x18]
01a66508: cbz      w8, #0x1a6659c
01a6650c: ldur     q0, [sp, #8]
01a66510: ldr      x8, [sp, #0x18]
01a66514: adrp     x20, #0x21f0000
01a66518: ldr      x20, [x20, #0x470]
01a6651c: add      x0, x21, #0x20
01a66520: mov      x1, xzr
01a66524: str      q0, [x21, #0x20]
01a66528: str      x8, [x21, #0x30]
01a6652c: bl       #0xe54bf4 ; 
01a66530: add      x23, sp, #0x20
01a66534: mov      x1, x21
01a66538: str      x21, [sp, #0x28]
01a6653c: orr      x0, x23, #8
01a66540: bl       #0xe54bf4 ; 
01a66544: ldr      x0, [x20]
01a66548: mov      w1, wzr
01a6654c: bl       #0xe54cf0 ; 
01a66550: mov      x1, x0
01a66554: str      x0, [sp, #0x30]
01a66558: add      x0, x23, #0x10
01a6655c: bl       #0xe54bf4 ; 
01a66560: ldr      x8, [x22]
01a66564: add      x0, x23, #0x18
01a66568: ldr      x8, [x8, #0xb8]
01a6656c: ldr      x1, [x8]
01a66570: str      x1, [sp, #0x38]
01a66574: bl       #0xe54bf4 ; 
01a66578: ldp      q0, q1, [sp, #0x20]
01a6657c: ldr      x30, [sp, #0x40]
01a66580: ldp      x22, x21, [sp, #0x60]
01a66584: ldp      x24, x23, [sp, #0x50]
01a66588: stp      q0, q1, [x19]
01a6658c: ldp      x20, x19, [sp, #0x70]
01a66590: add      sp, sp, #0x80
01a66594: ret      
01a66598: bl       #0xe54eac ; 
01a6659c: bl       #0xe54eb4 ; 