------------------------------
-- Level
------------------------------

local Class = require 'libs.hump.class'

local Level = Class{}

function Level:init(number, difficulty)
   self.number = number
   self.high_score = 0
   self.score = 0
   self.difficulty = difficulty
end

function Level:update_score(points)
	self.score = self.score + points
	-- print(self.score)
end

function Level:draw_score()
end

return Level
