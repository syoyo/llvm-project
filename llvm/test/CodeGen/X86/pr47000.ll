; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --no_x86_scrub_rip
; RUN: llc < %s -mcpu=pentium4 -O0 | FileCheck %s

target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-unknown"

define <4 x half> @doTheTestMod(<4 x half> %0, <4 x half> %1) nounwind {
; CHECK-LABEL: doTheTestMod:
; CHECK:       # %bb.0: # %Entry
; CHECK-NEXT:    pushl %ebp
; CHECK-NEXT:    pushl %ebx
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    subl $124, %esp
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    movw {{[0-9]+}}(%esp), %si
; CHECK-NEXT:    movw {{[0-9]+}}(%esp), %dx
; CHECK-NEXT:    movw {{[0-9]+}}(%esp), %cx
; CHECK-NEXT:    movw {{[0-9]+}}(%esp), %ax
; CHECK-NEXT:    movw %ax, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; CHECK-NEXT:    movw {{[0-9]+}}(%esp), %di
; CHECK-NEXT:    movw {{[0-9]+}}(%esp), %bx
; CHECK-NEXT:    movw {{[0-9]+}}(%esp), %bp
; CHECK-NEXT:    movw {{[0-9]+}}(%esp), %ax
; CHECK-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movw {{[-0-9]+}}(%e{{[sb]}}p), %ax # 2-byte Reload
; CHECK-NEXT:    movw %bp, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movw %bx, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movw %di, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movw %si, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movw %dx, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movw %cx, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movw %ax, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    movl %ecx, (%eax)
; CHECK-NEXT:    calll __gnu_h2f_ieee
; CHECK-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; CHECK-NEXT:    fstpt {{[-0-9]+}}(%e{{[sb]}}p) # 10-byte Folded Spill
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    movl %ecx, (%eax)
; CHECK-NEXT:    calll __gnu_h2f_ieee
; CHECK-NEXT:    fldt {{[-0-9]+}}(%e{{[sb]}}p) # 10-byte Folded Reload
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    fxch %st(1)
; CHECK-NEXT:    fstps 4(%eax)
; CHECK-NEXT:    fstps (%eax)
; CHECK-NEXT:    calll fmodf
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    fstps (%eax)
; CHECK-NEXT:    calll __gnu_f2h_ieee
; CHECK-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; CHECK-NEXT:    movw %ax, {{[-0-9]+}}(%e{{[sb]}}p) # 2-byte Spill
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    movl %ecx, (%eax)
; CHECK-NEXT:    calll __gnu_h2f_ieee
; CHECK-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; CHECK-NEXT:    fstpt {{[-0-9]+}}(%e{{[sb]}}p) # 10-byte Folded Spill
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    movl %ecx, (%eax)
; CHECK-NEXT:    calll __gnu_h2f_ieee
; CHECK-NEXT:    fldt {{[-0-9]+}}(%e{{[sb]}}p) # 10-byte Folded Reload
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    fxch %st(1)
; CHECK-NEXT:    fstps 4(%eax)
; CHECK-NEXT:    fstps (%eax)
; CHECK-NEXT:    calll fmodf
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    fstps (%eax)
; CHECK-NEXT:    calll __gnu_f2h_ieee
; CHECK-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; CHECK-NEXT:    movw %ax, %si
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    movl %ecx, (%eax)
; CHECK-NEXT:    calll __gnu_h2f_ieee
; CHECK-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; CHECK-NEXT:    fstpt {{[-0-9]+}}(%e{{[sb]}}p) # 10-byte Folded Spill
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    movl %ecx, (%eax)
; CHECK-NEXT:    calll __gnu_h2f_ieee
; CHECK-NEXT:    fldt {{[-0-9]+}}(%e{{[sb]}}p) # 10-byte Folded Reload
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    fxch %st(1)
; CHECK-NEXT:    fstps 4(%eax)
; CHECK-NEXT:    fstps (%eax)
; CHECK-NEXT:    calll fmodf
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    fstps (%eax)
; CHECK-NEXT:    calll __gnu_f2h_ieee
; CHECK-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; CHECK-NEXT:    movw %ax, %di
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    movl %ecx, (%eax)
; CHECK-NEXT:    calll __gnu_h2f_ieee
; CHECK-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; CHECK-NEXT:    fstpt {{[-0-9]+}}(%e{{[sb]}}p) # 10-byte Folded Spill
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    movl %ecx, (%eax)
; CHECK-NEXT:    calll __gnu_h2f_ieee
; CHECK-NEXT:    fldt {{[-0-9]+}}(%e{{[sb]}}p) # 10-byte Folded Reload
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    fxch %st(1)
; CHECK-NEXT:    fstps 4(%eax)
; CHECK-NEXT:    fstps (%eax)
; CHECK-NEXT:    calll fmodf
; CHECK-NEXT:    movl %esp, %eax
; CHECK-NEXT:    fstps (%eax)
; CHECK-NEXT:    calll __gnu_f2h_ieee
; CHECK-NEXT:    movw {{[-0-9]+}}(%e{{[sb]}}p), %dx # 2-byte Reload
; CHECK-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; CHECK-NEXT:    movw %ax, %bx
; CHECK-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; CHECK-NEXT:    movw %bx, 6(%ecx)
; CHECK-NEXT:    movw %di, 4(%ecx)
; CHECK-NEXT:    movw %si, 2(%ecx)
; CHECK-NEXT:    movw %dx, (%ecx)
; CHECK-NEXT:    addl $124, %esp
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    popl %edi
; CHECK-NEXT:    popl %ebx
; CHECK-NEXT:    popl %ebp
; CHECK-NEXT:    retl $4
Entry:
  %x = alloca <4 x half>, align 8
  %y = alloca <4 x half>, align 8
  store <4 x half> %0, <4 x half>* %x, align 8
  store <4 x half> %1, <4 x half>* %y, align 8
  %2 = load <4 x half>, <4 x half>* %x, align 8
  %3 = load <4 x half>, <4 x half>* %y, align 8
  %4 = frem <4 x half> %2, %3
  ret <4 x half> %4
}

