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
	bkpt # 1
__IOMUX_she_zhi:	
	ldr r0, = 0x40428000

	
__adc0:
	ldr r0, = 0x40004000	@寄存器基址
	ldr r1, = 0x800		@寄存器偏移
	ldr r2, = 0x26000001	
	str r2, [r0, r1]	@开电源

	ldr r1, = 0x808
	ldr r2, = 0xa9000002
	str r2, [r0, r1]


@	ldr r1, = 0x1184	@MEMCTL 转换存储器控制寄存器
@	ldr r2, = 1
@	str r2, [r0, r1]	@通道选择	
	
	ldr r1, = 0x1110	@CLKFREQ 采样时钟范围
	movs r2, # 5
	str r2, [r0, r1]

	ldr r1, = 0x1104  	@CTL1 控制寄存器1
	ldr r2, = 0x30100
	str r2, [r0, r1]	@序列重复转换

	ldr r1, = 0x1108	@CTL2控制寄存器2
	ldr r2, = 0x3000000
	str r2, [r0, r1] 	@转换序列选择
	
	ldr r1, = 0x1100  	@CTL0 控制寄存器 0
	ldr r2, = 0x10001
	str r2, [r0, r1]   
	
	


	
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
	
