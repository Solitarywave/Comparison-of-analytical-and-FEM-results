function z = besselzero(n,m,kind)

z = zeros(m,1);

for k = 1:m

    if kind==1
        x0 = (k+n/2-0.25)*pi;
        z(k) = fzero(@(x)besselj(n,x),x0);
    else
        x0 = (k+n/2+0.25)*pi;
        z(k) = fzero(@(x)bessely(n,x),x0);
    end

end