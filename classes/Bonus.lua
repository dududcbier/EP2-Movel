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
   if self.bonustype == "shrink_paddle" or self.bonustype == "speed_ball_up" then
      self.is_power_up = false
   else
      self.is_power_up = true
   end
end

function Bonus:new_bonus(radius, pos_x, pos_y, speed_x, speed_y, bonustype)
   return( { radius = radius, pos_x = pos_x, pos_y = pos_y, 
             speed_x = speed_x, speed_y = speed_y, bonustype = bonustype} )
end

function Bonus:update_bonus(bonus, dt)
   bonus.pos_x = bonus.pos_x + bonus.speed_x * dt
   bonus.pos_y = bonus.pos_y + bonus.speed_y * dt
end

function Bonus:draw_bonus()
   local segments_in_circle = 16
   if (self.is_power_up) then
      love.graphics.setColor(51,102,255) --blue
   else
      love.graphics.setColor(255,0,0) --red
   end

   love.graphics.circle('fill', self.pos_x, self.pos_y, self.radius, segments_in_circle)
end

function Bonus:get_info(bonus)
   local diameter = 2 * bonus.radius
   return { x = bonus.pos_x - bonus.radius, y = bonus.pos_y - bonus.radius, width = diameter, height = diameter }
end


function Bonus:apply_effect(ball, paddle, bonus, score, level)

   if bonus.bonustype == "extend_paddle" then
      paddle:extend(0.3)
   elseif bonus.bonustype == "shrink_paddle" then
      paddle:shrink(0.3)
   elseif bonus.bonustype == "speed_ball_up" then
      ball:speed_up(0.1)
   elseif bonus.bonustype == "slow_ball_down" then
      ball:slow_down(0.1)
   elseif bonus.bonustype == "bonus_points" then
      score:update(level.difficulty * 10)
   elseif bonus.bonustype == "extra_lives" then
      level:increase_lives(1)
   end

end

return Bonus