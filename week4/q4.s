
change:
# $a0	nrows
# $a1	ncols
# $a2   &M
# $a3	factor
# $t0	row
# $t1	col
change__prologue:
change__body:

	li	$t0, 0		# row = 0
change__row_cond:
	bge	$t0, $a0, change__row_end	# for (int row = 0; row < nrows; row++)

	li	$t1, 0	# col = 0
change__col_cond:
	bge	$t1, $a1, change__col_end	#  for (int col = 0; col < ncols; col+
	# get M[row][col]
	mul	$t2, $t0, $a1	# $t2 = row offset
	mul	$t2, $t2, 4
	add	$t2, $t2, $a2	# $t2 = &M[row]

	mul	$t3, $t1, 4	# $t3 = col offset
	add	$t2, $t2, $t3	# $t2 = &M[row][col]

	lw	$t3, ($t2)	# $t3 = M[row][col]
	mul	$t3, $t3, $a3	#	* factor
	sw	$t3, ($t2)

	add	$t1, $t1, 1
	b change__col_cond
change__col_end:
	add	$t0, $t0, 1	# row++
	b	change__row_cond

change__row_end:


change__epilogue:
	jr	$ra
