using StaticArrays


function part1()
    open("inputfiles/day3/input.txt") do io
        dirs = Dict([
            '>' => SVector(1, 0),
            '<' => SVector(-1, 0),
            '^' => SVector(0, 1),
            'v' => SVector(0, -1),
        ])
        pos = @SVector [0, 0]
        visited = Set([pos])
        for dir in (dirs[c] for c in String(read(io)))
            pos += dir
            push!(visited, pos)
        end
        length(visited)
    end
end


function part2()
    open("inputfiles/day3/input.txt") do io
        dirs = Dict([
            '>' => SVector(1, 0),
            '<' => SVector(-1, 0),
            '^' => SVector(0, 1),
            'v' => SVector(0, -1),
        ])
        posA = @SVector [0, 0]
        posB = @SVector [0, 0]
        visited = Set([posA])
        for dir in (dirs[c] for c in String(read(io)))
            posA += dir
            push!(visited, posA)
            posA, posB = posB, posA
        end
        length(visited)
    end
end
