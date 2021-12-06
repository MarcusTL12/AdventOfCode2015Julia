using Base.Iterators
using Combinatorics
using LinearAlgebra


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


function tour_length_mat(tour, dists)
    sum(dists[i, j] for (i, j) in zip(tour, drop(tour, 1)))
end


function my_beutiful_solution(dists)
    places = 1:size(dists)[1]

    minimum(tour_length_mat(tour, dists) for tour in permutations(places))
end


function find_min_permutation(dists)
    places = 1:size(dists)[1]

    minperm = nothing
    minlength = typemax(Int)

    for perm in permutations(places)
        l = tour_length_mat(perm, dists)
        if l < minlength
            minperm = copy(perm)
            minlength = l
        end
    end

    (minlength, minperm)
end


function greedy_solution(dists, places, start)
    prevplace = start
    remaining = filter(!=(start), places)
    curlen = 0
    while !isempty(remaining)
        nextind = 1
        nextlen = dists[prevplace, remaining[1]]
        for i = 2:length(remaining)
            d = dists[prevplace, remaining[i]]
            if d < nextlen
                nextlen = d
                nextind = i
            end
        end
        curlen += nextlen
        prevplace = popat!(remaining, nextind)
    end
    curlen
end


function sanders_stupid_solution(dists)
    places = 1:size(dists)[1]

    minimum(greedy_solution(dists, places, start) for start in places)
end


function trig_num(n)
    (n * (n + 1)) ÷ 2
end


function make_dist_mat(dists)
    n = first(x for x in countfrom(1) if trig_num(x) >= length(dists))

    @assert trig_num(n) == length(dists)

    mat = zeros(Int, n + 1, n + 1)

    k = 0
    for i = 1:n
        for j = i:n
            mat[i, j+1] = dists[k+=1]
        end
    end

    Symmetric(mat)
end


function make_dist_mat_from_inp(dists, places)
    n = length(places)

    mat = zeros(Int, n, n)

    for (i, a) in enumerate(places)
        for (j, b) in enumerate(places)
            if i != j
                mat[i, j] = dists[(a, b)]
            end
        end
    end

    mat
end


function is_metric(dist_mat)
    n = size(dist_mat)[1]

    all(dist_mat[i, j] + dist_mat[j, k] >= dist_mat[i, k]
        for i = 1:n, j = 1:n, k = 1:n)
end


function trying_different_inputs(n, mindiff, itr)
    n_dists = trig_num(n - 1)

    for dists in combinations(itr, n_dists)
        dist_mat = make_dist_mat(dists)

        if !is_metric(dist_mat)
            continue
        end

        a = my_beutiful_solution(dist_mat)
        b = sanders_stupid_solution(dist_mat)

        if abs(a - b) >= mindiff
            @show a b
            return dist_mat
        end
    end
end
