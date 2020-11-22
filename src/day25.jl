

function find_index(i::T, j::T) where T
    (i + j) * (i + j + one(T)) ÷ (one(T) + one(T)) + j
end


function part1()
    x1 = 20151125
    a = 252533
    p = 33554393
    
    (powermod(a, find_index(3009, 3018), p) * x1) % p
end
