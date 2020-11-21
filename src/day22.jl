using DataStructures


abstract type Spell end
abstract type Effect <: Spell end

struct MagicMissile <: Spell end
struct Drain <: Spell end

mutable struct Shield <: Effect
    duration::Int
end

mutable struct Poison <: Effect
    duration::Int
end

mutable struct Recharge <: Effect
    duration::Int
end


mana_cost(::Type{MagicMissile}) = 53
mana_cost(::Type{Drain}) = 73
mana_cost(::Type{Shield}) = 113
mana_cost(::Type{Poison}) = 173
mana_cost(::Type{Recharge}) = 229


mutable struct GameState
    player_hp::Int
    player_armor::Int
    player_mana::Int
    boss_hp::Int
    boss_dps::Int
    effects::Vector{Effect}
end


function do_turn(state::GameState, spell::Type{<:Spell}, diff)
    state.player_hp -= diff
    
    state.player_hp <= 0 && return false
    
    do_effect(x::Shield) = if x.duration == 0 state.player_armor -= 7 end
    do_effect(::Poison) = state.boss_hp -= 3
    do_effect(::Recharge) = state.player_mana += 101
    
    remove_stack = Int[]
    
    function do_effects()
        for (i, e) in enumerate(state.effects)
            e.duration -= 1
            do_effect(e)
            if e.duration == 0
                push!(remove_stack, i)
            end
        end
        
        while length(remove_stack) > 0
            i = pop!(remove_stack)
            deleteat!(state.effects, i)
        end
    end
    
    do_effects()
    
    any(x -> x isa spell, state.effects) && return false
    
    do_spell(::Type{MagicMissile}) = state.boss_hp -= 4
    do_spell(::Type{Drain}) = (state.boss_hp -= 2; state.player_hp += 2)
    function do_spell(::Type{Shield})
        state.player_armor += 7
        push!(state.effects, Shield(6))
    end
    do_spell(::Type{Poison}) = push!(state.effects, Poison(6))
    do_spell(::Type{Recharge}) = push!(state.effects, Recharge(5))
    
    do_spell(spell)
    
    state.player_mana -= mana_cost(spell)
    
    state.player_mana <= 0 && return false
    
    do_effects()
    
    if state.player_hp <= 0
        return false
    elseif state.boss_hp <= 0
        return true
    end
    
    state.player_hp -= max(state.boss_dps - state.player_armor, 1)
    
    if state.player_hp <= 0
        return false
    elseif state.boss_hp <= 0
        return true
    end
end


function dijkstra(state::GameState, diff=0)
    spells = Type{<:Spell}[
        MagicMissile,
        Drain,
        Shield,
        Poison,
        Recharge
    ]
    
    queue = PriorityQueue([(state, Type{<:Spell}[]) => 0])
    
    while length(queue) > 0
        ((state, spell_hist), mana_usage) = dequeue_pair!(queue)
        for spell in spells
            nstate = deepcopy(state)
            nspell_hist = copy(spell_hist)
            outcome = do_turn(nstate, spell, diff)
            if isnothing(outcome)
                push!(nspell_hist, spell)
                queue[(nstate, nspell_hist)] = mana_usage + mana_cost(spell)
            elseif outcome
                return mana_cost(spell) + mana_usage
            end
        end
    end
end


input = (58, 9)


function part1()
    state = GameState(50, 0, 500, 58, 9, Effect[])
    
    dijkstra(state)
end


function part2()
    state = GameState(50, 0, 500, 58, 9, Effect[])
    
    dijkstra(state, 1)
end
