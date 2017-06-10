---------------------------
--That is the menu screen
---------------------------

-- Import our libraries.
Gamestate = require 'libs.hump.gamestate'
Class = require 'libs.hump.class'
Score = require 'classes.Score'

local Menu = {}

function Menu:draw()
  local width, height = love.graphics.getWidth(), love.graphics.getHeight()

  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle('fill', 0,0, width, height)
  love.graphics.setColor(255,255,255)
  love.graphics.printf('Press Enter to continue or Esc to quit', 0, height/2, width, 'center')
end

function Menu:keyreleased(key, code) 
  if key == 'return' then
    highscore = {}
    score = Score(20, 20, 0)
    if not love.filesystem.exists("highscore.lua") then
      love.filesystem.newFile("highscore.lua")
      love.filesystem.write("highscore.lua", "Highscore\n=\n" .. score.highscore)
    end
    for line in love.filesystem.lines("highscore.lua") do
      table.insert(highscore, line)
    end
    score.highscore = highscore[3]
    love.filesystem.write("highscore.lua", "highscore\n=\n" .. score.highscore)
    Gamestate.switch(Game, score, 1)
  end
end

function Menu:mousepressed(x, y)
  self:clicked(x, y)
end

function Menu:touchpressed(id, x, y, dx, dy, pressure)
  self:clicked(x, y)
end

function Menu:clicked(x, y)
  highscore = {}
  score = Score(20, 20, 0)
  if not love.filesystem.exists("highscore.lua") then
    love.filesystem.newFile("highscore.lua")
    love.filesystem.write("highscore.lua", "Highscore\n=\n" .. score.highscore)
  end
  for line in love.filesystem.lines("highscore.lua") do
    table.insert(highscore, line)
  end
  score.highscore = highscore[3]
  love.filesystem.write("highscore.lua", "highscore\n=\n" .. score.highscore)
  Gamestate.switch(Game, score, 1)
end

return Menu
