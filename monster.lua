local enum = require("domain/enum")
local text = require("text")

local monster = {}
monster.__index = monster

function monster.new(name, size, type_, alignment, acmod, hitdice, speed,
    proficiency, abilities, saves, skills,
    damage_vulnerabilities, damage_resistances, damage_immunities,
    condition_immunities)

    local t = {}

    t.name = name
    
    t.size = size
    t.type = type_ -- TODO
    t.alignment = alignment

    t.acmod = acmod
    t.hitdice = hitdice
    t.speed = speed

    t.proficiency = proficiency

    do -- abilities
        t.abilities = {scores = {}, modifiers = {}}
        for _, v, i in enum.iterate(enum.ability) do
            t.abilities.scores[v] = abilities[i]
            t.abilities.modifiers[v] = math.floor((abilities[i] - 10) / 2)
        end
    end

    do -- saves
        t.saves = {}
        for ability in enum.iterate(enum.ability) do
            t.saves[ability] = t.abilities.modifiers[ability]
            if table.contains(saves, ability) then
                t.saves[ability] = t.saves[ability] + t.proficiency
            end
        end
    end

    do -- skills
        t.skills = {}
        for skill in enum.iterate(enum.skill) do
            t.skills[skill] = t.abilities.modifiers[enum.skill_modifier[skill]]
            if table.contains(skills, skill) then
                t.skills[skill] = t.skills[skill] + t.proficiency
            end
        end
    end

    t.damage_vulnerabilities = damage_vulnerabilities
    t.damage_resistances = damage_resistances
    t.damage_immunities = damage_immunities
    t.condition_immunities = condition_immunities

    -- TODO
    t.senses = nil
    t.languages = nil
    t.challenge = nil

    -- calculated
    t.ac = 10 + t.abilities.modifiers.dex + t.acmod.value
    t.hp = t.hitdice:average() + t.hitdice.quantity * t.abilities.modifiers.con

    setmetatable(t, monster)
    return t
end

function monster:description()
    local function actext(acmod)
        if acmod == 0 then return "" end
        return " (" .. acmod.description .. ")"
    end

    local function hpplus(hitdice, conmod)
        if conmod == 0 then return "" end
        return " + " .. hitdice.quantity * conmod
    end

    local data = {
        --[[ name         ]] firstupper(self.name),
        --[[ size         ]] firstupper(self.size),
        --[[ type         ]] self.type,
        --[[ alignment    ]] self.alignment,
        --[[ ac           ]] self.ac, actext(self.acmod),
        --[[ hp (total)   ]] self.hp,
        --[[ hp (hitdice) ]] self.hitdice:description(),
        --[[ hp (plus)    ]] hpplus(self.hitdice, self.abilities.modifiers.con),
        --[[ speed        ]] self.speed:description(),
        --[[ abilities    ]] text.abilities(self.abilities),
        --[[ saves        ]] text.saves(self.saves),
        --[[ skills       ]] text.skills(self.skills),
        text.damage_vulnerabilities(self.damage_vulnerabilities),
        text.damage_resistances(self.damage_resistances),
        text.damage_immunities(self.damage_immunities),
        text.condition_immunities(self.condition_immunities)
    }

    local divider = "---\n"

    local format = "***\n" ..
        --[[ name                   ]] "%s\n" .. divider ..
        --[[ size, type, alignment  ]] "%s %s, %s\n" .. divider ..
        --[[ ac                     ]] "Armor Class: %d%s\n" ..
        --[[ hp                     ]] "Hit Points: %d (%s%s)\n" ..
        --[[ speed                  ]] "Speed: %s\n" .. divider ..
        --[[ abilities              ]] "%s\n" ..
        --[[ saves                  ]] "%s\n" ..
        --[[ skills                 ]] "%s\n" ..
        --[[ damage vulnerabilities ]] "%s\n" ..
        --[[ damage resistances     ]] "%s\n" ..
        --[[ damage immunities      ]] "%s\n" ..
        --[[ condition immunities   ]] "%s\n" ..
        "***"
    return string.format(format, table.unpack(data))
end

return monster
