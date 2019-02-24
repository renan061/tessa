local attack = require("attack")
local damage = require("damage")
local enum = require("domain/enum")

local text = require("text")

local atk = attack.new(
    attack.range.melee,
    attack.type.weapon,
    8,
    5,
    {
        damage.new(2, enum.die.d6, 5, enum.damage_type.bludgeoning),
        damage.new(4, enum.die.d4, 0, enum.damage_type.radiant)
    },
    true,
    "the target is grappled (escape $MONSTER_DC$). Until this grapple ends, " ..
        "the target is restrained, the $MONSTER_NAME$ can automatically hit " ..
        "the target with its slam, and if the $MONSTER_NAME$ is already " ..
        "grappling another creature it can't make attacks against other " ..
        "targets."
)

print(text.damage(damage.new(2, enum.die.d6, 5, enum.damage_type.bludgeoning)))

print(text.attack(atk))
