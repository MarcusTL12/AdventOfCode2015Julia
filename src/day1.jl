using Base.Iterators


function part1()
    open("inputfiles/day1/input.txt") do io
        sum(if c == '('
            1
        elseif c == ')'
            -1
        else
            0
        end for c in String(read(io)))
    end
end


function part2()
    open("inputfiles/day1/input.txt") do io
        first(
        dropwhile(((_, x),) -> x != -1,
        enumerate(
        accumulate(+,
        if c == '('
            1
        elseif c == ')'
            -1
        else
            0
        end for c in String(read(io))))))[1]
    end
end
