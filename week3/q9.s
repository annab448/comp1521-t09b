	# $t0	s
	# $t1	length
	# $t2	*s
	.data
string:
	.asciiz	"...."

	.text
main:
loop_init:
	la	$t0, string	# char *s = &string[0];
	li	$t1, 0		# length = 0

loop_cond:
	lb	$t2, ($t0)	# while (*s != '\0') {
	beq	$t2, '\0', loop_end

	add	$t1, $t1, 1	# length++
	add	$t0, $t0, 1	# s++
	b loop_cond

loop_end:
	jr	$ra	


