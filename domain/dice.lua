local d = require("die") -- TODO

local dice = {}
dice.__index = dice

function dice.new(quantity, die)
    local t = {}

    t.quantity = assert_positive_number(quantity)

    assert(d.valid(die)) -- TODO
    t.die = die

    setmetatable(t, dice)
    return t
end

function dice:average()
    local average = self.quantity * d.average(self.die) -- TODO
    return math.floor(average)
end

function dice:description()
    return string.format("%dd%d", self.quantity, self.die)
end

return dice
