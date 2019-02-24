local damage = {}
damage.__index = damage

function damage.new(dice_quantity, dice_type, modifier, damage_type)
    local t = {}

    t.dice_quantity = dice_quantity
    t.dice_type = dice_type
    t.modifier = modifier
    t.damage_type = damage_type

    setmetatable(t, damage)
    return t
end

function damage:average()
    local die_average = self.dice_type / 2 + 0.5
    return math.floor(self.dice_quantity * die_average) + self.modifier
end

return damage
