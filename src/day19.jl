using Base.Iterators


element_reg = r"[A-Z][a-z]?"


function load_input(filename)
    open(filename) do io
        lines = collect(eachline(io))
        
        conversions = Dict{String,Vector{String}}()
        
        for l in @view lines[1:end - 2]
            a, b = split(l, " => ")
            
            if haskey(conversions, a)
                push!(conversions[a], b)
            else
                conversions[a] = [b]
            end
        end
        
        conversions, [m.match for m in eachmatch(element_reg, lines[end])]
    end
end


function part1()
    conversions, molecule = load_input("inputfiles/day19/input.txt")
    
    length(Set(flatten(begin
        (begin
            new_molecule = copy(molecule)
            new_molecule[i] = subs
            join(new_molecule)
        end for subs in conversions[atom])
    end for (i, atom) in enumerate(molecule) if haskey(conversions, atom))))
end


function part2()
    _, molecule = load_input("inputfiles/day19/input.txt")
    
    a = count(x -> x in ("Rn", "Ar"), molecule)
    
    b = count(x -> x == "Y", molecule)
    
    length(molecule) - a - 2b - 1
end
