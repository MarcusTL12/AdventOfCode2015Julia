using Base.Iterators


function load_input(filename)
    open(filename) do io
        reverse!([parse(Int, l) for l in eachline(io)])
    end
end


function combs(nums, tot, maxlen, len, off)
    if tot == 0
        (sizehint!(Int[], maxlen),)
    elseif len >= maxlen
        ()
    else
        flatten((push!(v, i + off)
        for v in combs((@view nums[i + 1:end]),
            tot - nums[i], maxlen, len + 1, off + i))
        for i in 1:length(nums) if nums[i] <= tot)
    end
end


function exists_of_length(nums, tot, len)
    if tot == 0 && len == 0
        return true
    elseif len == 0
        return false
    end
    
    it = dropwhile(i -> nums[i] > tot, 1:length(nums) - len + 1)
    if !isempty(it)
        j = first(it)
        
        for i in j:length(nums) - len + 1
            if exists_of_length((@view nums[i + 1:end]), tot - nums[i], len - 1)
                return true
            end
        end
        
        false
    else
        false
    end
end


function part1()
    nums = load_input("inputfiles/day24/input.txt")
    
    tot = sum(nums)
    
    n = 3
    
    amt = first(
        dropwhile(i -> !exists_of_length(nums, tot ÷ n, i), countfrom(0)))
    
    minimum(prod(nums[i] for i in v) for v in combs(nums, tot ÷ n, amt, 0, 0))
end


function part2()
    nums = load_input("inputfiles/day24/input.txt")
    
    tot = sum(nums)
    
    n = 4
    
    amt = first(
        dropwhile(i -> !exists_of_length(nums, tot ÷ n, i), countfrom(0)))
    
    minimum(prod(nums[i] for i in v) for v in combs(nums, tot ÷ n, amt, 0, 0))
end
