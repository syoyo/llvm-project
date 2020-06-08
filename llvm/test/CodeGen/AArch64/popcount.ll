; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-unknown | FileCheck %s

; Function Attrs: nobuiltin nounwind readonly
define i8 @popcount128(i128* nocapture nonnull readonly %0) {
; CHECK-LABEL: popcount128:
; CHECK:       // %bb.0: // %Entry
; CHECK-NEXT:    ldp d1, d0, [x0]
; CHECK-NEXT:    cnt v0.8b, v0.8b
; CHECK-NEXT:    cnt v1.8b, v1.8b
; CHECK-NEXT:    uaddlv h0, v0.8b
; CHECK-NEXT:    uaddlv h1, v1.8b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    fmov w9, s1
; CHECK-NEXT:    add w0, w9, w8
; CHECK-NEXT:    ret
Entry:
  %1 = load i128, i128* %0, align 16
  %2 = tail call i128 @llvm.ctpop.i128(i128 %1)
  %3 = trunc i128 %2 to i8
  ret i8 %3
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i128 @llvm.ctpop.i128(i128)

; Function Attrs: nobuiltin nounwind readonly
define i16 @popcount256(i256* nocapture nonnull readonly %0) {
; CHECK-LABEL: popcount256:
; CHECK:       // %bb.0: // %Entry
; CHECK-NEXT:    ldp d1, d0, [x0, #16]
; CHECK-NEXT:    ldp d3, d2, [x0]
; CHECK-NEXT:    cnt v0.8b, v0.8b
; CHECK-NEXT:    cnt v1.8b, v1.8b
; CHECK-NEXT:    uaddlv h0, v0.8b
; CHECK-NEXT:    cnt v2.8b, v2.8b
; CHECK-NEXT:    uaddlv h1, v1.8b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    cnt v0.8b, v3.8b
; CHECK-NEXT:    uaddlv h2, v2.8b
; CHECK-NEXT:    fmov w9, s1
; CHECK-NEXT:    uaddlv h0, v0.8b
; CHECK-NEXT:    fmov w10, s2
; CHECK-NEXT:    add w8, w9, w8
; CHECK-NEXT:    fmov w9, s0
; CHECK-NEXT:    add w9, w9, w10
; CHECK-NEXT:    add w0, w9, w8
; CHECK-NEXT:    ret
Entry:
  %1 = load i256, i256* %0, align 16
  %2 = tail call i256 @llvm.ctpop.i256(i256 %1)
  %3 = trunc i256 %2 to i16
  ret i16 %3
}

; Function Attrs: nounwind readnone speculatable willreturn
declare i256 @llvm.ctpop.i256(i256)

define <1 x i128> @popcount1x128(<1 x i128> %0) {
; CHECK-LABEL: popcount1x128:
; CHECK:       // %bb.0: // %Entry
; CHECK-NEXT:    fmov d0, x1
; CHECK-NEXT:    fmov d1, x0
; CHECK-NEXT:    cnt v0.8b, v0.8b
; CHECK-NEXT:    cnt v1.8b, v1.8b
; CHECK-NEXT:    uaddlv h0, v0.8b
; CHECK-NEXT:    uaddlv h1, v1.8b
; CHECK-NEXT:    movi v2.2d, #0000000000000000
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    fmov w9, s1
; CHECK-NEXT:    add x0, x9, x8
; CHECK-NEXT:    mov x1, v2.d[1]
; CHECK-NEXT:    ret
Entry:
  %1 = tail call <1 x i128> @llvm.ctpop.v1.i128(<1 x i128> %0)
  ret <1 x i128> %1
}

declare <1 x i128> @llvm.ctpop.v1.i128(<1 x i128>)
