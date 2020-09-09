
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

    for _, v in data.update:iter() do
        v.update(dt)     
    end

end

-- this is the only function that the graphics functions
-- will work in
function love.draw()
   
    for _, v in data.draw:iter() do

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
