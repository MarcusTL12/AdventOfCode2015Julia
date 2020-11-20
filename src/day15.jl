using Base.Iterators


function load_input(filename)
    open(filename) do io
        [begin
            _, _, cap, _, dur, _, fla, _, tex, _, cal = split(l)
            parse.(Int, (cap[1:end - 1],
                dur[1:end - 1],
                fla[1:end - 1],
                tex[1:end - 1],
                cal))
        end for l in eachline(io)]
    end
end


function all_combs(n, tot)
    if n == 2
        ((i, tot - i) for i in 0:tot)
    else
        flatten((flatten((i, seq), ) for seq in all_combs(n - 1, tot - i))
        for i in 0:tot)
    end
end


function score(ingredients, recipie)
    prod((x = sum(a * b
    for (a, b) in zip(recipie, (ing[i] for ing in ingredients)));
    x > 0 ? x : 0)
    for i in 1:4)
end


function cals(ingredients, recipie)
    sum(ing[end] * amt for (ing, amt) in zip(ingredients, recipie))
end


function part1()
    ingredientes = load_input("inputfiles/day15/input.txt")
    recipie = zeros(Int, length(ingredientes))
    
    maximum(begin
        recipie .= comb
        score(ingredientes, recipie)
    end for comb in all_combs(length(ingredientes), 100))
end


function part2()
    ingredientes = load_input("inputfiles/day15/input.txt")
    recipie = zeros(Int, length(ingredientes))
    
    maximum(rec -> score(ingredientes, rec),
    Iterators.filter(rec -> cals(ingredientes, rec) == 500,
        (recipie .= comb; recipie)
        for comb in all_combs(length(ingredientes), 100)))
end
