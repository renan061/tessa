require("global")
local damage = require("damage")

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

function attack.new(range, type, tohit, reach, damages)
    local t = {}

    -- TODO: asserts
    t.range = range
    t.type = type
    t.tohit = tohit
    t.reach = reach
    t.damages = damages -- array

    setmetatable(t, attack)
    return t
end

function attack:description()
    local data = {
        firstupper(self.range),
        firstupper(self.type),
        self.tohit,
        self.reach,
        table.concat(map(damage.description, self.damages), " + ")
    }
    local format = "%s %s Attack: " ..
        "+%d to hit, " ..
        "reach %d ft., " ..
        "one target. " ..
        "Hit: %s."
    return string.format(format, table.unpack(data))
end

return attack