---------------------------
--That is the menu screen
---------------------------

-- Import our libraries.
Gamestate = require 'libs.hump.gamestate'
Class = require 'libs.hump.class'
Score = require 'classes.Score'

local Menu = {}

function Menu:init()
  self.game_difficulty = 1
end

function Menu:update(dt)
  local width, height = love.graphics.getWidth(), love.graphics.getHeight()
  sqrt_2 = math.sqrt(2)

  button_width = width / 4
  button_height = width / 20
  pos_x = button_height * 7.5
  pos_y = height / 2 - height * sqrt_2 / 4 + height / sqrt_2 - 2 * width / 10

  love.graphics.setColor(255,255,255)
  love.graphics.printf('Difficulty: ' .. self.game_difficulty, 0, pos_y + width / 40, width, 'center')
  love.graphics.setColor(255, 166, 25)
  if (self.game_difficulty < 10) then
    love.graphics.polygon('fill', pos_x + button_width, pos_y, pos_x + button_width + width/40, pos_y + button_height / 2, pos_x + button_width, pos_y + button_height)
  end
  if (self.game_difficulty > 1) then
    love.graphics.polygon('fill', pos_x, pos_y, pos_x - width/40, pos_y + button_height / 2, pos_x, pos_y + button_height)
  end
end

function Menu:draw()
  local width, height = love.graphics.getWidth(), love.graphics.getHeight()

  love.graphics.setBackgroundColor(132, 245, 214)
  love.graphics.setColor(73, 231, 187, 255)
  for i = 1, 10 do
    love.graphics.rectangle('fill', width / 10 * (i - 1), 0, width / 20, height)
  end
  sqrt_2 = math.sqrt(2)
  -- border
  love.graphics.setColor(0, 161, 116, 255)
  love.graphics.rectangle('fill', width / 20 * 6.5, height / 2 - height * sqrt_2 / 4, width / 20 * 7, height / sqrt_2)
  -- box
  love.graphics.setColor(21, 213, 160, 255)
  love.graphics.rectangle('fill', width / 20 * 6.5 + 5, height / 2 - height * sqrt_2 / 4 + 5, width / 20 * 7 - 10, height / sqrt_2 - 10)

  button_width = width / 4
  button_height = width / 20
  -- play button
  love.graphics.setColor(0, 161, 116, 255)
  love.graphics.rectangle('fill', width / 20 * 7.5, height / 2 - height * sqrt_2 / 4 + height / sqrt_2 - width / 10,button_width, button_height)
  love.graphics.setColor(255,255,255)
  love.graphics.printf('Play', 0, height / 2 - height * sqrt_2 / 4 + height / sqrt_2 - width / 10 + width / 40, width, 'center')
  -- difficulty button
  love.graphics.setColor(0, 161, 116, 255)
  pos_x = button_height * 7.5
  pos_y = height / 2 - height * sqrt_2 / 4 + height / sqrt_2 - 2 * width / 10
  love.graphics.rectangle('fill', pos_x, pos_y, button_width, button_height)
  love.graphics.setColor(255,255,255)
  love.graphics.printf('Difficulty: ' .. self.game_difficulty, 0, pos_y + width / 40, width, 'center')
  love.graphics.setColor(255, 166, 25)
  -- right arrow
  if (self.game_difficulty < 10) then
    love.graphics.polygon('fill', pos_x + button_width, pos_y, pos_x + button_width + width/40, pos_y + button_height / 2, pos_x + button_width, pos_y + button_height)
  end
  --left arrow
  if (self.game_difficulty > 1) then
    love.graphics.polygon('fill', pos_x, pos_y, pos_x - width/40, pos_y + button_height / 2, pos_x, pos_y + button_height)
  end
  image = love.graphics.newImage("img/BrickBreaker.png")
  love.graphics.draw(image, width / 20 * 6.5 + 15, height / 2 - height * sqrt_2 / 4 + 20, 0, 0.11, 0.11)
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
    Gamestate.switch(Game, score, self.game_difficulty)
  end
end

function Menu:mousepressed(x, y)
  self:clicked(x, y)
end

function Menu:touchpressed(id, x, y, dx, dy, pressure)
  self:clicked(x, y)
end

function Menu:clicked(x, y)
  local width, height = love.graphics.getWidth(), love.graphics.getHeight()
  if (pointInRectangle(x, y, width / 20 * 7.5, height / 2 - height * sqrt_2 / 4 + height / sqrt_2 - width / 10, width / 4, width / 20)) then
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
    Gamestate.switch(Game, score, self.game_difficulty)
  end
  if (self.game_difficulty > 1 and pointInTriangle(x, y, pos_x, pos_y, pos_x - width/40, pos_y + button_height / 2, pos_x, pos_y + button_height)) then
    self.game_difficulty = self.game_difficulty - 1
  end
  if (self.game_difficulty < 10 and pointInTriangle(x, y, pos_x + button_width, pos_y, pos_x + button_width + width/40, pos_y + button_height / 2, pos_x + button_width, pos_y + button_height)) then 
    self.game_difficulty = self.game_difficulty + 1
  end
end

function pointInTriangle(px, py, p0x, p0y, p1x, p1y, p2x, p2y)
  area = 0.5 *(-p1y*p2x + p0y*(-p1x + p2x) + p0x*(p1y - p2y) + p1x*p2y);
  s = 1/(2*area)*(p0y*p2x - p0x*p2y + (p2y - p0y)*px + (p0x - p2x)*py);
  t = 1/(2*area)*(p0x*p1y - p0y*p1x + (p0y - p1y)*px + (p1x - p0x)*py);
  return (s > 0 and t > 0 and 1 > s + t)
end

return Menu
