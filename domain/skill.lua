local skill = {}
skill.__index = skill


skill.list = {
    {"dex", "acrobatics"},
    {"wis", "animal handling"},
    {"int", "arcana"},
    {"str", "athletics"},
    {"cha", "deception"},
    {"int", "history"},
    {"wis", "insight"},
    {"cha", "intimidation"},
    {"int", "investigation"},
    {"wis", "medicine"},
    {"int", "nature"},
    {"wis", "perception"},
    {"cha", "performance"},
    {"cha", "persuasion"},
    {"int", "religion"},
    {"dex", "sleight of hand"},
    {"dex", "stealth"},
    {"wis", "survival"}
}

function skill.new()
end

return skill
