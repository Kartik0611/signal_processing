//function [n, Wc] = buttord(Wp, Ws, Rp, Rs)
///This function computes the minimum filter order of a Butterworth filter with the desired response characteristics. 
//Calling Sequence
//n = buttord(Wp, Ws, Rp, Rs)
//[n, Wc] = buttord(Wp, Ws, Rp, Rs)
//Parameters 
//Wp: scalar or vector of length 2
//Ws: scalar or vector of length 2, elements must be in the range [0,1]
//Rp: real or complex value
//Rs: real or complex value
//Description
//This is an Octave function.
//This function computes the minimum filter order of a Butterworth filter with the desired response characteristics. 
//The filter frequency band edges are specified by the passband frequency wp and stopband frequency ws.
//Frequencies are normalized to the Nyquist frequency in the range [0,1]. 
//Rp is measured in decibels and is the allowable passband ripple, and Rs is also in decibels and is the minimum attenuation in the stop band.
//If ws>wp, the filter is a low pass filter. If wp>ws, the filter is a high pass filter.
//If wp and ws are vectors of length 2, then the passband interval is defined by wp the stopband interval is defined by ws. 
//If wp is contained within the lower and upper limits of ws, the filter is a band-pass filter. If ws is contained within the lower and upper limits of wp the filter is a band-stop or band-reject filter.
//Examples
//Wp = 40/500
//Ws = 150/500
//[n, Wn] = buttord(Wp, Ws, 3, 60)
//n =  5
//Wn =  0.080038
//


//********************************************************************************************************
//--------------------------------Using callOvctave--------------------------------------------
//********************************************************************************************************

//rhs = argn(2)
//lhs = argn(1)
//if(rhs~=4)
//error("Wrong number of input arguments.")
//end
//
//	select(lhs)
//	case 1 then
//	n = callOctave(Wp,Ws,Rp,Rs)                     // Here it is not mentioned which octave function is to be used.
//           n = callOctave('buttord",Wp,Ws,Rp,Rs)        // For this function, "buttord" should be used.
//	case 2 then
//	[n,Wc] = callOctave(Wp,Ws,Rp,Rs)              // Here it is not mentioned which octave function is to be used.
//           [n,Wc] = callOctave('buttord",Wp,Ws,Rp,Rs)        // For this function, "buttord" should be used.
//	end
//endfunction


//********************************************************************************************************
//--------------------------------Using pure Scilab--------------------------------------------
//********************************************************************************************************


function [n, Wc] = buttord(Wp, Ws, Rp, Rs)

[nargout,nargin]=argn();

  if (nargin ~= 4)
    error("Wrong Number of input arguments");
//  else
//    validate_filter_bands ("buttord", Wp, Ws);
  end

  if (length (Wp) == 2)
    warning ("buttord: seems to overdesign bandpass and bandreject filters");
  end


T = 2;

  // if high pass, reverse the sense of the test
  stop = find(Wp > Ws);
  Wp(stop) = 1-Wp(stop); // stop will be at most length 1, so no need to
  Ws(stop) = 1-Ws(stop); // subtract from ones(1,length(stop))

  // warp the target frequencies according to the bilinear transform
  Ws = (2/T)*tan(%pi*Ws./T);
  Wp = (2/T)*tan(%pi*Wp./T);

  // compute minimum n which satisfies all band edge conditions
  // the factor 1/length(Wp) is an artificial correction for the
  // band pass/stop case, which otherwise significantly overdesigns.
  qs = log(10^(Rs/10) - 1);
  qp = log(10^(Rp/10) - 1);
  n = ceil(max(0.5*(qs - qp)./log(Ws./Wp))/length(Wp));

  // compute -3dB cutoff given Wp, Rp and n
  Wc = exp(log(Wp) - qp/2/n);

  // unwarp the returned frequency
  Wc = atan(T/2*Wc)*T/%pi;

  // if high pass, reverse the sense of the test
  Wc(stop) = 1-Wc(stop);

endfunction



































//function validate_filter_bands (func, wp, ws)
//
//  if (nargin ~= 3)
//    error("Wrong Number of input arguments");
//  elseif (~ (type (func)==10))
//    error ("validate_filter_bands: FUNC must be a string");
//  elseif (~ (isvector (wp) & isvector (ws) & (length (wp) == length (ws))))
//    error ([func ": WP and WS must both be scalars or vectors of length 2"]);
//  elseif (~ ((length (wp) == 1) | (length (wp) == 2)))
//    error ([func ": WP and WS must both be scalars or vectors of length 2"]);
//  elseif (~ (isreal (wp) & all (wp >= 0) & all (wp <= 1)))
//    error ([func ": all elements of WP must be in the range [0,1]"]);
//  elseif (~ (isreal (ws) & all (ws >= 0) & all (ws <= 1)))
//    error ([func ": all elements of WS must be in the range [0,1]"]);
//  elseif ((length (wp) == 2) & (wp(2) <= wp(1)))
//    error ([func ": WP(1) must be less than WP(2)"])
//  elseif ((length (ws) == 2) & (ws(2) <= ws(1)))
//    error ([func ": WS(1) must be less than WS(2)"])
//  elseif ((length (wp) == 2) & (all (wp > ws) | all (ws > wp)))
//    error ([func ": WP must be contained by WS or WS must be contained by WP"]);
//  end
//
//endfunction
//
