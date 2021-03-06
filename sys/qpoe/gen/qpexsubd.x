# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include	<mach.h>
include	"../qpex.h"

# QPEX_SUBLIST -- Extract a sublist spanning the indicated range from a
# larger range list.  The number of ranges extracted is returned as the
# function value.

int procedure qpex_sublistd (x1, x2, xs,xe,nranges,ip, o_xs,o_xe)

double	x1, x2				#I range to be extracted
double	xs[nranges],xe[nranges]		#I input range list
int	nranges				#I nranges in input list
int	ip				#U start position in input list
double	o_xs[ARB],o_xe[ARB]		#O output sublist

double	tol
int	op, i

begin
	    tol = (EPSILOND * 10.0D0)

	# Determine the range containing or immediately following the
	# start point of the range of interest.

	while (x1 < xs[ip] && ip > 1)
	    ip = ip - 1
	while (x1 >= xs[ip])
	    if (x1 <= xe[ip] || ip >= nranges)
		break
	    else
		ip = ip + 1

	# Check for an empty output range list.
	if (xs[ip] > x2)
	    return (0)

	# At least one input range contributes something to the output region.
	# Copy a portion of the input range list to the ouput range list.

	op = 1
	do i = ip, nranges {
	    if (xs[i] <= x1)
		o_xs[op] = LEFTD - tol
	    else
		o_xs[op] = xs[i]

	    if ((xe[i] - x2) >= tol) {
		o_xe[op] = RIGHTD + tol
		op = op + 1
		break
	    } else
		o_xe[op] = xe[i]

	    op = op + 1
	    if (xs[i+1] > x2)
		break
	}

	ip = i
	return (op - 1)
end
