%%%%%%%%%%%%%%%%%%%Aconseguir rpm vs volt de la nostra planta
p = polyfit(rpmvoltdades.volt, rpmvoltdades.rpm, 4);
x1 = linspace(0,255);
y1 = polyval(p,x1);
figure(1)
plot(rpmvoltdades.volt,rpmvoltdades.rpm,'x')
hold on
plot(x1,y1)
hold off
%Treure la inversa de la funcio
syms x;
%f(x) = p(1)*x^3 + p(2)*x^2 + p(3)*x + p(4);
f(x) = x*(x*(x*(p(1)) + p(2)) + p(3)) + p(4);

pInv = polyfit(rpmvoltdades.rpm, rpmvoltdades.volt, 4);
fInv(x) = x*(x*(x*(pInv(1)) + pInv(2)) + pInv(3)) + pInv(4);

figure(2)
%Plot rpm desitjat vs rpm real
plot(rpmDesrpmReal.Desitjat, rpmDesrpmReal.Real)


%%%%%%%%%%%%%%%%Estimació del model
[a, b, c, d, e, f, g, h] = fminsearch(@dist,[1 1 1 1 1 1 1 1]);