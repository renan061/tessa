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
    t.str_mod = mod(t.str)
    t.dex_mod = mod(t.dex)
    t.con_mod = mod(t.con)
    t.int_mod = mod(t.int)
    t.wis_mod = mod(t.wis)
    t.cha_mod = mod(t.cha)

    setmetatable(t, abilities)
    return t
end

return abilities
