local lpeg = require("lpeg")
local re = require("re")

local tabs = 0 -- hehe
function table.print(t)
    if not t then
        return print(t)
    end
    function printtabs()
        for i = 1, tabs do
            io.write(" ")
        end
    end
    for k, v in pairs(t) do
        printtabs()
        io.write("* ")
        if type(v) == "table" then
            io.write(tostring(k) .. " => \n")
            tabs = tabs + 4
            table.print(v)
            tabs = tabs - 4
        else
            io.write(tostring(k) .. " => " ..  tostring(v) .. "\n")
        end
    end
end

-- Isso é um ataque, podemos dar match em um ataque.
-- local input = "Longsword. Melee Weapon Attack: +8 to hit."
local input = "Longsword. " ..
    "Melee Weapon Attack: +7 to hit, reach 5 ft., one target. " ..
    "Hit: 8 (1d8 + 4) slashing damage + 7 (2d6) fire damage."

local definitions = {}
function define(t)
    for k, v in pairs(t) do
        definitions[k] = re.compile(v, definitions)
    end
end

-- capture functions
definitions.tonumber = function(s)
    s = s:gsub("%s*", "")
    s = s:gsub("'+'", "")
    return tonumber(s)
end

-- patterns
define {
    S = "%s*",
    number = "[1-9][0-9]*",
    die = "'d' ([23468] / '10' / '12' / '20')"
}

define { modifier = "('+' / '-') %S %number" }

define { roll = "{[1-9][0-9]*} {%die} %S %modifier -> tonumber" }
    
define { type = " 'bludgeoning' / 'piercing' / 'slashing' "}

define { damage = "{%number} %S '(' {| %roll |} ')' %S {%type} %S 'damage'" }

-- define { damage_list = [[
--     damage_list <- damage_list %S '+' %S %damage
--                  / %damage
-- ]] }

define { action = [[
    action   <- {| name types tohit distance targets hit {.*} |}
    name     <- {(!'.'.)+} '. '
    types    <- {| {'Melee' / 'Ranged'} %S {'Weapon' / 'Spell'} ' Attack: ' |}
    tohit    <- %modifier -> tonumber ' to hit, '
    distance <- {| {'range' / 'reach'} %S {%number} ' ft., ' |}
    targets  <- {[a-z]+}' target''s'? '. '
    hit      <- 'Hit: ' %S {| %damage |}
]]}

lpeg.locale(lpeg)   -- adds locale entries into 'lpeg' table

-- local space = lpeg.space^0
-- local name = lpeg.C(lpeg.alpha^1) * space
-- local sep = lpeg.S(",;") * space
-- local pair = lpeg.Cg(name * "=" * space * name) * sep^-1
-- local list = lpeg.Cf(lpeg.Ct("") * pair^0, rawset)
-- t = list:match("a=b, c = hi; next = pi")  --> { a = "b", c = "hi", next = "pi" }

local ast = definitions.action:match(input)

table.print(ast)
