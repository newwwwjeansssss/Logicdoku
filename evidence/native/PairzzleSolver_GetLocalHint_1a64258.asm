// Data.Pairzzle.PairzzleSolver.GetLocalHint token=0x600105c VA=0x1a64258
01a64258: sub      sp, sp, #0x70
01a6425c: stp      x29, x30, [sp, #0x10]
01a64260: stp      x28, x27, [sp, #0x20]
01a64264: stp      x26, x25, [sp, #0x30]
01a64268: stp      x24, x23, [sp, #0x40]
01a6426c: stp      x22, x21, [sp, #0x50]
01a64270: stp      x20, x19, [sp, #0x60]
01a64274: adrp     x20, #0x2387000
01a64278: mov      x19, x1
01a6427c: mov      x21, x0
01a64280: ldrb     w8, [x20, #0xd22]
01a64284: tbnz     w8, #0, #0x1a642b4
01a64288: adrp     x0, #0x220b000
01a6428c: ldr      x0, [x0, #0x218]
01a64290: bl       #0xe54c48 ; 
01a64294: adrp     x0, #0x220b000
01a64298: ldr      x0, [x0, #0x2f8]
01a6429c: bl       #0xe54c48 ; 
01a642a0: adrp     x0, #0x2212000
01a642a4: ldr      x0, [x0, #0x68]
01a642a8: bl       #0xe54c48 ; 
01a642ac: mov      w8, #1
01a642b0: strb     w8, [x20, #0xd22]
01a642b4: mov      x0, x21
01a642b8: bl       #0x1a6d978 ; PairzzleSolver.CollectEditableEmpties
01a642bc: cbz      x21, #0x1a643d0
01a642c0: mov      x20, x0
01a642c4: mov      x0, x21
01a642c8: bl       #0x1a6128c ; PairzzleBoardState.Clone
01a642cc: cbz      x20, #0x1a643d0
01a642d0: ldr      w8, [x20, #0x18]
01a642d4: cmp      w8, #1
01a642d8: b.lt     #0x1a64374
01a642dc: adrp     x26, #0x220b000
01a642e0: adrp     x25, #0x2212000
01a642e4: mov      x21, x0
01a642e8: ldr      x26, [x26, #0x2f8]
01a642ec: ldr      x25, [x25, #0x68]
01a642f0: mov      w22, wzr
01a642f4: mov      w27, #1
01a642f8: ldr      x2, [x26]
01a642fc: mov      x0, x20
01a64300: mov      w1, w22
01a64304: bl       #0x140455c ; 
01a64308: cbz      x21, #0x1a643d0
01a6430c: mov      w23, w0
01a64310: mov      x28, xzr
01a64314: mov      w8, #1
01a64318: tst      w8, #1
01a6431c: mov      x0, x21
01a64320: mov      w1, w23
01a64324: cinc     w2, w27, eq
01a64328: mov      w29, w8
01a6432c: bl       #0x1a60bec ; PairzzleBoardState.Set
01a64330: mov      x0, x19
01a64334: mov      x1, x21
01a64338: mov      w2, w23
01a6433c: bl       #0x1a6dabc ; PairzzleSolver.CausesOwnViolation
01a64340: mov      w24, w0
01a64344: mov      x0, x21
01a64348: mov      w1, w23
01a6434c: mov      w2, wzr
01a64350: bl       #0x1a60bec ; PairzzleBoardState.Set
01a64354: tbnz     w24, #0, #0x1a64380
01a64358: mov      w8, wzr
01a6435c: mov      x28, #0x100000000
01a64360: tbnz     w29, #0, #0x1a64318
01a64364: ldr      w8, [x20, #0x18]
01a64368: add      w22, w22, #1
01a6436c: cmp      w22, w8
01a64370: b.lt     #0x1a642f8
01a64374: str      wzr, [sp, #8]
01a64378: str      xzr, [sp]
01a6437c: b        #0x1a643a8 ; 
01a64380: tst      w29, #1
01a64384: mov      x8, #0x200000000
01a64388: ldr      x2, [x25]
01a6438c: csel     x8, x8, x28, ne
01a64390: mov      w9, w23
01a64394: mov      x0, sp
01a64398: orr      x1, x8, x9
01a6439c: str      wzr, [sp, #8]
01a643a0: str      xzr, [sp]
01a643a4: bl       #0x14fefd8 ; 
01a643a8: ldp      x20, x19, [sp, #0x60]
01a643ac: ldr      x0, [sp]
01a643b0: ldp      x22, x21, [sp, #0x50]
01a643b4: ldr      w1, [sp, #8]
01a643b8: ldp      x24, x23, [sp, #0x40]
01a643bc: ldp      x26, x25, [sp, #0x30]
01a643c0: ldp      x28, x27, [sp, #0x20]
01a643c4: ldp      x29, x30, [sp, #0x10]
01a643c8: add      sp, sp, #0x70
01a643cc: ret      
01a643d0: bl       #0xe54eac ; 