require("extensions")

local enum = {}
enum.__index = enum

enum._sequence_key = "_sequence" 

-- FUTURE: load enums from file

-----------------------------------------------------
--
--  TODO
--
-----------------------------------------------------

enum.bpsnm = "bludgeoning, piercing and slashing from nonmagical attacks"

-----------------------------------------------------
--
--  Iterator
--
-----------------------------------------------------

function enum.iterate(t, e)
    if not e then
        e = t
    end

    local i = 0
    return function()
        i = i + 1
        local key = e[enum._sequence_key .. i]
        return key, t[key], i
    end
end

-----------------------------------------------------
--
--  Auxiliary
--
-----------------------------------------------------

-- creates an enum-like table
local function create(values)
    local t = {}
    for i, v in ipairs(values) do
        t[enum._sequence_key .. i] = v
        t[v] = v
    end
    return t
end

-----------------------------------------------------
--
--  Ability
--
-----------------------------------------------------

enum.ability = create({"str", "dex", "con", "int", "wis", "cha"})

-----------------------------------------------------
--
--  Alignment
--
-----------------------------------------------------

enum.alignment = create({
    "lawful good",
    "neutral good",
    "chaotic good",
    "lawful neutral",
    "neutral",
    "chaotic neutral",
    "lawful evil",
    "neutral evil",
    "chaotic evil",
    "unaligned"
})

-----------------------------------------------------
--
--  Damage Type
--
-----------------------------------------------------

enum.damage_type = create({
    "acid",
    "bludgeoning",
    "cold",
    "fire",
    "force",
    "lightning",
    "necrotic",
    "piercing",
    "poison",
    "psychic",
    "radiant",
    "slashing",
    "thunder"
})

-----------------------------------------------------
--
--  Die
--
-----------------------------------------------------

enum.die = table.mirror({
    d4 = 4,
    d6 = 6,
    d8 = 8,
    d10 = 10,
    d12 = 12,
    d20 = 20,
    d100 = 100
})

-----------------------------------------------------
--
--  Condition Type
--
-----------------------------------------------------

enum.condition_type = create({
    "blinded",
    "charmed",
    "deafened",
    "exhaustion",
    "frightened",
    "grappled",
    "incapacitated",
    "invisible",
    "paralyzed",
    "petrified",
    "poisoned",
    "prone",
    "restrained",
    "stunned",
    "unconscious"
})

-----------------------------------------------------
--
--  Size
--
-----------------------------------------------------

enum.size = create({
    "tiny",
    "small",
    "medium",
    "large",
    "huge",
    "gargantuan"
})

-----------------------------------------------------
--
--  Skill
--
-----------------------------------------------------

enum.skill = create({
    "acrobatics",
    "animal_handling",
    "arcana",
    "athletics",
    "deception",
    "history",
    "insight",
    "intimidation",
    "investigation",
    "medicine",
    "nature",
    "perception",
    "performance",
    "persuasion",
    "religion",
    "sleight_of_hand",
    "stealth",
    "survival"
})

enum.skill_modifier = {}
enum.skill_modifier[enum.skill.acrobatics]      = enum.ability.dex
enum.skill_modifier[enum.skill.animal_handling] = enum.ability.wis
enum.skill_modifier[enum.skill.arcana]          = enum.ability.int
enum.skill_modifier[enum.skill.athletics]       = enum.ability.str
enum.skill_modifier[enum.skill.deception]       = enum.ability.cha
enum.skill_modifier[enum.skill.history]         = enum.ability.int
enum.skill_modifier[enum.skill.insight]         = enum.ability.wis
enum.skill_modifier[enum.skill.intimidation]    = enum.ability.cha
enum.skill_modifier[enum.skill.investigation]   = enum.ability.int
enum.skill_modifier[enum.skill.medicine]        = enum.ability.wis
enum.skill_modifier[enum.skill.nature]          = enum.ability.int
enum.skill_modifier[enum.skill.perception]      = enum.ability.wis
enum.skill_modifier[enum.skill.performance]     = enum.ability.cha
enum.skill_modifier[enum.skill.persuasion]      = enum.ability.cha
enum.skill_modifier[enum.skill.religion]        = enum.ability.int
enum.skill_modifier[enum.skill.sleight_of_hand] = enum.ability.dex
enum.skill_modifier[enum.skill.stealth]         = enum.ability.dex
enum.skill_modifier[enum.skill.survival]        = enum.ability.wis

return enum
