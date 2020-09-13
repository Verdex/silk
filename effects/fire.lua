
local util = require 'util'

local function create(x, y)

    local obj = {x = x; y = y}

    obj.interface = 'fire'

    obj.visible = true
    obj.lengths = {}
    obj.length = 10 
    obj.dt = 0
    obj.id = util.gen_id()

    for i = 1, obj.length do
        obj.lengths[i] = { 0, 0, 0 }
    end

    function obj:update(dt) 
        if self.dt + dt < 0.15 then
            self.dt = self.dt + dt 
        else
            self.dt = 0
            for i = 1, self.length do
                for d = 1, 3 do
                    self.lengths[i][d] = love.math.random(3, 10)
                end
            end
        end
    end

    function obj:draw()
        love.graphics.setColor(1.0, 1.0, 1.0, 0.5)
        for k, v in ipairs(self.lengths) do
            love.graphics.line(self.x + k, self.y, self.x + k, self.y - v[1])
        end

        love.graphics.setColor(1.0, 1.0, 0, 0.5)
        for k, v in ipairs(self.lengths) do
            love.graphics.line(self.x + k, self.y, self.x + k, self.y - v[2])
        end

        love.graphics.setColor(1.0, 0.5, 0, 0.5)
        for k, v in ipairs(self.lengths) do
            love.graphics.line(self.x + k, self.y, self.x + k, self.y - v[3])
        end
    end

    return obj
end

return { create = create
       }
