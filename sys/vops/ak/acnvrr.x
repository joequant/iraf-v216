# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# ACNVR -- Vector convolution with a real kernel.  The output vector is equal
# to the sum of its initial value and the convolution of the input vector with
# the kernel.  This routine assumes boundary extension on the input vector has
# been provided.
#
# Example: npix=10, kpix=5, 2 pixels out of bounds on either end.
# in[1] corresponds to x = -1
#
#	-1  0  1  2  3  4  5  6  7  8  9 10 11 12	(x coord)
#	 1  2  3  4  5
#	    1  2  3  4  5
#			...
#				    1  2  3  4  5
#
# See also acnv_, if the kernel is the same datatype as the data vectors.

procedure acnvrr (in, out, npix, kernel, knpix)

real	in[npix+knpix-1]	# input vector, including boundary pixels
real	out[ARB]		# output vector
int	npix			# length of output vector
real	kernel[knpix]		# convolution kernel, always type real
int	knpix			# size of convolution kernel

int	i, j
real	sum, k1, k2, k3, k4, k5

begin
	switch (knpix) {
	case 3:
	    k1 = kernel[1]
	    k2 = kernel[2]
	    k3 = kernel[3]
	    do i = 1, npix
	        out[i] = out[i] + k1 * in[i] + k2 * in[i+1] + k3 * in[i+2]
	case 5:
	    k1 = kernel[1]
	    k2 = kernel[2]
	    k3 = kernel[3]
	    k4 = kernel[4]
	    k5 = kernel[5]
	    do i = 1, npix
	        out[i] = out[i] + k1 * in[i] + k2 * in[i+1] + k3 * in[i+2] +
		    k4 * in[i+3] + k5 * in[i+4]
	default:
	    do i = 1, npix {
	        sum = out[i]
	        do j = 1, knpix
		    sum = sum + (kernel[j] * in[i+j-1])
	        out[i] = sum
	    }
	}
end
