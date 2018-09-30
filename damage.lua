local die = require("die")

local damage = {}
damage.__index = damage

damage.type = {
    acid = "acid",
    piercing = "piercing",
    slashing = "slashing",
    bludgeoning = "bludgeoning"
}

function damage.new(dice_quantity, dice_type, extra, type)
    local t = {}

    -- TODO: asserts
    t.dice_quantity = dice_quantity
    t.dice_type = dice_type
    t.extra = extra
    t.type = type

    setmetatable(t, damage)
    return t
end

function damage:average()
    local roll = self.dice_quantity * die.average(self.dice_type)
    return math.floor(roll) + self.extra
end

function damage:description()
    local extra = ""
    if self.extra < 0 then
        extra = tostring(self.extra)
    elseif self.extra > 0 then
        extra = "+" .. tostring(self.extra)
    end

    local data = {
        self:average(),
        self.dice_quantity,
        self.dice_type,
        extra,
        self.type
    }
    local format = "%d (%.dd%d%s) %s damage"
    return string.format(format, table.unpack(data))
end

return damage
