#!/bin/bash

#set -x
UBOOT=$PWD
#generate the cscope.files 
#################################################################################
#top level先过滤掉顶层目录中的arch,inclue,nand_spl ...目录里的所有文件
find $UBOOT \
	-path "$UBOOT/arch"  											-prune -o 	\
	-path "$UBOOT/include" 											-prune -o	\
	-path "$UBOOT/nand_spl" 										-prune -o	\
	-path "$UBOOT/onenand_ipl" 										-prune -o	\
	-path "$UBOOT/doc" 												-prune -o	\
	-path "$UBOOT/tools" 											-prune -o	\
	-path "$UBOOT/examples" 										-prune -o	\
	-path "$UBOOT/board" 											-prune -o	\
	-path "$UBOOT/post" 											-prune -o	\
	-name "*.[chsS]" -print > $UBOOT/cscope.files
#################################################################################

#################################################################################
#second level 对第一次过滤掉的目录一个一个找出需要的文件
#arch/arm/cpu/arm920t/*
find_dir="$UBOOT/arch/arm/cpu/arm920t"
find $find_dir \
	-path "$find_dir/a320"  									-prune -o 	\
	-path "$find_dir/at91" 										-prune -o	\
	-path "$find_dir/ep93xx" 									-prune -o	\
	-path "$find_dir/imx" 										-prune -o	\
	-path "$find_dir/ks8695" 									-prune -o	\
	-name "*.[chsS]" -print >> $UBOOT/cscope.files

#arch/arm/lib/*
find_dir="$UBOOT/arch/arm/lib"
find $find_dir -name "*.[chsS]" -print >> $UBOOT/cscope.files

#arch/arm/include/asm/arch-s3c24x0/*
find_dir="$UBOOT/arch/arm/include/asm/arch-s3c24x0"
find $find_dir -name "*.[chsS]" -print >> $UBOOT/cscope.files

#arch/arm/include/asm/*.h
find_dir="$UBOOT/arch/arm/include/asm"
find $find_dir -maxdepth 1 -name "*.[chsS]" -print >> $UBOOT/cscope.files

#board
#find board/samsung/mini2440
find_dir="$UBOOT/board/samsung"
find $find_dir \
	-path "$find_dir/goni"  									-prune -o 	\
	-path "$find_dir/origen" 									-prune -o	\
	-path "$find_dir/smdk5250" 								-prune -o	\
	-path "$find_dir/smdkc100" 								-prune -o	\
	-path "$find_dir/smdkv310" 								-prune -o	\
	-path "$find_dir/smdk2410" 								-prune -o	\
	-path "$find_dir/smdk6400" 								-prune -o	\
	-path "$find_dir/trats" 									-prune -o	\
	-path "$find_dir/universal_c210" 							-prune -o	\
	-name "*.[chsS]" -print >> $UBOOT/cscope.files

#include
#find include/* expect configs/*
find_dir="$UBOOT/include"
find $find_dir \
	-path "$find_dir/configs"  									-prune -o 	\
	-name "*.[chsS]" -print >> $UBOOT/cscope.files

#find include/configs/mini2440.h
find_dir="$UBOOT/include/configs"
find $find_dir -name mini2440.h -print >> $UBOOT/cscope.files
#################################################################################
cscope -bkq -i $UBOOT/cscope.files

#generate the cppcomplete 
ctags -n -f tags --fields=+ai --C++-types=+p * -L $UBOOT/cscope.files
#Try setting the $CSCOPE_DB environment variable to point to a Cscope database you create, so you won't al#ways need to launch Vim in the same directory as the database.
export CSCOPE_DB=$UBOOT/cscope.out
export CSCOPE_DB 
