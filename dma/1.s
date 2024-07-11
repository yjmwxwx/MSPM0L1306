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
@	ldr r0, = 0x40428000
__dma:
	ldr r0, = 0x4042a000	@DMA寄存器基址
	ldr r1, = 0x1110	@DMATCTL寄存器偏移地址
	movs r2, # 0x03		@adc0 触发通道选择
	str r2, [r0, r1]


	ldr r1, = 0x1204	@DMASA寄存器偏移地址
	ldr r2, = 0x4055a280	@传输源地址，ADC别名区
	str r2, [r0, r1]

	ldr r1, = 0x1208	@DMADA寄存器偏移地址
	ldr r2, = 0x20000200	 @传输目标地址
	str r2, [r0, r1]

	ldr r1, = 0x120c	@DMASZ寄存器偏移地址
	ldr r2, = 12		@传输数量
	str r2, [r0, r1]

	ldr r1, = 0x1200	@DACCTL控制寄存器偏移地址
	ldr r2, = 0x20301102	@0x20301102	
	str r2, [r0, r1]	@开DMA，设置传输模式
	
__adc0:
	ldr r0, = 0x40004000	@寄存器基址
	ldr r1, = 0x800		@寄存器偏移
	ldr r2, = 0x26000001	
	str r2, [r0, r1]	@开电源

	ldr r1, = 0x808		@CLKCFG  ADC时钟配置寄存器
	ldr r2, = 0xa9000002
	str r2, [r0, r1]

	ldr r1, = 0x1088	@IMASK
				@DMA_TRIG
	ldr r2, = 0x100
	str r2, [r0, r1]	@触发DMA相关

	ldr r1, = 0x1110	@CLKFREQ 采样时钟范围
	movs r2, # 5
	str r2, [r0, r1]

	ldr r1, = 0x1104  	@CTL1 控制寄存器1
	ldr r2, = 0x30100
	str r2, [r0, r1]	@序列重复转换

	ldr r1, = 0x1108	@CTL2控制寄存器2
	ldr r2, = 0x3000900
	str r2, [r0, r1] 	@转换序列选择

	ldr r1, = 0x1184
	movs r2, # 0x01
	str r2, [r0, r1]
	
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
	
