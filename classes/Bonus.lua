-------------------------------------
-- Bonus (power-ups/downs)
-------------------------------------

local Class = require 'libs.hump.class'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local Bonus = Class{}

function Bonus:init(radius, pos_x, pos_y, speed_x, speed_y, bonustype)
   self.radius = radius
   self.pos_x = pos_x
   self.pos_y = pos_y
   self.speed_x = speed_x
   self.speed_y = speed_y
   self.bonustype = bonustype
   self.is_power_up = true
end

function Bonus:new_bonus(radius, pos_x, pos_y, speed_x, speed_y, bonustype)
   return( { radius = radius, pos_x = pos_x, pos_y = pos_y, 
             speed_x = speed_x, speed_y = speed_y, bonustype = bonustype} )
end

function Bonus:update_bonus(bonus, dt)
   bonus.pos_x = bonus.pos_x + bonus.speed_x * dt
   bonus.pos_y = bonus.pos_y + bonus.speed_y * dt
end

function Bonus:draw_bonus(bonus)
   local segments_in_circle = 16
   if (bonus.is_power_up == true) then
      love.graphics.setColor(51,102,255) --blue
   else
      love.graphics.setColor(255,0,0) --red
   end

   love.graphics.circle('fill', bonus.pos_x, bonus.pos_y, bonus.radius, segments_in_circle)
end

function Bonus:get_info(bonus)
   local diameter = 2 * bonus.radius
   return { x = bonus.pos_x - bonus.radius, y = bonus.pos_y - bonus.radius, width = diameter, height = diameter }
end


function Bonus:apply_effect(ball, paddle, bonus, score, level)

   if bonus.bonustype == "increase_size_paddle" then
      paddle:increase_size_paddle(paddle, 10)
   elseif bonus.bonustype == "reduce_size_paddle" then
      paddle:reduce_size_paddle(paddle, 10)
   elseif bonus.bonustype == "increase_speed_ball" then
      ball:increase_speed_ball(ball, 0.1)
   elseif bonus.bonustype == "reduce_speed_ball" then
      ball:reduce_speed_ball(ball, 0.1)
   elseif bonus.bonustype == "more_points" then
      score:update(level.number * 10)
   elseif bonus.bonustype == "more_lives" then
      level:increase_lives(1)
   end
    
end

return Bonus