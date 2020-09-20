
local function apply_location(augs, x, y)
    
    local remove = {}

    for index, aug in ipairs(augs) do
        if aug.dead then
            remove[#remove+1] = index
        else
            x, y = aug:modify_location(x, y)
        end
    end

    for _, index in ipairs(remove) do
        table.remove(augs, index)
    end

    return x, y
end

local function apply_color(augs, r, g, b, a)
    
    local remove = {}

    for index, aug in ipairs(augs) do
        if aug.dead then
            remove[#remove+1] = index
        else
            r, g, b, a = aug:modify_color(r, g, b, a)
        end
    end

    for _, index in ipairs(remove) do
        table.remove(augs, index)
    end

    return r, g, b, a 
end

return { apply_color = apply_color
       ; apply_location = apply_location
       }
