---------------------------
--That is the menu screen
---------------------------

-- Import our libraries.
Gamestate = require 'libs.hump.gamestate'
Class = require 'libs.hump.class'

local menu = Gamestate.new()

function menu:draw()
  local width, height = love.graphics.getWidth(), love.graphics.getHeight()

  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle('fill', 0,0, width, height)
  love.graphics.setColor(255,255,255)
  love.graphics.printf('Press Enter to continue or Esc to quit', 0, height/2, width, 'center')
end

function menu:keyreleased(key, code)
    
   if key == 'return' then
      Gamestate.switch(game)
   end

end

return menu
