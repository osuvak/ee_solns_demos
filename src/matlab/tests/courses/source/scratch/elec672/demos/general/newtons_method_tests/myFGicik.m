function m = myFGicik(x)

if x == 0
    m = 0;
elseif x > 0
    m = sqrt(x);
else
    m = -sqrt(-x);
end

end
