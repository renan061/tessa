local die = {}

die.d4 = 4
die.d6 = 6
die.d8 = 8
die.d10 = 10
die.d12 = 12
die.d20 = 20
die.d100 = 100

function die.valid(d)
    return d == die.d4   or
           d == die.d6   or
           d == die.d8   or
           d == die.d10  or
           d == die.d12  or
           d == die.d20  or
           d == die.d100
end

function die.average(d)
    if not enum.dice[d] then
        error("invalid die type")
    end
    return d / 2 + 0.5
end

function die.avg_player_hitdice(d)
    if d == die.d4   or
       d == die.d20  or
       d == die.d100 then
        error("invalid class hit dice")
    elseif d == die.d6 then
        return 4
    elseif d == die.d8 then
        return 5
    elseif d == die.d10 then
        return 6
    elseif d == die.d12 then
        return 7
    else
        error("invalid die type")
    end
end

function die.avg_monster_hitdice(d)
    error("todo")
end

return nil
