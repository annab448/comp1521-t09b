	# $t0	i
	
	.text
N_SIZE = 10

main:

add42_loop_init:
	li	$t0, 0	# i = 0;
add42_loop_cond:
	bge	$t0, N_SIZE, add42_loop_end	# while (i < N_SIZE) {
	
	# get numbers[i]
	la	$t1, numbers	# $t1 = &numbers[0]
	mul	$t2, $t0, 4	# $t2 = offset = i*4
	add	$t3, $t1, $t2	#$t3 = &numbers[i]

	lw	$t4, ($t3)	#t4 = numbers[i]

	
	bge	$t4, $zero, add42_loop_step	# if (numbers[i] < 0) {

	# numbers[i] += 42
	add	$t4, $t4, 42	# calc numbers[i] + 42
	sw	$t4, ($t3)	# store new value in array

add42_loop_step:
	add	$t0, $t0, 1	# i++
	b	add42_loop_cond

add42_loop_end:
	jr	$ra

	.data
numbers:
	.word	0, 1, 2, -3, 4, -5, 6, -7, 8, 9   # int numbers[10] = {0, 1, 2, -3, 4, -5, 6, -7, 8, 9};
