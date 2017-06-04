------------------------------
-- Level
------------------------------

local Class = require 'libs.hump.class'

local Level = Class{}

function Level:init(number)
   self.number = number
   self.score = 0
end

function Level:update_score(points)
	self.score = self.score + points
	print(self.score)
end

function Level:draw_score()
end

return Level
