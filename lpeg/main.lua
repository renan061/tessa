local lpeg = require("lpeg")
local re = require("re")

-- Isso é um ataque, podemos dar match em um ataque.
-- local input = "Longsword. Melee Weapon Attack: +8 to hit."
local input = "Longsword. " ..
    "Melee Weapon Attack: +7 to hit, reach 5 ft., one target. " ..
    "Hit: 8 (1d8 + 4) slashing damage, " ..
        "or 9 (1d10 + 4) slashing damage " ..
        "if used with two hands to make a melee attack."

-- local input = "abab"

-- G = lpeg.P {
--     "S";
--     S = "a" * lpeg.V("B")
--       + "b" * lpeg.V("A")
--       + "",
--     A = "a" * lpeg.V("S")
--       + "b" * lpeg.V("A") * lpeg.V("A"),
--     B = "b" * lpeg.V("S")
--       + "a" * lpeg.V("B") * lpeg.V("B"),
-- } * -1

local P, B, R, S, V = lpeg.P, lpeg.B, lpeg.R, lpeg.S, lpeg.V
local C, Ct = lpeg.C, lpeg.Ct

-- local uppercase = C(R"AZ" * R"az"^0)

-- local G = lpeg.P {
--     "S",
--     S = V"U" * P(" ") * V"S" + V"U",
--     U = uppercase
-- }

local defs = {
    space = P" "
    spaces = spaces^0
    number = R"09"^1 / tonumber,
    modifier = (P"+" + "-") * R"09"^1 / tonumber
}

defs.roll = re.compile([[
    roll <- n 'd' die %spaces ''
    n    <- [1-9][0-9]*
    die  <- [468] / '10' / '12' / '20'
]], defs)

local G = [[
    action   <- name types tohit distance targets hit {.*}
    name     <- {(!'.'.)+} '. '
    types    <- {'Melee' / 'Ranged'} ' ' {'Weapon' / 'Spell'} ' Attack: '
    tohit    <- %modifier ' to hit, '
    distance <- {'range' / 'reach'} ' ' %number ' ft., '
    targets  <- {[a-z]+}' target''s'? '. '
    hit      <- 'Hit: ' %number '(' %roll ')'
]]

G = Ct(re.compile(G, defs)):match(input)

print(G)

if not G then return nil end
for k, v in pairs(G) do
    print(k, v)
end
