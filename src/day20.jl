using Base.Iterators
using Primes


input = 29000000


function divisors(n)
    n == 1 && return 1
    
    factors = factor(n)
    
    (prod((x.first for x in factors).^y) for y in product((0 : x.second for x in factors)...))
end


function packages(housenr)
    10 * sum(divisors(housenr))
end


function part1()
    first(house for house in countfrom(1) if packages(house) >= input)
end


function packages2(housenr)
    sum(x for x in divisors(housenr) if x >= housenr ÷ 50) * 11
end


function part2()
    first(house for house in countfrom(1) if packages2(house) >= input)
end
