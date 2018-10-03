local attack = require("attack")
local damage = require("damage")
local die = require("die")
local monster = require("monster")

local enum = require("domain/enum")

local dice = require("domain/dice")
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
    --[[ name        ]] "Elite Clockwork Servant",
    --[[ size        ]] enum.size.large,
    --[[ type        ]] "construct", -- TODO
    --[[ alignment   ]] enum.alignment["lawful neutral"],
    --[[ acmod       ]] {value = 4, description = "natural armor"}, -- TODO
    --[[ hitdice     ]] dice.new(11, enum.die.d10),
    --[[ speed       ]] speed.new(6),
    --[[ proficiency ]] 3,
    --[[ abilities   ]] {20, 9, 16, 12, 10, 6},
    --[[ saves       ]] {enum.ability.str, enum.ability.cha},
    --[[ skills      ]] {enum.skill.athletics, enum.skill.arcana},
    --[[ damage vulnerabilities ]] {},
    --[[ damage resistances     ]] {enum.damage_type.lightning, enum.bpsnm},
    --[[ damage immunities      ]] {enum.damage_type.poison},
    --[[ condition immunities   ]]  {
                                        enum.condition_type.charmed,
                                        enum.condition_type.exhaustion,
                                        enum.condition_type.frightened,
                                        enum.condition_type.paralyzed,
                                        enum.condition_type.petrified,
                                        enum.condition_type.poisoned
                                    }
    --[[ senses      ]]
)

print(m:description())
