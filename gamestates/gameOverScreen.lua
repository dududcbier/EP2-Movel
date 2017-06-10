--------------------------------
--That is the game over screen
--------------------------------

Class = require 'libs.hump.class'

local gameOver = {}

function gameOver:update()
end

function gameOver:draw()
  local width, height = love.graphics.getWidth(), love.graphics.getHeight()

  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle('fill', 0,0, width, height)
  love.graphics.setColor(255,255,255)
  love.graphics.printf('Game Over!!!', 0, height/2, width, 'center')
end


return gameOver