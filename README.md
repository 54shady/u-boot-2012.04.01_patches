u-boot-2012.04.01
=================

uboot 2012.04.01 patch

nand boot support
usage example:
	loady 30000000
	nand erase 0 40000
	nand write 30000000 0 40000

nor flash support
usage example:
	mini2440# flinfo
	mini2440# protect off all

	mini2440# loady 30000000
	mini2440# erase 0 3ffff
	mini2440# cp.b 30000000 0 40000

	mini2440# erase 80000 8ffff
	mini2440# cp.b 30000000 80000 10000
	mini2440# cmp.b 30000000 80000 10000

nand flash support
usage example:
	mini2440# loady 30000000
	mini2440# nand erase 0 40000
	mini2440# nand write 30000000 0 40000

flash kernel example:
	> tftp 30000000 uImage
	> nand erase.part kernel
	> nand write 30000000 60000 $filesize
flash file system example(yaffs2):
	> tftp 30000000 yaffs2_image
	> nand erase.part rootfs
	> nand write.yaffs 30000000 260000 $filesize

bootargs & bootcmd example:
	bootargs=console=ttySAC0,115200 root=/dev/mtdblock3 init=/linuxrc
	bootcmd=nand read 30000000 kernel ; bootm 30000000
