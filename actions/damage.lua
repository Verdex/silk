
local shift = require 'augs/shift'
local bounce = require 'augs/bounce'
local temp_text = require 'effects/temp_text'

local function at(damage, color, x, y)

    local lifetime = 2

    local t = temp_text.create(damage, 10, color, x + 15, y, lifetime)
    local b = bounce.create(lifetime)
    local s = shift.create('direction', lifetime, 25)
    
    data.update:add(t)
    data.effects:add(t)

    t:add_aug(b)
    t:add_aug(s)

    data.update:add(b)
    data.update:add(s)
end

return { at = at
       }
