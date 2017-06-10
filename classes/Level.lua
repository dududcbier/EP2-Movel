------------------------------
-- Level
------------------------------

local Class = require 'libs.hump.class'

local Level = Class{}

function Level:init(pos_x, pos_y, number, lives)
   self.pos_x = pos_x
   self.pos_y = pos_y
   self.number = number
   self.lives = lives
end

function Level:increase_lives(lives)
	self.lives = self.lives + lives
end

function Level:decrease_lives(lives)
	self.lives = self.lives - lives
end

function Level:update(dt)
end

function Level:draw()
   local width = love.graphics.getWidth()
   love.graphics.setColor(255, 255, 255)
   love.graphics.printf("Lives: " .. tostring(self.lives), self.pos_x, self.pos_y, width, 'center')

end

return Level
