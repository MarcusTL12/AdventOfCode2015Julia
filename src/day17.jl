using Base.Iterators


function load_input(filename)
    open(filename) do io
        [parse(Int, l) for l in eachline(io)]
    end
end


function all_combs(n)
    if n == 1
        (false, true)
    else
        flatten((flatten((x, y), ) for y in all_combs(n - 1))
        for x in (false, true))
    end
end


itlen(it) = foldl((a, _) -> a + 1, it; init=0)


function part1()
    inp = load_input("inputfiles/day17/input.txt")
    
    itlen(nothing for comb in all_combs(length(inp))
        if sum(a * s for (a, s) in zip(comb, inp)) == 150)
end


function part2()
    inp = load_input("inputfiles/day17/input.txt")
    
    amts = Dict{Int,Int}()
    
    for comb in (comb for comb in all_combs(length(inp))
        if sum(a * s for (a, s) in zip(comb, inp)) == 150)
        c = count(comb)
        if haskey(amts, c)
            amts[c] += 1
        else
            amts[c] = 1
        end
    end
    
    amts[minimum(keys(amts))]
end
