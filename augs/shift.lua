
local util = require 'util'
local geo = require 'geo'

local function create(direction)

    local obj = { lifetime = 0.3 
                ; distance = 10
                }

    obj.interface = 'shift'
    obj.id = util.gen_id()

    obj.dt = 0

    function obj:update(dt) 
        self.dt = self.dt + dt
        if self.dt > self.lifetime then
            self.dead = true
        end
    end

    function obj:modify_location(x, y)
        local d = (self.dt / self.lifetime) * self.distance
        return x + d, y
    end

    function obj:modify_color(r, g, b, a)
        return r, g, b, a
    end

    return obj
end


return { create = create
       }
