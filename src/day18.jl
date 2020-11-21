

function load_input(filename)
    open(filename) do io
        w = 0
        h = 0
        buffer = falses(0)
        
        for l in eachline(io)
            w = length(l)
            h += 1
            append!(buffer, (c == '#' for c in l))
        end
        
        reshape(buffer, (w, h))
    end
end


directions = [
    (1, 0),
    (1, 1),
    (0, 1),
    (-1, 1),
    (-1, 0),
    (-1, -1),
    (0, -1),
    (1, -1)
]


function do_step!(from, to)
    for i in 1 : size(from)[1]
        for j in 1 : size(from)[2]
            neighbours = sum(get(from, (i, j) .+ d, false) for d in directions)
            
            to[i, j] = if from[i, j]
                neighbours in (2, 3)
            else
                neighbours == 3
            end
        end
    end
end


function part1()
    a = load_input("inputfiles/day18/input.txt")
    b = falses(size(a))
    
    for _ in 1 : 100
        do_step!(a, b)
        
        a, b = b, a
    end
    
    count(a)
end


function part2()
    a = load_input("inputfiles/day18/input.txt")
    b = falses(size(a))
    
    for _ in 1 : 100
        do_step!(a, b)
        
        b[1, 1] = b[1, end] = b[end, 1] = b[end, end] = true
        
        a, b = b, a
    end
    
    count(a)
end
