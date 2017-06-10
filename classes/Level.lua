------------------------------
-- Level
------------------------------

local Class = require 'libs.hump.class'

local Level = Class{}

function Level:init(number)
   self.number = number
end

return Level
