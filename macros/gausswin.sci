function w = gausswin (m, a)
//This function returns the filter coefficients of a Gaussian window.
//Calling Sequence
//w = gausswin (m)
//w = gausswin (m, a)
//Parameters 
//m: positive integer value
//a: 
//w: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Gaussian window of length m supplied as input, to the output vector w.
//The second parameter is the width measured in sample rate/number of samples and should be f for time domain and 1/f for frequency domain. The width is inversely proportional to a.
//Examples
//gausswin(3)
//ans  =
//    0.2493522  
//    1.         
//    0.2493522  
 
funcprot(0);
[nargout,nargin]=argn();

  if (nargin < 1 | nargin > 2)
    error("wrong no. of input arguments");
  elseif (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("gausswin: M must be a positive integer");
  elseif (nargin == 1)
    a = 2.5;
  end

  w = exp ( -0.5 * ( a/m * [ -(m-1) : 2 : m-1 ]' ) .^ 2 );

endfunction
