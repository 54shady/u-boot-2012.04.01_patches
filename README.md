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
