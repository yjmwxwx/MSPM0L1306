	@MSPM0L1306
	@编译器ARM-NONE-EABI

	.thumb
	.syntax unified
	.section .text
vectors:
	.word zhanding
	.word kaishi + 1
	.word _nmi	+1
	.word _Hard_Fault +1
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word _svc_handler +1
	.word 0
	.word 0
	.word _pendsv_handler +1
	.word _systickzhongduan +1  @ 15

	
kaishi:
__IOMUX_she_zhi:	
	ldr r0, = 0x40428000
	movs r1, # 0x38		@pa13
	ldr r2, =   0x83	@PA13 TIMG0_C1
	str r2, [r0, r1]

	
__TIMG0:
	ldr r0, = 0x40084000	@寄存器基址
	ldr r1, = 0x800		@寄存器偏移
	ldr r2, = 0x26000001	
	str r2, [r0, r1]	@开电源

	
	ldr r1, = 0x1008	@CLKSEL
	movs r2, # 0x08
	str r2, [r0, r1]	@时钟选择

	
	ldr r1, = 0x1100	@CCPD
	movs r2, # 0x02
	str r2, [r0, r1]	@c1输出

	
	ldr r1, = 0x1808	@LOAD寄存器
	ldr r2, = 0xffff
	str r2, [r0, r1]	@写入定时器最大计数值

	ldr r1, = 0x1814	@CC_01[y]
	ldr r2, = 0x7fff	@PWM占空比
	str r2, [r0, r1]	@比较寄存器


	ldr r1, = 0x1874	@CCACT
	ldr r2, = 0x50		@CDACT=1,LACT=2
       str r2, [r0, r1]		@设置比较模式


	
	ldr r1, = 0x1804	@CTRCTL
	movs r2, # 0x03
	str r2, [r0, r1]	@ 开定时器
	
ting:

	b ting
	
_nmi:
_Hard_Fault:
_svc_handler:
_pendsv_handler:	
_systickzhongduan:
aaa:
	bx lr
	
	.section .data
	.equ zhanding,	0x20000100
	
