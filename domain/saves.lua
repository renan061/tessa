require("global")

local ability = require("domain/ability")

local saves = {}
saves.__index = saves

function saves.new(bitmap, proficiency, abilities)
    local t = {}

    t.proficiencies = bitmap

    -- bitmap masks
    t._masks = {}
    local base = 1 << 5
    for i, v in ipairs(ability.names) do
        t._masks[v] = base >> i - 1
    end

    -- saves
    t.values = {}
    for _, v in ipairs(ability.names) do
        local trained = bitmap & t._masks[v] == t._masks[v]
        t.values[v] = trained and proficiency or 0
        t.values[v] = t.values[v] + abilities[v .. "mod"]
    end

    setmetatable(t, saves)
    return t
end

function saves:description()
    local data = {}
    for k, v in pairs(self.values) do
        data[k] = firstupper(k) .. " " .. signednumber(v)
    end
    for i, v in ipairs(ability.names) do
        data[i] = data[v]
        data[v] = nil
    end

    local format = "%s, %s, %s, %s, %s, %s"
    return string.format(format, table.unpack(data))
end

return saves
