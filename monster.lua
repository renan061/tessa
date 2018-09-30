local monster = {}
monster.__index = monster

function monster.new(name, size, type_, alignment, acmod, hitdice, speed,
    proficiency, abilities, saves)

    local t = {}

    t.name = name
    
    t.size = size
    t.type = type_ -- TODO
    t.alignment = alignment

    t.acmod = acmod
    t.hitdice = hitdice
    t.speed = speed

    t.proficiency = proficiency
    t.abilities = abilities
    t.saves = saves

    -- TODO
    t.skills = nil
    t.damage_vulnerabilities = nil
    t.damage_resistances = nil
    t.damage_immunities = nil
    t.condition_immunities = nil
    t.senses = nil
    t.languages = nil
    t.challenge = nil

    -- calculated
    t.ac = 10 + t.abilities.dexmod + t.acmod.value
    t.hp = t.hitdice:average() + t.hitdice.quantity * t.abilities.conmod

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
        --[[ hp (plus)    ]] hpplus(self.hitdice, self.abilities.conmod),
        --[[ speed        ]] self.speed:description(),
        --[[ abilities    ]] self.abilities:description(),
        --[[ saves        ]] self.saves:description()
    }

    local divider = "---\n"

    local format = "***\n" ..
        --[[ name                  ]] "%s\n" .. divider ..
        --[[ size, type, alignment ]] "%s %s, %s\n" .. divider ..
        --[[ ac                    ]] "Armor Class: %d%s\n" ..
        --[[ hp                    ]] "Hit Points: %d (%s%s)\n" ..
        --[[ speed                 ]] "Speed: %s\n" .. divider ..
        --[[ abilities             ]] "%s\n" ..
        --[[ saves                 ]] "Saving Throws %s\n" ..
        "***"
    return string.format(format, table.unpack(data))
end

return monster
