

function parse_input(filename)
    open(filename) do file
        Dict(reverse!(split(l, " -> "))
        for l in eachline(file))
    end
end


function eval_wire(wire, circuit, memory=Dict{String,UInt16}())
    function rec(wire)
        function eval_or_parse(wire)
            tmp = tryparse(UInt16, wire)
            if !isnothing(tmp)
                tmp
            else
                rec(wire)
            end
        end
        
        if haskey(memory, wire)
            return memory[wire]
        end
        
        instruction = circuit[wire]
        
        parts = split(instruction)
        
        l = length(parts)
        
        res = if l == 1
            eval_or_parse(parts[1])
        elseif l == 2
            ~rec(parts[2])
        elseif l == 3
            a = eval_or_parse(parts[1])
            b = eval_or_parse(parts[3])
            
            if parts[2] == "AND"
                a & b
            elseif parts[2] == "OR"
                a | b
            elseif parts[2] == "LSHIFT"
                a << b
            elseif parts[2] == "RSHIFT"
                a >> b
            end
        end
        
        memory[wire] = res
        
        res
    end
    
    Int(rec(wire))
end


function part1()
    circuit = parse_input("inputfiles/day7/input.txt")
    
    eval_wire("a", circuit)
end


function part2()
    circuit = parse_input("inputfiles/day7/input.txt")
    
    a = eval_wire("a", circuit)
    
    eval_wire("a", circuit, Dict(["b" => a]))
end
