function [pl,ql,pr,qr] = bcfun(xl,ul,xr,ur,t)
global h0
hb = h0; %head at outer boundary which is equal to initial head
 % r = 0: no radial flow   
pl = 0; ql = 1;
 % r = Rb: constant head  
 pr = ur - hb;
qr = 0;
end