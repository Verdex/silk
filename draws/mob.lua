
local util = require 'util'
local aug_util = require 'augs/util'


local function create(character)

    local obj = { character = character
                ; color_r = 1
                ; color_g = 1
                ; color_b = 1
                ; color_a = 1
                ; x = 0 
                ; y = 0 
                }

    obj.size = 12
    obj.visible = true
    obj.augs = {}
    obj.id = util.gen_id()

    function obj:draw()
        love.graphics.setColor(aug_util.apply_color(self.augs, color_r, color_g, color_b, color_a))
        love.graphics.setNewFont(self.size)
        love.graphics.print(self.character, aug_util.apply_location(self.augs, self.x, self.y))
    end

    function obj:add_aug(aug)
        self.augs[#self.aug+1] = aug
    end

    return obj
end



return { create = create
       }
