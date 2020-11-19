

input_regex = r"(\w+ ?\w*) (\d+),(\d+) through (\d+),(\d+)"


function part1()
    open("inputfiles/day6/input.txt") do io
        grid = falses(1000, 1000)
        for l in eachline(io)
            m = match(input_regex, l)
            inds = parse.(Int, m.captures[2:5]) .+ 1
            v = @view grid[inds[1]:inds[3], inds[2]:inds[4]]
            if m.captures[1] == "turn on"
                v .= true
            elseif m.captures[1] == "turn off"
                v .= false
            elseif m.captures[1] == "toggle"
                v .⊻= true
            end
        end
        count(grid)
    end
end


function part2()
    open("inputfiles/day6/input.txt") do io
        grid = zeros(Int, 1000, 1000)
        for l in eachline(io)
            m = match(input_regex, l)
            inds = parse.(Int, m.captures[2:5]) .+ 1
            v = @view grid[inds[1]:inds[3], inds[2]:inds[4]]
            if m.captures[1] == "turn on"
                v .+= 1
            elseif m.captures[1] == "turn off"
                v .= (x->max(0, x - 1)).(v)
            elseif m.captures[1] == "toggle"
                v .+= 2
            end
        end
        sum(grid)
    end
end
