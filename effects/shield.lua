

local util = require 'util'

local function create(x, y, radius)

    local obj = {x = x; y = y; radius = radius}

    obj.interface = 'shield'

    obj.visible = true
    obj.dt = 0
    obj.id = util.gen_id()

    function obj:update(dt) 
    end

    function obj:draw()
        love.graphics.setColor(0.67, 1.0, 0.18, 0.5)
        love.graphics.circle('fill', self.x, self.y, self.radius, 10)
        love.graphics.setColor(0.67, 1.0, 0.18)
        love.graphics.circle('line', self.x, self.y, self.radius, 10)
    end

    return obj
end

return { create = create
       }
