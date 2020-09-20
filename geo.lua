
local function distance_square(x1, y1, x2, y2)
    return math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2)
end

local function distance(x1, y1, x2, y2)
    return math.pow(distance_square(x1, y1, x2, y2), 0.5)
end

local function path(x_src, y_src, x_dest, y_dest)

    local x_distance = x_dest - x_src

    -- vertical line
    if x_distance == 0 then
        local y_distance = y_dest - y_src

        return function(d) 
            local y_progress = (y_distance * d)
            local y_value = y_progress + y_src
            return { x = x_src, y = y_value } 
        end
    end

    local slope = (y_dest - y_src) / (x_dest - x_src)
    local constant = y_src - (x_src * slope)

    -- point slope: y - y1 = m(x - x1)
    -- y = m(x - x1) + y1
    -- y = mx - x1m + y1

    return function(d)
        local x_progress = (x_distance * d)
        local x_value = x_progress + x_src
        return { x = x_value, y = (slope * x_value) - constant }
    end
end

return { distance_square = distance_square
       ; distance = distance
       ; path = path
       }
