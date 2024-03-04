FLAG_ROWS=6
FLAG_COLS=12

# $t0 row
# $t1 col

main:
	li	$t0, 0		# 
main__row_cond:
	bge	$t0, FLAG_ROWS, main__row_end

	li	$t1, 0		# col = 0	
main__col_cond:
	bge	$t1, FLAG_COLS, main__col_end

	# printf("%c", flag[row][col]);
	# flag[row][col]
	la	$t2, flag	# $t2 = &flag
	mul	$t3, $t0, FLAG_COLS	# $t3 = row offset
	add	$t2, $t2, $t3		# $t2 = &array[i]

	add	$t2, $t2, $t1		# $t2 = &array[row][col]

	lb	$t3, ($t2)		# $t3 = array[row][col]

	li	$v0, 11
	move	$a0, $t3
	syscall
	
	add	$t1, $t1, 1	# col++
	b	main__col_cond
main__col_end:

	li	$v0, 11		# print('\n'_
	li	$a0, '\n'
	syscall

	add	$t0, $t0, 1
	b	main__row_cond
main__row_end:
	jr	$ra

.data
# This label inside the data region refers to the bytes of the flag.
# Note that even thought the bytes are listed on separate lines,
# they are actually stored as a single contiguous chunk or 'string' in memory.
flag:
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
