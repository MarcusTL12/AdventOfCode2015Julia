using JSON


function sum_all_numbers(object)
    if object isa Number
        object
    elseif object isa Dict
        sum(sum_all_numbers(element) for (_, element) in object)
    elseif object isa Vector
        sum(sum_all_numbers(element) for element in object)
    else
        0
    end
end


function sum_non_red(object)
    if object isa Number
        object
    elseif object isa Dict
        s = 0
        for (_, element) in object
            if element == "red"
                return 0
            end
            
            s += sum_non_red(element)
        end
        s
    elseif object isa Vector
        sum(sum_non_red(element) for element in object)
    else
        0
    end
end


function part1()
    sum_all_numbers(JSON.parsefile("inputfiles/day12/input.json"))
end


function part2()
    sum_non_red(JSON.parsefile("inputfiles/day12/input.json"))
end
