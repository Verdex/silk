
local util = require 'util'
local geo = require 'geo'

local function create(draw, x_src, y_src, x_dest, y_dest, speed)

    local v_src = { x = x_src; y = y_src }
    local v_dest = { x = x_dest; y = y_dest }

    local obj = { src = v_src
                ; dest = v_dest
                ; speed = speed
                ; total_distance = geo.distance(x_src, y_src, x_dest, y_dest)
                ; distance = 0
                ; path = geo.vec_2d_path( v_src, v_dest )
                }

    obj.interface = 'throw'

    obj.visible = true
    obj.id = util.gen_id()

    function obj:update(dt) 
        local d = self.speed * dt
        self.distance = self.distance + d
        if self.distance > self.total_distance then
            self.visible = false
            self.remove_effect = true
            self.remove_update = true
        end
    end

    function obj:draw()
        local v = self.path(self.distance / self.total_distance)
        draw( v.x, v.y )
    end

    return obj
end

return { create = create
       }
