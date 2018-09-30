function firstupper(str)
    return str:gsub("^%l", string.upper)
end

function map(f, t)
    local new = {}
    for i, v in ipairs(t) do
        new[i] = f(v)
    end
    return new
end

-- function contains(table, value)
--     for key, val in pairs(table) do
--         if val == value then
--             return true
--         end
--     end
--     return false
-- end

-- function contains_or(table, ...)
--     local values = arg
--     for value in pairs(values) do
--         if contains(table, value) then
--             return true
--         end
--     end
--     return false
-- end
