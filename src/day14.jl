using Base.Iterators


function load_input(filename)
    open(filename) do io
        [begin
            p = split(l)
            parse.(Int, (p[4], p[7], p[end - 1]))
        end for l in eachline(io)]
    end
end


function raindist(t, (speed, time, rest))
    (t ÷ (time + rest)) * speed * time +
    clamp(t % (time + rest), 0, time) * speed
end


function part1()
    inp = load_input("inputfiles/day14/input.txt")
    
    maximum(raindist(2503, r) for r in inp)
end


function part2()
    inp = load_input("inputfiles/day14/input.txt")
    
    dists = zeros(Int, length(inp))
    scores = zeros(Int, length(inp))
    
    for t in 1 : 2503
        for (i, r) in enumerate(inp)
            dists[i] = raindist(t, r)
        end
        
        scores[argmax(dists)] += 1
    end
    
    maximum(scores)
end
