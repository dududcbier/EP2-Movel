------------------------------
-- Level
------------------------------

local Class = require 'libs.hump.class'

local Level = Class{}

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

function Level:init(number, difficulty, lives)
   self.number = number
   self.difficulty = difficulty
   self.lives = lives
end

function Level:update(dt)
   love.graphics.setColor(255, 255, 255)
   love.graphics.printf("Lives: " .. self.lives, width/4, 20, width, 'center')
end

function Level:draw()
   love.graphics.setColor(255, 52, 110)
   love.graphics.printf("Lives: " .. self.lives, width/4, 20, width, 'center')
   love.graphics.setColor(255, 255, 255)
   love.graphics.printf("Level: " .. self.number, width/4, 20, width, 'left')
end

function Level:increase_lives(lives)
	self.lives = self.lives + lives
end

function Level:decrease_lives(lives)
	self.lives = self.lives - lives
end

return Level
