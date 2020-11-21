# using Base.Meta: eval

abstract type Ins end


struct Hlf <: Ins r::Int end
struct Tpl <: Ins r::Int end
struct Inc <: Ins r::Int end
struct Jmp <: Ins off::Int end
struct Jie <: Ins r::Int; off::Int end
struct Jio <: Ins r::Int; off::Int end

eval(::Nothing) = nothing

function compile_input(filename)
    reg = r"\s+|,\s*"
    
    regs = Dict{String,Int}()
    
    function register(r)
        if !haskey(regs, r)
            regs[r] = length(regs) + 1
        end
        regs[r]
    end
    
    compile(T::Type{<:Union{Hlf,Tpl,Inc}}, x) = T(register(x))
    compile(T::Type{Jmp}, x) = T(parse(Int, x))
    compile(T::Type{<:Union{Jie,Jio}}, x, y) = T(register(x), parse(Int, y))
    
    open(filename) do io
        [begin
            parts = split(l, reg)
            
            T = eval(Meta.parse(titlecase(parts[1])))
            
            compile(T, (@view parts[2:end])...)
        end for l in eachline(io)]
    end
end


function run_program(program, registers)
    i = 1
    
    call_ins(ins::Hlf) = registers[ins.r] ÷= 2
    call_ins(ins::Tpl) = registers[ins.r] *= 3
    call_ins(ins::Inc) = registers[ins.r] += 1
    call_ins(ins::Jmp) = i += ins.off - 1
    call_ins(ins::Jie) = if registers[ins.r] % 2 == 0 i += ins.off - 1 end
    call_ins(ins::Jio) = if registers[ins.r] == 1 i += ins.off - 1 end
    
    while i >= 1 && i <= length(program)
        call_ins(program[i])
        i += 1
    end
end


function part1()
    program = compile_input("inputfiles/day23/input.txt")
    
    registers = [0, 0]
    
    run_program(program, registers)
    
    registers[2]
end


function part2()
    program = compile_input("inputfiles/day23/input.txt")
    
    registers = [1, 0]
    
    run_program(program, registers)
    
    registers[2]
end
