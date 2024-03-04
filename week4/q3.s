
main:
	begin
	push	$ra

	la	$a0, numbers
	li	$a1, 10
	jal	max

	move	$a0, $v0
	li	$v0, 1
	syscall

	pop	$ra
	end
	jr	$ra

max:
# $a0 &array
# $a1 length
# $s0 first_element
max__prologue:
	begin
	push	$ra
	push	$s0

max__body:
	lw	$s0, ($a0)	# int first_element = array[0];
	move	$v0, $s0	# return first_element
	beq	$a1, 1, max__epilogue	# if (length == 1) {

	# int max_so_far = max(&array[1], len    gth - 1);
	add	$a0, $a0, 4	# &array[1]
	sub	$a1, $a1, 1
	jal	max		# $v0 = max_so_far

	bgt	$v0, $s0, max__epilogue
	move	$v0, $s0

	

max__epilogue:
	pop	$s0
	pop	$ra
	end

	jr	$ra

	.data
# int numbers[10] = {12, 5, ...}
numbers:	.word 12, 5, 6, 7, 15, 7, -9, 3, 55, 2
