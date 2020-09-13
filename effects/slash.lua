
local util = require 'util'

local function create(x, y, radius)

    local obj = { x = x
                ; y = y
                ; radius = radius
                ; angle_1 = 0
                ; angle_2 = 0.1
                }

    obj.interface = 'slash'

    obj.visible = true
    obj.dt = 0
    obj.step = 1
    obj.id = util.gen_id()

    function obj:update(dt) 
        if self.dt + dt < 0.01 then
            self.dt = self.dt + dt 
        elseif self.step == 5 then
            self.remove_effect = true
            self.remove_update = true
        else
            local start_angle = (self.step - 1) / 10
            local end_angle = (self.step * 2) / 10
            self.angle_1 = self.angle_1 + start_angle 
            self.angle_2 = self.angle_2 + end_angle

            self.dt = 0
            self.step = self.step + 1
        end
    end

    function obj:draw()
        love.graphics.setColor(1.0, 1.0, 1.0)
        love.graphics.arc('line', 'open', self.x, self.y, self.radius, self.angle_1, self.angle_2, 10)
    end

    return obj
end

return { create = create
       }
