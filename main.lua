
local repo = require 'repo'

data = {}

-- this only gets called once at the beginning
function love.load()

    data.draw = repo.create_standard()
    data.update = repo.create_standard() 

end

-- this function is called continuously
-- dt is the delta time (in seconds) of the last
-- time that the function was called
function love.update(dt)

    local remove = {}
    for _, v in data.update:iter() do
        v.update(dt)     
        if v.remove_update then
            remove[#remove+1] = v.id
        end
    end

    for _, v in ipairs(remove) do
        data.update:remove_by_id(v)
    end

end

-- this is the only function that the graphics functions
-- will work in
function love.draw()
   
    local remove = {}
    for _, v in data.draw:iter() do
        if v.visible then
            v.draw()
        end
        if v.remove_draw then
            remove[#remove+1] = v.id 
        end
    end

    for _, v in ipairs(remove) do
        data.draw:remove_by_id(v)
    end

end

function love.mousepressed(x, y, button, istouch)
    
end

function love.mousereleased(x, y, button, istouch)

end

function love.keypressed(key)
end

function love.keyreleased(key)
end

function love.focus(in_focus)

end

function love.quit()
end
