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
                  "more_balls", "increase_speed_ball", "reduce_speed_ball"}

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
   print("Inside add")
   table.insert(self.current_bonus, bonus)
end

function BonusSet:remove(bonus)
   table.remove(self.current_bonus, bonus)
end


function BonusSet:clear_current_level_bonus()
   for i in pairs(bonus.current_bonus) do
      bonus.current_bonus[i] = nil
   end
end

function Bonus:generate_bonus(pos_x, pos_y, bonustype)
   power = possible_power[bonustype]
   if self.valid_bonustype(self, power) then
      info_bonus = Bonus:new_bonus(pos_x, pos_y, power)
      print("info_bonus")
      print(info_bonus.pos_x, info_bonus.pos_y, info_bonus.bonustype)
      self.add(self, info_bonus)
   end
end

function Bonus:valid_bonustype(bonustype)
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