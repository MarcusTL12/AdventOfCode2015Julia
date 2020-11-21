using Base.Iterators


function load_store()
    open("inputfiles/day21/store.txt") do io
        weapons = Tuple{String,Int,Int,Int}[]
        armor = Tuple{String,Int,Int,Int}[]
        rings = Tuple{String,Int,Int,Int}[]
        
        cur_list = nothing
        
        for l in eachline(io)
            s = split(l)
            
            if length(s) > 0
                if s[1] == "Weapons:"
                    cur_list = weapons
                elseif s[1] == "Armor:"
                    cur_list = armor
                elseif s[1] == "Rings:"
                    cur_list = rings
                else
                    push!(cur_list, (join(@view s[1:end - 3]),
                    parse.(Int, @view s[end - 2:end])...))
                end
            end
        end
        weapons, armor, rings
    end
end


function load_boss()
    open("inputfiles/day21/input.txt") do io
        d = Dict(split(l, ": ") for l in eachline(io))
        
        hp = parse(Int, d["Hit Points"])
        a = parse(Int, d["Armor"])
        d = parse(Int, d["Damage"])
        
        hp, d, a
    end
end


function do_turn(player, boss)
    boss[1] -= max(player[2] - boss[3], 1)
    
    boss[1] <= 0 && return true
    
    player[1] -= max(boss[2] - player[3], 1)
    
    player[1] <= 0 && return false
    
    nothing
end


function play_game(player, boss)
    outcome = nothing
    
    while isnothing(outcome)
        outcome = do_turn(player, boss)
    end
    
    outcome
end


function all_equipment()
    weapons, armor, rings = load_store()
    
    all_weapons = ((c, d, a) for (_, c, d, a) in weapons)
    
    all_armor = flatten((((0, 0, 0),), ((c, d, a) for (_, c, d, a) in armor)), )
    
    all_single_rings = flatten((((0, 0, 0),),
    ((c, d, a) for (_, c, d, a) in rings)), )
    
    all_rings = flatten((((0, 0, 0),),
    flatten((r1 .+ r2 for r2 in drop(all_single_rings, i))
    for (i, r1) in enumerate(all_single_rings))))
    
    (w .+ a .+ r for (w, a, r) in product(all_weapons, all_armor, all_rings))
end


function part1()
    boss = load_boss()
    
    pl = [100, 0, 0]
    bs = collect(boss)
    
    minimum(c for (c, d, a) in all_equipment()
    if begin
        pl .= (100, d, a)
        bs .= boss
        play_game(pl, bs)
    end)
end


function part2()
    boss = load_boss()
    
    pl = [100, 0, 0]
    bs = collect(boss)
    
    maximum(c for (c, d, a) in all_equipment()
    if begin
        pl .= (100, d, a)
        bs .= boss
        !play_game(pl, bs)
    end)
end
