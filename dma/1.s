	@MSPM0L1306
	@编译器ARM-NONE-EABI
	@功能TIMG4触发ADC采样，采集A0和A1，通过DMA把两个32位传输到0X20000100，
	@DMA重复模式，传输长度12个64位数
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
_neicunqingling:
	ldr r0, = 0x20001000
	ldr r2, = 0x20000000
	movs r1, # 0
_neicunqinglingxunhuan:
	subs r0, r0, # 4
	str r1, [r0]
	cmp r0, r2
	bne _neicunqinglingxunhuan






	
__IOMUX_she_zhi:	
@	ldr r0, = 0x40428000

	
__TIMG4:
	@ADC触发源
	ldr r0, = 0x4008c000	@寄存器基址
	ldr r1, = 0x800		@寄存器偏移
	ldr r2, = 0x26000001	
	str r2, [r0, r1]	@开电源

	
	ldr r1, = 0x1008	@CLKSEL
	movs r2, # 0x08
	str r2, [r0, r1]	@时钟选择

	
	ldr r1, = 0x1058	@IMASK
				@GEN_EVENT0
	movs r2, # 0x01
	str r2, [r0, r1]	@触发ADC

	ldr r1, = 0x444		@FPUB_0
	movs r2, # 0x01
	str r2, [r0, r1]	@发布事件1

	
	ldr r1, = 0x1808	@LOAD寄存器
	ldr r2, = 319		@触发频率100KHZ
	str r2, [r0, r1]	@写入定时器最大计数值
	
	ldr r1, = 0x1804	@CTRCTL
	movs r2, # 0x03
	str r2, [r0, r1]	@ 开定时器

	
__dma0:
	ldr r0, = 0x4042a000	@DMA寄存器基址
	ldr r1, = 0x1110	@DMATCTL寄存器偏移地址
	movs r2, # 0x03		@adc0 触发通道选择
	str r2, [r0, r1]


	ldr r1, = 0x1204	@DMASA寄存器偏移地址
	ldr r2, = 0x4055a280	@传输源地址，ADC别名区
	str r2, [r0, r1]

	ldr r1, = 0x1208	@DMADA寄存器偏移地址
	ldr r2, = dianyabiao    @传输目标地址
	str r2, [r0, r1]

	ldr r1, = 0x120c	@DMASZ寄存器偏移地址
	ldr r2, = 12		@传输数量
	str r2, [r0, r1]

	ldr r1, = 0x1200	@DACCTL控制寄存器偏移地址
	ldr r2, = 0x20303302	@0x20301102	
	str r2, [r0, r1]	@开DMA，设置传输模式
	
__adc0:
	ldr r0, = 0x40004000	@寄存器基址
	ldr r1, = 0x800		@寄存器偏移
	ldr r2, = 0x26000001	
	str r2, [r0, r1]	@开电源

	ldr r1, = 0x400		@FSUB_0
	movs r2, # 0x01
	str r2, [r0, r1]	@订阅TIM发布的事件1

	ldr r1, = 0x808		@CLKCFG  ADC时钟配置寄存器
	ldr r2, = 0xa9000002
	str r2, [r0, r1]

	ldr r1, = 0x1088	@IMASK
				@DMA_TRIG
	ldr r2, = 0x200
	str r2, [r0, r1]	@那个通道触发DMA

	ldr r1, = 0x1110	@CLKFREQ 采样时钟范围
	movs r2, # 5
	str r2, [r0, r1]

	ldr r1, = 0x1104  	@CTL1 控制寄存器1
	ldr r2, = 0x30001	@硬件触发
	str r2, [r0, r1]	@序列重复转换

	ldr r1, = 0x1108	@CTL2控制寄存器2
	ldr r2, = 0x3000900	@0x3000900
	str r2, [r0, r1] 	@转换序列选择

	ldr r1, = 0x1184	@MEMCTL 转换存储器控制寄存器
	movs r2, # 0x01		@通道A1
	str r2, [r0, r1]	@
	
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
	.equ zhanding,		0x20000100
	.equ dianyabiao,	0x20000100
	
