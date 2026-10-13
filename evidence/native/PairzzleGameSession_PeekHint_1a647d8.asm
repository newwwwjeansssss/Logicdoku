// Data.Pairzzle.PairzzleGameSession.PeekHint token=0x6000fc5 VA=0x1a647d8
01a647d8: sub      sp, sp, #0x60
01a647dc: stp      x30, x23, [sp, #0x30]
01a647e0: stp      x22, x21, [sp, #0x40]
01a647e4: stp      x20, x19, [sp, #0x50]
01a647e8: adrp     x20, #0x2387000
01a647ec: mov      x19, x0
01a647f0: ldrb     w8, [x20, #0xcb2]
01a647f4: tbnz     w8, #0, #0x1a6483c
01a647f8: adrp     x0, #0x220b000
01a647fc: ldr      x0, [x0, #0x218]
01a64800: bl       #0xe54c48 ; 
01a64804: adrp     x0, #0x2212000
01a64808: ldr      x0, [x0, #0x48]
01a6480c: bl       #0xe54c48 ; 
01a64810: adrp     x0, #0x2212000
01a64814: ldr      x0, [x0, #0x50]
01a64818: bl       #0xe54c48 ; 
01a6481c: adrp     x0, #0x2212000
01a64820: ldr      x0, [x0, #0x58]
01a64824: bl       #0xe54c48 ; 
01a64828: adrp     x0, #0x2212000
01a6482c: ldr      x0, [x0, #0x60]
01a64830: bl       #0xe54c48 ; 
01a64834: mov      w8, #1
01a64838: strb     w8, [x20, #0xcb2]
01a6483c: movi     v0.2d, #0000000000000000
01a64840: ldrb     w8, [x19, #0x6e]
01a64844: mov      x22, xzr
01a64848: str      wzr, [sp, #0x28]
01a6484c: str      xzr, [sp, #0x20]
01a64850: stp      q0, q0, [sp]
01a64854: cbnz     w8, #0x1a648d4
01a64858: ldr      x8, [x19, #0x28]
01a6485c: cbz      x8, #0x1a648d0
01a64860: mov      x0, x19
01a64864: bl       #0x1a63e74 ; PairzzleGameSession.CollectEditableBlanks
01a64868: cbz      x0, #0x1a649a8
01a6486c: ldr      w8, [x0, #0x18]
01a64870: cbz      w8, #0x1a648d0
01a64874: mov      x0, x19
01a64878: bl       #0x1a641e0 ; PairzzleGameSession.BuildReasoningState
01a6487c: ldr      x1, [x19, #0x18]
01a64880: bl       #0x1a64258 ; PairzzleSolver.GetLocalHint
01a64884: tst      x0, #0xff
01a64888: str      x0, [sp, #0x20]
01a6488c: str      w1, [sp, #0x28]
01a64890: b.eq     #0x1a648d0
01a64894: ldr      x8, [x19, #0x20]
01a64898: cbz      x8, #0x1a649a8
01a6489c: adrp     x20, #0x2212000
01a648a0: add      x0, sp, #0x20
01a648a4: ldr      x20, [x20, #0x50]
01a648a8: ldr      x21, [x8, #0x18]
01a648ac: ldr      x1, [x20]
01a648b0: bl       #0x14feff0 ; 
01a648b4: cbz      x21, #0x1a649a8
01a648b8: ldr      w8, [x21, #0x18]
01a648bc: cmp      w0, w8
01a648c0: b.hs     #0x1a649ac
01a648c4: add      x8, x21, w0, sxtw
01a648c8: ldrb     w8, [x8, #0x20]
01a648cc: cbz      w8, #0x1a648ec
01a648d0: mov      x22, xzr
01a648d4: mov      x0, x22
01a648d8: ldp      x20, x19, [sp, #0x50]
01a648dc: ldp      x22, x21, [sp, #0x40]
01a648e0: ldp      x30, x23, [sp, #0x30]
01a648e4: add      sp, sp, #0x60
01a648e8: ret      
01a648ec: ldr      x1, [x20]
01a648f0: add      x0, sp, #0x20
01a648f4: bl       #0x14feff0 ; 
01a648f8: ldr      x8, [x19, #0x28]
01a648fc: cbz      x8, #0x1a649a8
01a64900: ldr      w9, [x8, #0x18]
01a64904: mov      x20, x0
01a64908: cmp      w20, w9
01a6490c: b.hs     #0x1a649ac
01a64910: add      x8, x8, w20, sxtw
01a64914: ldr      x22, [x19, #0x10]
01a64918: mov      x0, x19
01a6491c: ldrb     w21, [x8, #0x20]
01a64920: bl       #0x1a641e0 ; PairzzleGameSession.BuildReasoningState
01a64924: adrp     x8, #0x2212000
01a64928: mov      x23, x0
01a6492c: ldr      x8, [x8, #0x60]
01a64930: ldr      x19, [x19, #0x18]
01a64934: ldr      x8, [x8]
01a64938: ldr      w9, [x8, #0xe4]
01a6493c: cbnz     w9, #0x1a64948
01a64940: mov      x0, x8
01a64944: bl       #0xe54d80 ; 
01a64948: mov      x8, sp
01a6494c: mov      x0, x22
01a64950: mov      x1, x23
01a64954: mov      x2, x19
01a64958: mov      w3, w20
01a6495c: mov      w4, w21
01a64960: bl       #0x1a643d4 ; PairzzleHintReasons.Of
01a64964: adrp     x8, #0x2212000
01a64968: ldr      x8, [x8, #0x58]
01a6496c: ldr      x0, [x8]
01a64970: bl       #0xe54e9c ; 
01a64974: mov      x1, xzr
01a64978: mov      x22, x0
01a6497c: bl       #0x18ca704 ; Object..ctor
01a64980: cbz      x22, #0x1a649a8
01a64984: ldp      q0, q1, [sp]
01a64988: add      x0, x22, #0x18
01a6498c: mov      x1, xzr
01a64990: str      w20, [x22, #0x10]
01a64994: strb     w21, [x22, #0x14]
01a64998: stur     q0, [x22, #0x18]
01a6499c: stur     q1, [x22, #0x28]
01a649a0: bl       #0xe54bf4 ; 
01a649a4: b        #0x1a648d4 ; 
01a649a8: bl       #0xe54eac ; 
01a649ac: bl       #0xe54eb4 ; 