global t
global u
global y
global h
t= EntradaSortida.t;
h=mean(t)/1e6;
t=0:h:(3500-1)*h;
u = EntradaSortida.u;
y = EntradaSortida.y;
params=[1 1 1 1 1]
params = fminsearch(@distance,params);