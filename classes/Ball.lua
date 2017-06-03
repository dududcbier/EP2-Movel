------------------------------
--Ball
------------------------------

local Class = require 'libs.hump.class'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local Ball = Class{}

function Ball:init(x, y, radius, speed_x, speed_y)
   self.pos_x = x
   self.pos_y = y
   self.radius = radius
   self.speed_x = speed_x
   self.speed_y = speed_y
end


function Ball:set_position(pos_x, pos_y)
   self.pos_x = pos_x
   self.pos_y = pos_y
end

function Ball:get_info(ball)
   local diameter = 2 * ball.radius
   return { x = ball.pos_x - ball.radius, y = ball.pos_y - ball.radius, width = diameter, height = diameter }
end


function Ball:turn_back(horizontal_shift, vertical_shift)
   
   local min = math.min(math.abs(horizontal_shift), math.abs(vertical_shift))
   
   if math.abs(horizontal_shift) == min then
      vertical_shift = 0
      self.speed_x  = (-1) * self.speed_x
   else
      horizontal_shift = 0
      self.speed_y  = (-1) * self.speed_y
   end

   self.pos_x = self.pos_x  + horizontal_shift
   self.pos_y = self.pos_y + vertical_shift
     
end

function Ball:update(delta_t)
   self.pos_x = self.pos_x + self.speed_x * delta_t
   self.pos_y = self.pos_y + self.speed_y * delta_t
end

function Ball:draw()
   local segments_in_circle = 8
   love.graphics.circle('fill', self.pos_x, self.pos_y, self.radius, segments_in_circle)   
end

return Ball