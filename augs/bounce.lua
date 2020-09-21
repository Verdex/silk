
local util = require 'util'

local function create()

    local obj = { lifetime = 0.3 }

    obj.interface = 'bounce'
    obj.id = util.gen_id()

    obj.dt = 0

    function obj:update(dt) 
        self.dt = self.dt + dt
        if self.dt > self.lifetime then
            self.dead = true
        end
    end

    function obj:modify_location(x, y)
        local d = math.sin(self.dt * 50) * 4 
        return x, y + d
    end

    function obj:modify_color(r, g, b, a)
        return r, g, b, a
    end

    return obj
end


return { create = create
       }
