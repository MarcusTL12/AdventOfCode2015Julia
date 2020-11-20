using Base.Iterators
using Combinatorics


function load_input(filename)
    open(filename) do io
        people = Set{String}()
        scores = Dict(begin
            a, _, s, n, _, _, _, _, _, _, b =
                split(SubString(l, 1:length(l) - 1))
            nn = parse(Int, n) * (s == "gain" ? 1 : -1)
            push!(people, a)
            (a, b) => nn
        end for l in eachline(io))
        
        collect(people), scores
    end
end


function compute_happiness(scores, order)
    sum(scores[p] + scores[reverse(p)] for p in zip(order, drop(order, 1))) +
        scores[(order[1], order[end])] + scores[(order[end], order[1])]
end


function part1()
    people, scores = load_input("inputfiles/day13/input.txt")
    maximum(compute_happiness(scores, order) for order in permutations(people))
end


function part2()
    people, scores = load_input("inputfiles/day13/input.txt")
    
    push!(people, "Me")
    
    for person in people
        push!(scores, ("Me", person) => 0)
        push!(scores, (person, "Me") => 0)
    end
    
    maximum(compute_happiness(scores, order) for order in permutations(people))
end
