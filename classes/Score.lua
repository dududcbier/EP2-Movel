------------------------------
-- Score
------------------------------

local Class = require 'libs.hump.class'

local Score = Class{}

function Score:init(pos_x, pos_y, highscore)
   self.pos_x = pos_x
   self.pos_y = pos_y
   self.highscore = highscore
   self.account = 0
end

function Score:update(points)
	self.account = self.account + points
end

function Score:draw()
   local width = love.graphics.getWidth()
   love.graphics.setColor(255, 255, 255)
   love.graphics.printf("Score: " .. tostring(self.account), self.pos_x, self.pos_y, width, 'center')

   love.graphics.printf("High Score: " .. tostring(self.highscore), self.pos_x + 10, self.pos_y, width, 'left')
end

function Score:reset()
   self.account = 0
end

return Score
