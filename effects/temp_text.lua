
local util = require 'util'
local augs_util = require 'augs/util'

local function create(text, size, color, x, y, lifetime)

    local obj = { text = text
                ; color = color
                ; x = x
                ; y = y
                ; augs = {}
                ; size = size
                ; lifetime = lifetime or 0.3
                }

    obj.interface = 'temp_text'

    obj.dt = 0
    obj.visible = true
    obj.id = util.gen_id()

    function obj:add_aug(aug)
        self.augs[#self.augs+1] = aug
    end

    function obj:update(dt) 
        self.dt = self.dt + dt
        if self.dt > self.lifetime then
            self.visible = false
            self.dead = true
        end
    end

    function obj:draw()
        local x, y = augs_util.apply_location(self.augs, self.x, self.y)
        local r, g, b, a = augs_util.apply_color(self.augs, self.color.r, self.color.g, self.color.b, self.color.a)
        love.graphics.setColor(r, g, b, a)
        love.graphics.setNewFont(self.size)
        love.graphics.print(self.text, x, y)
    end

    return obj
end

return { create = create
       }
