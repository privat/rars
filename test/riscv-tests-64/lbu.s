# 1 "isa/rv64ui/lbu.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/riscv64-linux-gnu/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "isa/rv64ui/lbu.S"
# See LICENSE for license details.
#exit:42

#*****************************************************************************
# lbu.S
#-----------------------------------------------------------------------------

# Test lbu instruction.


# 1 "./riscv_test.h" 1





# 1 "./env/encoding.h" 1
# 7 "./riscv_test.h" 2
# 11 "isa/rv64ui/lbu.S" 2
# 1 "./isa/macros/scalar/test_macros.h" 1






#-----------------------------------------------------------------------
# Helper macros
#-----------------------------------------------------------------------
# 20 "./isa/macros/scalar/test_macros.h"
# We use a macro hack to simpify code generation for various numbers
# of bubble cycles.
# 36 "./isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# RV64UI MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests for instructions with immediate operand
#-----------------------------------------------------------------------
# 86 "./isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------
# 110 "./isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------
# 199 "./isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Test memory instructions
#-----------------------------------------------------------------------
# 307 "./isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Test jump instructions
#-----------------------------------------------------------------------
# 330 "./isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# RV64UF MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests floating-point instructions
#-----------------------------------------------------------------------


# 0f:7fc00000

# 0f:7f800001

# 0d:7ff8000000000000

# 0d:7ff0000000000001
# 594 "./isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Pass and fail code (assumes test num is in gp)
#-----------------------------------------------------------------------
# 606 "./isa/macros/scalar/test_macros.h"
#-----------------------------------------------------------------------
# Test data section
#-----------------------------------------------------------------------
# 12 "isa/rv64ui/lbu.S" 2


.text
 .globl _start
 _start: nop

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_2: la x1, tdat
 lbu x14, 0(x1)
 li x7, 0x00000000000000ff
 li gp, 2
 bne x14, x7, fail

  test_3: la x1, tdat
 lbu x14, 1(x1)
 li x7, 0x0000000000000000
 li gp, 3
 bne x14, x7, fail

  test_4: la x1, tdat
 lbu x14, 2(x1)
 li x7, 0x00000000000000f0
 li gp, 4
 bne x14, x7, fail

  test_5: la x1, tdat
 lbu x14, 3(x1)
 li x7, 0x000000000000000f
 li gp, 5
 bne x14, x7, fail


  # Test with negative offset

  test_6: la x1, tdat4
 lbu x14, -3(x1)
 li x7, 0x00000000000000ff
 li gp, 6
 bne x14, x7, fail

  test_7: la x1, tdat4
 lbu x14, -2(x1)
 li x7, 0x0000000000000000
 li gp, 7
 bne x14, x7, fail

  test_8: la x1, tdat4
 lbu x14, -1(x1)
 li x7, 0x00000000000000f0
 li gp, 8
 bne x14, x7, fail

  test_9: la x1, tdat4
 lbu x14, 0(x1)
 li x7, 0x000000000000000f
 li gp, 9
 bne x14, x7, fail


  # Test with a negative base

  test_10: la x1, tdat
 addi x1, x1, -32
 lbu x5, 32(x1)
 li x7, 0x00000000000000ff
 li gp, 10
 bne x5, x7, fail






  # Test with unaligned base

  test_11: la x1, tdat
 addi x1, x1, -6
 lbu x5, 7(x1)
 li x7, 0x0000000000000000
 li gp, 11
 bne x5, x7, fail






  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_12: li gp, 12
 li x4, 0
 la x1, tdat2
 lbu x14, 1(x1)
 addi x6, x14, 0
 li x7, 0x00000000000000f0
 bne x6, x7, fail

  test_13: li gp, 13
 li x4, 0
 la x1, tdat3
 lbu x14, 1(x1)
 nop
 addi x6, x14, 0
 li x7, 0x000000000000000f
 bne x6, x7, fail

  test_14: li gp, 14
 li x4, 0
 la x1, tdat1
 lbu x14, 1(x1)
 nop
 nop
 addi x6, x14, 0
 li x7, 0x0000000000000000
 bne x6, x7, fail


  test_15: li gp, 15
 li x4, 0
 la x1, tdat2
 lbu x14, 1(x1)
 li x7, 0x00000000000000f0
 bne x14, x7, fail

  test_16: li gp, 16
 li x4, 0
 la x1, tdat3
 nop
 lbu x14, 1(x1)
 li x7, 0x000000000000000f
 bne x14, x7, fail

  test_17: li gp, 17
 li x4, 0
 la x1, tdat1
 nop
 nop
 lbu x14, 1(x1)
 li x7, 0x0000000000000000
 bne x14, x7, fail


  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  test_18: la x5, tdat
 lbu x2, 0(x5)
 li x2, 2
 li x7, 2
 li gp, 18
 bne x2, x7, fail






  test_19: la x5, tdat
 lbu x2, 0(x5)
 nop
 li x2, 2
 li x7, 2
 li gp, 19
 bne x2, x7, fail







  bne x0, gp, pass
 fail: li a0, 0
 li a7, 93
 ecall
 pass: li a0, 42
 li a7, 93
 ecall



  .data
 .data 
 .align 4
 .global begin_signature
 begin_signature:

 

tdat:
tdat1: .byte 0xff
tdat2: .byte 0x00
tdat3: .byte 0xf0
tdat4: .byte 0x0f

.align 4
 .global end_signature
 end_signature:
