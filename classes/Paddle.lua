------------------------------
-- Paddle
------------------------------
local Class = require 'libs.hump.class'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local Paddle = Class{}

local value = 300
function Paddle:init(x, y, width, height, speed_x)
   self.pos_x = x
   self.pos_y = y
   self.width = width
   self.height = height
   self.speed_x = speed_x
end

function Paddle:hit_wall(horizontal_shift, vertical_shift)
   paddle.pos_x = paddle.pos_x + horizontal_shift
end

function Paddle:update(delta_t)
   if love.keyboard.isDown("right") then
       self.pos_x = self.pos_x + (self.speed_x * delta_t)
   end
   if love.keyboard.isDown("left") then
       self.pos_x = self.pos_x - (self.speed_x * delta_t)
   end

end

function Paddle:draw()
   love.graphics.rectangle('fill', self.pos_x, self.pos_y, self.width, self.height)
end

return Paddle
------------------------------