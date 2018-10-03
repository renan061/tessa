function table.contains(t, e)
    for _, v in pairs(t) do
        if v == e then
            return true
        end
    end
    return false
end

function table.mirror(t)
    local new = {}
    for k, v in pairs(t) do
        new[k] = v
        new[v] = k
    end 
    return new
end

function table.size(t)
    local i = 0
    for _ in pairs(t) do
        i = i + 1
    end 
    return i
end
