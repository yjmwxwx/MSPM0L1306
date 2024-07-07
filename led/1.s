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
	movs r2, #  0x81
	str r2, [r0, r1]

__GPIO_she_zhi:	
	ldr r0, = 0x400a0000
	ldr r1, = 0x800		@寄存器偏移
	ldr r2, = 0x26000001	
	str r2, [r0, r1]	@开电源
	
	ldr r1, = 0x12c0	@寄存器偏移
	ldr r2, = 0x2000	@pa13
	str r2, [r0, r1]	@使能输出


__led_kaiguan:			@LED开关
	ldr r1, = 0x120c
	ldr r2, = 0x100		@开
	movs r3, # 0		@关
__led_kaiguan_xunhuan:		@LED开关循环
	str r2, [r0, r1]	@LED开
	ldr r4, = 0x7fffff	@延时时间
__led_kai_yanshi:		@LED开延时
	subs r4, r4, # 1	@延时间减1
	bne __led_kai_yanshi	@不等于0循环
	str r3, [r0,  r1]	@LED关
	ldr r4, = 0x7fffff	@延时时间
__led_guan_yanshi:		@LED关延时
	subs r4, r4, # 1	@延时时间减1
	bne __led_guan_yanshi	@不等于0循环
	b __led_kaiguan_xunhuan	@跳到LED开关循环

_nmi:
_Hard_Fault:
_svc_handler:
_pendsv_handler:	
_systickzhongduan:
aaa:
	bx lr
	
	.section .data
	.equ zhanding,	0x20000100
	
