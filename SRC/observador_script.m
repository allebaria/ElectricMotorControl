J=0.023902855733356;            
b=2.951998199902568;            
K=1.234414328212990;
R=0.097902611179658;            
L=0.044493972479394;
A=[-b/J K/J; -K/L R/L];
B=[0;1/L];
C=[1,0];
D=0;

Csensor = [1 0];

N=[A B ;C 0]^(-1)*[0;0;1];
Nx=N(1:2);
Nu=N(3);

%Continu
pols = [-100+1i -100-1i];
k = acker(A, B, pols);
k1=k(1);
k2=k(2);
polso = [-300+1i -300-1i];
L=(acker(A',Csensor',polso))';

%Discret
h = 0.00527;
[Ad,Bd] = c2d(A,B,h);
polsd = exp(pols*h);
kd = acker(Ad, Bd, polsd)
k1d=kd(1);
k2d=kd(2);
polsod = exp(polso*h);
Ld=(acker(Ad',Csensor',polsod))';

%Pertorbacio const
[Adp,Bdp] = c2d(A,B,h);
Adp(3,1)=0;
Adp(3,2)=0;
Adp(1,3)=Bdp(1);
Adp(2,3)=Bdp(2);
Adp(3,3)= 1;
Bdp(3)=0;
Cpsensor=[1 0 0];
Ldp=(acker(Adp',Cpsensor',[polsod(1) polsod(2) 0.9]))';

%Pretorbació sinus
P=[0 1; -(69.3387^2) 0];
Pd = c2d(P, [0 ; 0], h);
Adps=Adp;
Bdps=Bdp;
Adps(4,1)=0;
Adps(4,2)=0;
Adps(4,3)=0;
Adps(5,1)=0;
Adps(5,2)=0;
Adps(5,3)=0;
Adps(1,4)=Bdp(1);
Adps(2,4)=Bdp(2);
Adps(3,4)=Bdp(3);
Adps(1,5)=0;
Adps(2,5)=0;
Adps(3,5)=0;
Adps(4,4)=Pd(1,1);
Adps(4,5)=Pd(1,2);
Adps(5,4)=Pd(2,1);
Adps(5,5)=Pd(2,2);
Bdps(4)=0;
Bdps(5)=0;
Cpssensor=[1 0 0 0 0];
Ldps=(acker(Adps',Cpssensor',[polsod(1) polsod(2) 0.9 0.9+0.1i 0.9-0.1i]))';

