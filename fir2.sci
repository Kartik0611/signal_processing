function b = fir2(n, f, m, grid_n, ramp_n, window_name)
    
 funcprot(0);
    rhs= argn(2);

    if rhs < 3 | rhs > 6
        error("Wrong Number of input arguments");
    end
    disp(window_name)
//verify frequency and magnitude vectors are reasonable

  t = length(f);
  if t<2 | f(1)~=0 | f(t)~=1 | or(diff(f)<0)
    error ("fir2: frequency must be nondecreasing starting from 0 and ending at 1");
  elseif t ~= length(m)
    error ("fir2: frequency and magnitude vectors must be the same length");
//find the grid spacing and ramp width
  elseif (rhs>4 & length(grid_n)>1) | (rhs>5 & (length(grid_n)>1 | length(ramp_n)>1))
    error ("fir2: grid_n and ramp_n must be integers");
  end
  if rhs < 4, grid_n=[]; end
  if rhs < 5, ramp_n=[]; end
  
//find the window parameter, or default to hamming
//
  w=[];
  if length(grid_n)>1 then 
      w=grid_n; grid_n=[]; 
  end
  if length(ramp_n)>1 then
       w=ramp_n; ramp_n=[];
  end
  if rhs < 6 then
       window_name=w; 
  end
  if isempty(window_name) then
       window_out=hamming(n+1); 
  end
  if  type((window_name)==10)
      if(window_name=="bartlett" | window_name=="blackman" | window_name=="blackmanharris"  |...
           window_name=="bohmanwin" | window_name=="boxcar" | window_name=="barthannwin" |...
           window_name=="chebwin"| window_name=="flattopwin" | window_name=="gausswin" |...
           window_name=="hamming" | window_name=="hanning" | window_name=="hann" |...
           window_name=="kaiser" | window_name=="parzenwin" | window_name=="triang")
                 c =evstr (window_name); 
                 window_out=c(n+1); 
      else
          error("Use proper Window name")
      end
  end
  if length(window_out) ~= n+1 then
       error ("fir2: window_name must be of length n+1");
   end
   
//Default grid size is 512... unless n+1 >= 1024
  if isempty (grid_n)
    if n+1 < 1024
      grid_n = 512;
    else
      grid_n = n+1;
    end
  end
  
//ML behavior appears to always round the grid size up to a power of 2
  grid_n = 2 ^ nextpow2 (grid_n);

//Error out if the grid size is not big enough for the window
  if 2*grid_n < n+1
    error ("fir2: grid size must be greater than half the filter order");
  end
  
  if isempty (ramp_n), ramp_n = fix (grid_n / 25); end
  
//Apply ramps to discontinuities
  if (ramp_n > 0)
//remember original frequency points prior to applying ramps
    basef = f(:); basem = m(:);

//separate identical frequencies, but keep the midpoint
    idx = find (diff(f) == 0);
    f(idx) = f(idx) - ramp_n/grid_n/2;
    f(idx+1) = f(idx+1) + ramp_n/grid_n/2;
    basef_idx=basef(idx);
    f = [f(:);basef_idx]';

//make sure the grid points stay monotonic in [0,1]
    f(f<0) = 0;
    f(f>1) = 1;
    f = unique([f(:);basef_idx(:)]');
    
//preserve window shape even though f may have changed
    m = interp1(basef, basem, f);
  end

//interpolate between grid points
  grid = interp1(f,m,linspace(0,1,grid_n+1)');
  
//Transform frequency response into time response and
//center the response about n/2, truncating the excess
  if (modulo(n,2) == 0)
    b = ifft([grid ; grid(grid_n:-1:2)]);
    mid = (n+1)/2;
    b = real ([ b([end-floor(mid)+1:end]) ; b(1:ceil(mid)) ]);
  else
    //Add zeros to interpolate by 2, then pick the odd values below.
    b = ifft([grid ; zeros(grid_n*2,1) ;grid(grid_n:-1:2)]);
    b = 2 * real([ b([end-n+1:2:end]) ; b(2:2:(n+1))]);
  end

endfunction
