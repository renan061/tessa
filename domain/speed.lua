local speed = {}
speed.__index = speed

function speed.new(n)
    local t = {}

    t.n = n
    t.feet = 5 * n
    t.meters = 1.5 * n -- TODO

    setmetatable(t, speed)
    return t
end

function speed:description()
    return string.format("%d ft.", self.feet)
end

return speed
