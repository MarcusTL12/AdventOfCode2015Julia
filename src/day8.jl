
function part1()
    open("inputfiles/day8/input.txt") do io
        sum(length(l) - length(Meta.parse(l)) for l in eachline(io))
    end
end


function part2()
    open("inputfiles/day8/input.txt") do io
        buff = IOBuffer()
        sum(begin
            show(buff, l)
            length(String(take!(buff))) - length(l)
        end for l in eachline(io))
    end
end
