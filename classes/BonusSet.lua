-------------------------------------
-- Bonus (power-ups/downs)
-------------------------------------

local Class = require 'libs.hump.class'
local Bonus = require 'classes.Bonus'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local BonusSet = Class{
   __includes = Bonus
}


possible_power = {"increase_size_paddle", "reduce_size_paddle", 
                  "increase_speed_ball", "reduce_speed_ball", "more_points", "more_lives"}

function BonusSet:init()
   self.current_bonus = {}
end


function BonusSet:update(dt)
   for _, bonus in pairs(self.current_bonus) do
      Bonus:update_bonus(bonus, dt)
   end
end

function BonusSet:draw()
   for _, bonus in pairs(self.current_bonus) do
      Bonus:draw_bonus(bonus)
   end
end

function BonusSet:add(bonus)
   table.insert(self.current_bonus, bonus)
end

function BonusSet:remove(i)
   self.current_bonus[i] = nil
end


function BonusSet:clear_current_level_bonus()
   for i in pairs(bonus.current_bonus) do
      self.current_bonus[i] = nil
   end
end

function BonusSet:generate_bonus(radius, pos_x, pos_y, speed_x, speed_y, bonustype)
   power = possible_power[bonustype]
   if self.valid_bonustype(self, power) then

      bonus = Bonus(radius, pos_x, pos_y, speed_x, speed_y, power)

      if power == "reduce_size_paddle" or power == "increase_speed_ball" then
         bonus.is_power_up = false
      end

      print(bonus.bonustype)
      self.add(self, bonus)
   end
end

function BonusSet:valid_bonustype(bonustype)
   if bonustype then
      for _, item in ipairs(possible_power) do
         if item == bonustype then
            return true
         end
      end
   end
   return false
end


return BonusSet