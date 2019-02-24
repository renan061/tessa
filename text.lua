require("global")

local enum = require("domain/enum")

local text = {}
text.__index = text

-----------------------------------------------------
--
--  Auxiliary
--
-----------------------------------------------------

local connectives = {"of"}

local function split(s, pattern)
    local t = {}
    s:gsub("[^" .. pattern .. "]*", function(x) table.insert(t, x) end)
    return t
end

local function uppercase(s)
    local t = split(s, "_")
    for i, v in ipairs(t) do
        if not table.contains(connectives, v) then
            t[i] = v:gsub("^%l", string.upper)
        end
    end
    return table.concat(t, " ")
end

-----------------------------------------------------
--
--  Text
--
-----------------------------------------------------

function text.abilities(abilities)
    local t, counter = {}, 0
    for k, v in enum.iterate(abilities.scores, enum.ability) do
        local modifier = signednumber(abilities.modifiers[k])
        table.insert(t, string.format("%s %d (%s)", k:upper(), v, modifier))
        counter = counter + 1
    end
    assert(counter == 6)
    return table.concat(t, " | ")
end

function text.saves(saves)
    local t, counter = {}, 0
    for k, v in enum.iterate(saves, enum.ability) do
        table.insert(t, firstupper(k) .. " " .. signednumber(v))
        counter = counter + 1
    end
    assert(counter == 6)
    return "Saving Throws: " .. table.concat(t, ", ")
end

function text.skills(skills)
    local t, counter = {}, 0
    for k, v in enum.iterate(skills, enum.skill) do
        table.insert(t, uppercase(k) .. " " .. signednumber(v))
        counter = counter + 1
    end
    assert(counter == 18, counter)
    return "Skills: " .. table.concat(t, ", ")
end

function text.damage_vulnerabilities(t)
    if table.size(t) == 0 then return "" end
    return "Damage Vulnerabilities: " .. table.concat(t, "; ")
end

function text.damage_resistances(t)
    if table.size(t) == 0 then return "" end
    return "Damage Resistances: " .. table.concat(t, "; ")
end

function text.damage_immunities(t)
    if table.size(t) == 0 then return "" end
    return "Damage Immunities: " .. table.concat(t, "; ")
end

function text.condition_immunities(t)
    if table.size(t) == 0 then return "" end
    return "Condition Immunities: " .. table.concat(t, ", ")
end

function text.distance(distance)
    return string.format("%d ft.", distance)
end

function text.damage(damage)
    return string.format("%d (%dd%d%s) %s damage", table.unpack({
        damage:average(),
        damage.dice_quantity,
        damage.dice_type,
        damage.modifier == 0 and "" or signednumber(damage.modifier),
        damage.damage_type
    }))
end

function text.attack(attack)
    local format = "%s %s Attack: %s to hit, reach %s, one target. Hit: %s%s%s"
    return string.format(format, table.unpack({
        firstupper(attack.range),
        firstupper(attack.type),
        signednumber(attack.tohit),
        text.distance(attack.reach),
        table.concat(map(text.damage, attack.damages), " + "),
        attack.attack_and and ", and " or ". ",
        attack.text
    }))
end

return text
