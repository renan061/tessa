local attack = {}
attack.__index = attack

attack.range = {
    melee = "melee",
    ranged = "ranged"
}

attack.type = {
    weapon = "weapon",
    spell = "spell"
}

function attack.new(range, type, tohit, reach, damages, attack_and, text)
    local t = {}

    t.range = range
    t.type = type
    t.tohit = tohit
    t.reach = reach
    t.damages = damages -- array
    t.attack_and = attack_and
    t.text = text

    setmetatable(t, attack)
    return t
end

return attack
