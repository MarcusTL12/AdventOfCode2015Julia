using Base.Iterators


tape = Dict([
    "children" => 3,
    "cats" => 7,
    "samoyeds" => 2,
    "pomeranians" => 3,
    "akitas" => 0,
    "vizslas" => 0,
    "goldfish" => 5,
    "trees" => 3,
    "cars" => 2,
    "perfumes" => 1,
])


line_reg1 = r"Sue \d+: (.+)"
line_reg2 = r"(\w+): (\d+)"


function load_input(filename)
    open(filename) do io
        [begin
            content = match(line_reg1, l).captures[1]
            Dict(m.captures[1] => parse(Int, m.captures[2])
            for m in eachmatch(line_reg2, content))
        end for l in eachline(io)]
    end
end


function part1()
    inp = load_input("inputfiles/day16/input.txt")
    
    only(i for (i, sue) in enumerate(inp)
    if all(tape[thing] == n for (thing, n) in sue))
end


function part2()
    inp = load_input("inputfiles/day16/input.txt")
    
    only(i for (i, sue) in enumerate(inp)
    if all(begin
        if thing in ("cats", "trees")
            tape[thing] < n
        elseif thing in ("pomeranians", "goldfish")
            tape[thing] > n
        else
            tape[thing] == n
        end
    end for (thing, n) in sue))
end
