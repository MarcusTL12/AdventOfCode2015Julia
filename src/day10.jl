using Base.Iterators


input = reverse(digits(1321131112))


function look_and_say!(target, from)
    resize!(target, 0)
    cur_digit = from[1]
    amt_digit = 1
    for digit in drop(from, 1)
        if digit == cur_digit
            amt_digit += 1
        else
            push!(target, amt_digit)
            push!(target, cur_digit)
            cur_digit = digit
            amt_digit = 1
        end
    end
    push!(target, amt_digit)
    push!(target, cur_digit)
end


function part1()
    a = copy(input)
    b = Int[]
    
    for _ in 1 : 40
        look_and_say!(b, a)
        a, b = b, a
    end
    
    length(a)
end


function part2()
    a = copy(input)
    b = Int[]
    
    for _ in 1 : 50
        look_and_say!(b, a)
        a, b = b, a
    end
    
    length(a)
end
