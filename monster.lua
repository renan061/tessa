local monster = {}
monster.__index = monster

function monster.new(name, size, type_, alignment, abilities, ac_mod, hitdice, speed)
    local t = {}

    t.name = name
    
    t.size = size
    t.type = type_ -- TODO
    t.alignment = alignment

    t.abilities = abilities

    t.ac_mod = ac_mod
    t.hitdice = hitdice
    t.speed = speed

    -- calculated
    t.ac = 10 + t.abilities.dex_mod + t.ac_mod.value
    t.hp = t.hitdice:average() + t.hitdice.quantity * t.abilities.con_mod

    setmetatable(t, monster)
    return t
end

function monster:description()
    local function actext(ac_mod)
        if ac_mod == 0 then return "" end
        return " (" .. ac_mod.description .. ")"
    end

    local function hpplus(hitdice, con_mod)
        if con_mod == 0 then return "" end
        return " + " .. hitdice.quantity * con_mod
    end

    local data = {
        --[[ name         ]] firstupper(self.name),
        --[[ size         ]] firstupper(self.size),
        --[[ type         ]] self.type,
        --[[ alignment    ]] self.alignment,
        --[[ ac           ]] self.ac, actext(self.ac_mod),
        --[[ hp (total)   ]] self.hp,
        --[[ hp (hitdice) ]] self.hitdice:description(),
        --[[ hp (plus)    ]] hpplus(self.hitdice, self.abilities.con_mod),
        --[[ speed        ]] self.speed:description()
    }

    local divider = "---\n"

    local format = "***\n" ..
        --[[ name                  ]] "%s\n" .. divider ..
        --[[ size, type, alignment ]] "%s %s, %s\n" .. divider ..
        --[[ ac                    ]] "Armor Class: %d%s\n" ..
        --[[ hp                    ]] "Hit Points: %d (%s%s)\n" ..
        --[[ speed                 ]] "Speed: %s\n" ..
        "***"
    return string.format(format, table.unpack(data))
end

return monster
