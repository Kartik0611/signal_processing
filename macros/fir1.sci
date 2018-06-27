//function b = fir1(n, w, varargin)
//    
// funcprot(0);
//    if argn(2) < 2 | argn(2) > 5
//        error("Wrong Number of input arguments");
//    end
//    
//  // Assign default window, filter type and scale.
//  // If single band edge, the first band defaults to a pass band to
//  // create a lowpass filter.  If multiple band edges, the first band
//  // defaults to a stop band so that the two band case defaults to a
//  // band pass filter.  Ick.
//  
//  window_name  = [];
//  scale   = 1;
//  ftype   = (length(w)==1);
//  
//  
//    for i=1:length(varargin)
//        arg = varargin(i);
//        if type((arg)==10)
//             arg=convstr(arg,"l");
//        end
//        if isempty(arg) 
//            continue;
//        end
//        
//      select arg
//            case 'low' then ftype  = 1; case 'stop' then ftype  = 1; case 'dc-1' then ftype  = 1; 
//            case 'high' then ftype  = 0; case 'pass' then ftype  = 0; case 'bandpass' then ftype  = 0; case 'dc-0' then ftype  = 0;
//            case 'scale' then scale=1;
//            case 'noscale' then scale=0;
//            else window_name=arg;
//      end
//     end
//    
//// build response function according to fir2 requirements
//  bands = length(w)+1;
//  f = zeros(1,2*bands);
//  f(2*bands)=1;
//  f(2:2:2*bands-1) = w;
//  f(3:2:2*bands-1) = w;
//  m = zeros(1,2*bands);
//  m(1:2:2*bands) = modulo([1:bands]-(1-ftype),2);
//  m(2:2:2*bands) = m(1:2:2*bands);
//    
//   
//   
//   
////Increment the order if the final band is a pass band.  Something
//// about having a nyquist frequency of zero causing problems.
////
//  if rem(n,2)==1 && m(2*bands)==1,
//    warning("n must be even for highpass and bandstop filters. Incrementing.");
//    n = n+1;
//    if isvector(window_name) && isreal(window_name) && !ischar(window_name)
//// Extend the window using interpolation
//      M = length(window_name);
//      if M == 1,
//        window_name = [window_name; window_name];
//      elseif M < 4
//        window_name = interp1(linspace(0,1,M),window_name,linspace(0,1,M+1),'linear');
//      else
//        window_name = interp1(linspace(0,1,M),window_name,linspace(0,1,M+1),'spline');
//      end
//    end
//  end
//
//endfunction
//
