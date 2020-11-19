

function part1()
    vowels = Set("aeiou")
    
    blacklist = Set([
        ('a', 'b'),
        ('c', 'd'),
        ('p', 'q'),
        ('x', 'y'),
    ])
    
    function is_nice(s)
        amtvowels = count(c in vowels for c in s)
        
        has_double = any(((a, b),) -> a == b, zip(s, drop(s, 1)))
        
        no_blacklist = !any(x -> x in blacklist, zip(s, drop(s, 1)))
        
        (amtvowels >= 3) && has_double && no_blacklist
    end
    
    open("inputfiles/day5/input.txt") do io
        count(is_nice(l) for l in eachline(io))
    end
end


function part2()
    function is_nice(s)
        has_two_double = false
        
        for i in 1:length(s) - 2
            substring = SubString(s, i:i + 1)
            for j in i + 2:length(s) - 1
                has_two_double |= substring == SubString(s, j:j + 1)
                has_two_double && break
            end
            has_two_double && break
        end
        
        has_split = any(((a, b),) -> a == b, zip(s, drop(s, 2)))
        
        has_two_double && has_split
    end
    
    open("inputfiles/day5/input.txt") do io
        count(is_nice(l) for l in eachline(io))
    end
end
