using Base.Iterators


input = Int.(reverse!(Vector{Char}("hepxcrrq")) .- ('a' - 1))


function increment!(password)
    @inbounds for i in 1:length(password)
        password[i] += 1
        if password[i] == 27
            password[i] = 1
        else
            break
        end
    end
end


function make_readable_password(password)
    String(['a' + c - 1 for c in Iterators.reverse(password)])
end


blacklist = [Int(c - 'a' + 1) for c in "iol"]

function valid_password(password)
    r1 = any(((a, b, c),) -> a == b + 1 && b == c + 1,
        zip(password, drop(password, 1), drop(password, 2)))
    
    r2 = !any(c -> c in blacklist, password)
    
    r3 = begin
        skip_one = false
        amt = 0
        
        for (a, b) in zip(password, drop(password, 1))
            if skip_one
                skip_one = false
            elseif a == b
                skip_one = true
                amt += 1
                amt == 2 && break
            end
        end
        
        amt == 2
    end
    
    r1 && r2 && r3
end


function part1()
    password = copy(input)
    
    while !valid_password(password)
        increment!(password)
    end
    
    make_readable_password(password)
end


function part1()
    password = copy(input)
    
    while !valid_password(password)
        increment!(password)
    end
    
    increment!(password)
    
    while !valid_password(password)
        increment!(password)
    end
    
    make_readable_password(password)
end
