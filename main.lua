local attack = require("attack")
local damage = require("damage")
local die = require("die")
local monster = require("monster")

local abilities = require("domain/abilities")
local alignment = require("domain/alignment")
local dice = require("domain/dice")
local size = require("domain/size")
local speed = require("domain/speed")

print("Monster Maker v0.1")

-- atk = attack.new(
--     --[[ range   ]] attack.range.ranged,
--     --[[ type    ]] attack.type.spell,
--     --[[ tohit   ]] 9,
--     --[[ reach   ]] 60,
--     --[[ damages ]] {
--         damage.new(1, die.d8, 5, damage.type.piercing),
--         damage.new(4, die.d4, 0, damage.type.acid)
--     }
-- )
-- print(atk:description())

local m = monster.new(
    --[[ name      ]] "Elite Clockwork Servant",
    --[[ size      ]] size.large,
    --[[ type      ]] "construct", -- TODO
    --[[ alignment ]] alignment.lawful_neutral,
    --[[ abilities ]] abilities.new(20, 9, 16, 12, 10, 6),
    --[[ acmod     ]] {value = 4, description = "natural armor"}, -- TODO
    --[[ hitdice   ]] dice.new(11, die.d10),
    --[[ speed     ]] speed.new(6)
)

print(m:description())

