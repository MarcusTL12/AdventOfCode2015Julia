using Base.Iterators
using Combinatorics


function parse_input(filename)
    open(filename) do io
        dists = Dict{Tuple{String,String},Int}()
        places = Set{String}()
        
        for l in eachline(io)
            a, _, b, _, dist = split(l)
            
            dists[(a, b)] = parse(Int, dist)
            dists[(b, a)] = parse(Int, dist)
            
            push!(places, a)
            push!(places, b)
        end
        
        dists, collect(places)
    end
end


function tour_length(tour, dists)
    sum(dists[p] for p in zip(tour, drop(tour, 1)))
end


function part1()
    dists, places = parse_input("inputfiles/day9/input.txt")
    
    minimum(tour_length(tour, dists) for tour in permutations(places))
end


function part2()
    dists, places = parse_input("inputfiles/day9/input.txt")
    
    maximum(tour_length(tour, dists) for tour in permutations(places))
end
