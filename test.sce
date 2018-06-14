
exec("loader.sce")
exec("builder.sce")

cd macros/
getd .

test_pass=[]
res=[]


/////////Test case for       1)armcov                  //////////

A = [1 -2.7607 3.8106 -2.6535 0.9238];
y=fscanfMat("txt1_armcov.txt")

arcoeffs = armcov(y,4);
arcoeffs =roundn(arcoeffs,4)

if(arcoeffs==[1 -2.745 3.7762 -2.6201 0.9104])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("armcov Test failed")
end

/////////////////////////////////////////////


/////////Test case for       2) buttord                  //////////

//Wp = 40/500;
//Ws = 150/500;
//
//[n, Wn] = buttord(Wp, Ws, 3, 60);
//Wn=roundn(Wn,7)
//
//if(Wn==0.0800376  &  n==5)
//           test_pass=[test_pass,1]
//else
//	test_pass=[test_pass,0]
//	disp("buttord Test failed")
//end
//
//
///////////////////////////////////////////////
//
//
///////////Test case for       3) cconv                  //////////
//
:
a=[1 2 3]
b=[4 5 6]

o=cconv(a,b,3)

if(o==[31 31 28])
           test_pass=[test_pass,1]
    else
	test_pass=[test_pass,0]
	disp("cconv Test failed")
end
//
//
//
///////////////////////////////////////////////
//
//
///////////Test case for       4) cheby2                  //////////
//
//x=2;
//y=5;
//z=0.7;
//
//[a,b,c]=cheby2(x,y,z,"high");
//a=roundn(a,4);
//b=roundn(b,4);
//c=roundn(c,4);
//
//if(a==[-0.3165-0.9486*%i  -0.3165+0.9486*%i]   & b==[-0.3939+0.5314*%i -0.3939-0.5314*%i])
//    if(c==0.4753)
//           test_pass=[test_pass,1]
//    else
//	test_pass=[test_pass,0]
//	disp("cheby2 Test failed")
//    end
//end
////
///////////////////////////////////////////////
//
//
/////////Test case for       5) cummax                  //////////

v = [8 9 1 10 6 1 3 6 10 10];

M = cummax(v)

if(M==[8 9 9 10 10 10 10 10 10 10])
           test_pass=[test_pass,1]
    else
	test_pass=[test_pass,0]
	disp("cummax Test failed")
end
//
///////////////////////////////////////////////
//
//
///////////Test case for       6) decimate                  //////////
//
//t = 0:.00025:1;
//x = sin(2*%pi*30*t) + sin(2*%pi*60*t);
//
//y = decimate(x,4);
//y=y';        //converting it to column matrix
//y=roundn(y,4);
//M=fscanfMat("txt2_decimate.txt")
//
//if(M==y)
//           test_pass=[test_pass,1]
//    else
//	test_pass=[test_pass,0]
//	disp("decimate Test failed")
//end
//
///////////////////////////////////////////////
//
//
///////////Test case for       7) filtfilt                  //////////
////
//b=1;
//a=2*%i;
//x=[%i -4 0];
//
//y=filtfilt (b,a,x)
//
//if(y==[-0.25*%i 1 0])
//           test_pass=[test_pass,1]
//    else
//	test_pass=[test_pass,0]
//	disp("filtfilt Test failed")
//end
//
///////////////////////////////////////////////
//
//
///////////Test case for       8) filtic                  //////////
//
//b=[%i,1,-%i,5];
//a=[1,2,3*%i];
//y= [0.8*%i,7,9];
//
//zf=filtic(b,a,y)
//zf=roundn(zf,4)
//
//if(zf==[-22.6*%i;2.4;0])
//           test_pass=[test_pass,1]
//    else
//	test_pass=[test_pass,0]
//	disp("filtic Test failed")
//end
//
//
///////////////////////////////////////////////
//
//
///////////Test case for       9)firtype                  //////////
//
b=[9.2762e-05   9.5482e-02   4.0443e-01   4.0443e-01   9.5482e-02   9.2762e-05]

ftype=firtype(b)

if(ftype==2)
           test_pass=[test_pass,1]
    else
	test_pass=[test_pass,0]
	disp("firtype Test failed")
end
//
///////////////////////////////////////////////
//
//
///////////Test case for       10)fwhmjlt                  //////////
//
//t=-50:0.01:50;
//y=(1/(2*sqrt(2*%pi)))*exp(-(t.^2)/8);
//
//z=fwhmjlt(y)
//z=roundn(z,4)
//
//if(z==470.9644)
//           test_pass=[test_pass,1]
//else
//	test_pass=[test_pass,0]
//	disp("fwhmjlt Test failed")
//end
//
///////////////////////////////////////////////
//
//
//
///////////Test case for       11)helperHarmonicDisutortionAmplifier                  ///////
//
//
VmaxPk = 2;
Fi = 2000;
Fs = 44.1e3; 
Tstop = 50e-3;
t = 0:1/Fs:Tstop;
inputVmax = VmaxPk*sin(2*%pi*Fi*t);

outputVmax = helperHarmonicDistortionAmplifier(inputVmax);
outputVmax=outputVmax';
outputVmax=roundn(outputVmax,5);
M=fscanfMat("txt3_helperHDA.txt")

if(M==outputVmax)
           test_pass=[test_pass,1]
else
           test_pass=[test_pass,0]
           disp("helperHarmonicDistortionAmplifier Test failed")
end
//
///////////////////////////////////////////////
//
//
//
///////////Test case for       11)icceps                 //////////
//
xhat=[ 2.2428   -0.0420   -0.0210    0.0045    0.0366    0.0788    0.1386    0.2327    0.4114    0.9249]

icc = icceps(xhat,2);
icc=round(icc)

if(icc==[2 3 4 5 6 7 8 9 10 1])
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("icceps Test failed")
end
//
///////////////////////////////////////////////
//
//
///////////Test case for       12)impz                 //////////
//
//b=[0 1 1];
//a=[1 -3 3 -1];
//n=10;
//
//[x_r,t_r]=impz(b,a,n)
//
//if(t_r==[0 1 2 3 4 5 6 7 8 9] & x_r==[0 1 4 9 16 25 36 49 64 81]) 
//           test_pass=[test_pass,1]
//else
//	test_pass=[test_pass,0]
//	disp("impz Test failed")
//end
//
///////////////////////////////////////////////
//
//
///////////Test case for       13)impzlength                 //////////
//
b = 1;
a = [1 -0.9];

len = impzlength(b,a)

if(len==93) 
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("impzlength Test failed")
end
//
///////////////////////////////////////////////
//
//
//
///////////Test case for       14)intfilt                 //////////
//
R=2;
L=3;

h=intfilt(R,L,'l');

if(h==[-0.0625 0 0.5625 1 0.5625 0 -0.0625]) 
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("intfilt Test failed")
end
//
///////////////////////////////////////////////
//
//
///////////Test case for       15)is2rc                 //////////
//
k = [0.3090 0.9801 0.0031 0.0082 -0.0082];
isin = rc2is(k)
 
k_dash = is2rc(isin)
k_dash = roundn(k_dash,4)

if(k_dash==[0.309 0.9801 0.0031 0.0082 -0.0082]) 
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("is2rc Test failed")
end
//
///////////////////////////////////////////////
//
//
///////////Test case for       16)isallpass                 //////////
//
k = [1/2 1/3 1/4 1/5];
[b,a] = latc2tf(k,'allpass');

flag_isallpass = isallpass(b,a)

if(flag_isallpass==1) 
           test_pass=[test_pass,1]
else
	test_pass=[test_pass,0]
	disp("isallpass Test failed")
end
//
///////////////////////////////////////////////
//
//
res=find(test_pass==0)

if(res~=[])
	disp("One or more tests failed")
	//exit(1)
else
    disp("pass")
	//exit
end
