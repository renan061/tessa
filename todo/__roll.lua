local roll = {}
roll.__index = roll

function roll.new(dice_quantity, dice_type, modifier)
    local t = {}

    -- TODO: asserts
    t.dice_quantity = dice_quantity
    t.dice_type = dice_type
    t.modifier = modifier

    setmetatable(t, roll)
    return t
end

function roll:average()
    assert(false)
    -- local roll = self.dice_quantity * die.average(self.dice_type)
    -- return math.floor(roll) + self.extra
end

return roll
