; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -slp-vectorizer -instcombine -pass-remarks-output=%t | FileCheck %s
; RUN: cat %t | FileCheck -check-prefix=REMARK %s
; RUN: opt < %s -S -aa-pipeline=basic-aa -passes='slp-vectorizer,instcombine' -pass-remarks-output=%t | FileCheck %s
; RUN: cat %t | FileCheck -check-prefix=REMARK %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

; REMARK-LABEL: Function: gather_multiple_use
; REMARK:       Args:
; REMARK-NEXT:    - String: 'Vectorized horizontal reduction with cost '
; REMARK-NEXT:    - Cost: '-7'
;
; REMARK-LABEL: Function: gather_load
; REMARK:       Args:
; REMARK-NEXT:    - String: 'Stores SLP vectorized with cost
; REMARK-NEXT:    - Cost: '-2'

define internal i32 @gather_multiple_use(i32 %a, i32 %b, i32 %c, i32 %d) {
; CHECK-LABEL: @gather_multiple_use(
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> undef, i32 [[C:%.*]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <4 x i32> [[TMP1]], i32 [[A:%.*]], i32 1
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x i32> [[TMP2]], i32 [[B:%.*]], i32 2
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <4 x i32> [[TMP3]], i32 [[D:%.*]], i32 3
; CHECK-NEXT:    [[TMP5:%.*]] = lshr <4 x i32> [[TMP4]], <i32 15, i32 15, i32 15, i32 15>
; CHECK-NEXT:    [[TMP6:%.*]] = and <4 x i32> [[TMP5]], <i32 65537, i32 65537, i32 65537, i32 65537>
; CHECK-NEXT:    [[TMP7:%.*]] = mul nuw <4 x i32> [[TMP6]], <i32 65535, i32 65535, i32 65535, i32 65535>
; CHECK-NEXT:    [[TMP8:%.*]] = add <4 x i32> [[TMP7]], [[TMP4]]
; CHECK-NEXT:    [[TMP9:%.*]] = xor <4 x i32> [[TMP8]], [[TMP7]]
; CHECK-NEXT:    [[TMP10:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP9]])
; CHECK-NEXT:    ret i32 [[TMP10]]
;
  %tmp00 = lshr i32 %a, 15
  %tmp01 = and i32 %tmp00, 65537
  %tmp02 = mul nuw i32 %tmp01, 65535
  %tmp03 = add i32 %tmp02, %a
  %tmp04 = xor i32 %tmp03, %tmp02
  %tmp05 = lshr i32 %c, 15
  %tmp06 = and i32 %tmp05, 65537
  %tmp07 = mul nuw i32 %tmp06, 65535
  %tmp08 = add i32 %tmp07, %c
  %tmp09 = xor i32 %tmp08, %tmp07
  %tmp10 = lshr i32 %b, 15
  %tmp11 = and i32 %tmp10, 65537
  %tmp12 = mul nuw i32 %tmp11, 65535
  %tmp13 = add i32 %tmp12, %b
  %tmp14 = xor i32 %tmp13, %tmp12
  %tmp15 = lshr i32 %d, 15
  %tmp16 = and i32 %tmp15, 65537
  %tmp17 = mul nuw i32 %tmp16, 65535
  %tmp18 = add i32 %tmp17, %d
  %tmp19 = xor i32 %tmp18, %tmp17
  %tmp20 = add i32 %tmp09, %tmp04
  %tmp21 = add i32 %tmp20, %tmp14
  %tmp22 = add i32 %tmp21, %tmp19
  ret i32 %tmp22
}

@data = global [6 x [258 x i8]] zeroinitializer, align 1
define void @gather_load(i16* noalias %ptr) {
; CHECK-LABEL: @gather_load(
; CHECK-NEXT:    [[ARRAYIDX182:%.*]] = getelementptr inbounds i16, i16* [[PTR:%.*]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = call <4 x i8> @llvm.masked.gather.v4i8.v4p0i8(<4 x i8*> <i8* getelementptr inbounds ([6 x [258 x i8]], [6 x [258 x i8]]* @data, i64 0, i64 1, i64 0), i8* getelementptr inbounds ([6 x [258 x i8]], [6 x [258 x i8]]* @data, i64 0, i64 2, i64 1), i8* getelementptr inbounds ([6 x [258 x i8]], [6 x [258 x i8]]* @data, i64 0, i64 3, i64 2), i8* getelementptr inbounds ([6 x [258 x i8]], [6 x [258 x i8]]* @data, i64 0, i64 4, i64 3)>, i32 1, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i8> undef)
; CHECK-NEXT:    [[TMP2:%.*]] = zext <4 x i8> [[TMP1]] to <4 x i16>
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw <4 x i16> [[TMP2]], <i16 10, i16 20, i16 30, i16 40>
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast i16* [[ARRAYIDX182]] to <4 x i16>*
; CHECK-NEXT:    store <4 x i16> [[TMP3]], <4 x i16>* [[TMP4]], align 2
; CHECK-NEXT:    ret void
;
  %arrayidx182 = getelementptr inbounds i16, i16* %ptr, i64 1
  %arrayidx183 = getelementptr inbounds i16, i16* %ptr, i64 2
  %arrayidx184 = getelementptr inbounds i16, i16* %ptr, i64 3
  %arrayidx185 = getelementptr inbounds i16, i16* %ptr, i64 4
  %arrayidx149 = getelementptr inbounds [6 x [258 x i8]], [6 x [258 x i8]]* @data, i64 0, i64 1, i64 0
  %l0 = load i8, i8* %arrayidx149, align 1
  %conv150 = zext i8 %l0 to i16
  %add152 = add i16 10, %conv150
  %arrayidx155 = getelementptr inbounds [6 x [258 x i8]], [6 x [258 x i8]]* @data, i64 0, i64 2, i64 1
  %l1 = load i8, i8* %arrayidx155, align 1
  %conv156 = zext i8 %l1 to i16
  %add158 = add i16 20, %conv156
  %arrayidx161 = getelementptr inbounds [6 x [258 x i8]], [6 x [258 x i8]]* @data, i64 0, i64 3, i64 2
  %l2 = load i8, i8* %arrayidx161, align 1
  %conv162 = zext i8 %l2 to i16
  %add164 = add i16 30, %conv162
  %arrayidx167 = getelementptr inbounds [6 x [258 x i8]], [6 x [258 x i8]]* @data, i64 0, i64 4, i64 3
  %l3 = load i8, i8* %arrayidx167, align 1
  %conv168 = zext i8 %l3 to i16
  %add170 = add i16 40, %conv168
  store i16 %add152, i16* %arrayidx182, align 2
  store i16 %add158, i16* %arrayidx183, align 2
  store i16 %add164, i16* %arrayidx184, align 2
  store i16 %add170, i16* %arrayidx185, align 2
  ret void
}
