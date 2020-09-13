
local function distance_square(x1, y1, x2, y2)
    return math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2)
end

local function distance(x1, y1, x2, y2)
    return math.pow(distance_square(x1, y1, x2, y2), 0.5)
end


return { distance_square = distance_square
       ; distance = distance
       }
