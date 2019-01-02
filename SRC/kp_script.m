R = 100e3;
CS = 420e-9;
A = [0 -1/(R*CS); 0 0];
B = [0 ; -1/(R*CS)];

C = [1 0];
D = 0;

[num, den] = ss2tf(A, B, C, D);

pols = [-10+1i -10-1i];
k = acker(A, B, pols);

N=[A B ;C 0]^(-1)*[0;0;1];
Nx=N(1:2)
Nu=N(3)

h=0.05;
[Ad,Bd] = c2d(A,B,h);
polsd = exp(pols*h);
kd = acker(Ad, Bd, polsd);
k1=kd(1)
k2=kd(2)