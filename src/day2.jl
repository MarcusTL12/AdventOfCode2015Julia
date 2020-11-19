
function part1()
    open("inputfiles/day2/input.txt") do io
        sum(
            parse.(Int, split(l, 'x'))
            |>
            ((x, y, z),)
            ->
            (
                sides = (x * y, y * z, z * x);
                2 * sum(sides) + min(sides...)
            )
            for l in eachline(io)
        )
    end
end


function part2()
    open("inputfiles/day2/input.txt") do io
        sum(
            sort!(parse.(Int, split(l, 'x')))
            |>
            dims -> sum(@view dims[1:2]) * 2 + prod(dims)
            for l in eachline(io)
        )
    end
end
