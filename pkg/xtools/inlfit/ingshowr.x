include	<pkg/inlfit.h>


# ING_SHOW -- Show the values of all the user defined parameters that
# can be changed with colon commands. The output can be any file.

procedure ing_showr (in, file)

pointer	in			# INLFIT pointer
char	file[ARB]		# Output file

int	fd
int	open(), in_geti()
real	in_getr
errchk	open()

begin
	# Open output file.
	if (file[1] == EOS)
	    return
	fd = open (file, APPEND, TEXT_FILE)

	# Print parameters.
	call fprintf (fd, "low_reject    %g\n")
	    call pargr (in_getr (in, INLLOW))
	call fprintf (fd, "high_reject   %g\n")
	    call pargr (in_getr (in, INLHIGH))
	call fprintf (fd, "nreject       %d\n")
	    call pargi (in_geti (in, INLNREJECT))
	call fprintf (fd, "grow          %g\n")
	    call pargr (in_getr (in, INLGROW))
	call fprintf (fd, "tol           %g\n")
	    call pargr (in_getr (in, INLTOLERANCE))
	call fprintf (fd, "maxiter       %d\n")
	    call pargi (in_geti (in, INLMAXITER))
	call fprintf (fd, "\n")

	# Free memory and close file.
	call close (fd)
end
