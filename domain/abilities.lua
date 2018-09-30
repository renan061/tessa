require("asserts")

local abilities = {}
abilities.__index = abilities

function abilities.new(str, dex, con, int, wis, cha)
    local t = {}

    t.str = assert_non_negative_number(str)
    t.dex = assert_non_negative_number(dex)
    t.con = assert_non_negative_number(con)
    t.int = assert_non_negative_number(int)
    t.wis = assert_non_negative_number(wis)
    t.cha = assert_non_negative_number(cha)

    -- calculated
    local function mod(score) return math.floor((score - 10) / 2) end
    t.strmod = mod(t.str)
    t.dexmod = mod(t.dex)
    t.conmod = mod(t.con)
    t.intmod = mod(t.int)
    t.wismod = mod(t.wis)
    t.chamod = mod(t.cha)

    setmetatable(t, abilities)
    return t
end

function abilities:description()
    local data = {
        self.str, self.strmod,
        self.dex, self.dexmod,
        self.con, self.conmod,
        self.int, self.intmod,
        self.wis, self.wismod,
        self.cha, self.chamod
    }
    local format = "STR %d (%d) | DEX %d (%d) | CON %d (%d) | " ..
        "INT %d (%d) | WIS %d (%d) | CHA %d (%d)"
    return string.format(format, table.unpack(data))
end

return abilities
