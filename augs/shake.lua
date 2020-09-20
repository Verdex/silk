
local util = require 'util'

local function create()

    local obj = { lifetime = 5 }

    obj.interface = 'shake'
    obj.id = util.gen_id()

    obj.dt = 0

    function obj:update(dt) 
        self.dt = self.dt + dt
        if self.dt > self.lifetime then
            self.dead = true
        end
    end

    function obj:modify_location(x, y)
        return x, y
    end

    function obj:modify_color(r, g, b, a)
        return r, g, b, a
    end

    return obj
end


return { create = create
       }
