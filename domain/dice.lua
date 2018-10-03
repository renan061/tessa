require("asserts")

local enum = require("domain/enum")

local dice = {}
dice.__index = dice

local function dieaverage(d)
    if not enum.die[d] then
        error("invalid die type")
    end
    return d / 2 + 0.5
end


function dice.new(quantity, die)
    local t = {}

    t.quantity = assert_positive_number(quantity)
    t.die = die -- TODO: assert valid die

    setmetatable(t, dice)
    return t
end

function dice:average()
    local average = self.quantity * dieaverage(self.die)
    return math.floor(average)
end

function dice:description()
    return string.format("%dd%d", self.quantity, self.die)
end

return dice
