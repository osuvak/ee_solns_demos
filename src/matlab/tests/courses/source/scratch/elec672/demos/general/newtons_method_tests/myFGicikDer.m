function m = myFGicikDer(x)

if x == 0
    m = inf;
elseif x > 0
    m = 1 / 2 / sqrt(x);
else
    m = 1 / 2 / sqrt(-x);
end

end
 
