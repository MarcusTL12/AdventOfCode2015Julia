using Base.Iterators
using MD5


input = "ckczppom"


function find_zeros(n)
    first(dropwhile(
        i -> !all(x -> x == '0', take((bytes2hex(md5(input * string(i)))), n)),
        countfrom(1)
    ))
end


part1() = find_zeros(5)
part2() = find_zeros(6)
