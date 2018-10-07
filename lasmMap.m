% 2D-LASM
function [xout,yout]=lasmMap(xin,yin,mu)
xout=sin(pi*mu*(yin+3)*xin*(1-xin));
yout=sin(pi*mu*(xin+3)*yin*(1-yin));
end