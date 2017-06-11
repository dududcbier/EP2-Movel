------------------------------
-- Bricks
------------------------------

local Class = require 'libs.hump.class'
local Brick = require 'classes.Brick'
local Level = require 'classes.Level'
local BonusSet = require 'classes.BonusSet'

local screen_width = love.graphics.getWidth()
local screen_height = love.graphics.getHeight()

local Bricks = Class{
   __includes = Brick,
   __includes = Level,
   __includes = BonusSet
}

rgb = { -- http://paletton.com/#uid=7390u0ksRLGeIXqlSS7CRuOyiiE minus the darker colors
   {21, 213, 160, 255}, 
   {133, 245, 214, 255}, 
   {73, 231, 187, 255}, 
   {0, 161, 116, 255}, 

   {37, 117, 213, 255}, 
   {142, 189, 245, 255}, 
   {86, 152, 231, 255}, 
   {10, 79, 161, 255}, 

   {255, 166, 25, 255}, 
   {255, 210, 138, 255}, 
   {255, 187, 81, 255}, 
   {245, 150,  0, 255}, 

   {255, 108, 25, 255}, 
   {255, 180, 138, 255}, 
   {255, 144, 81, 255}, 
   {245, 89,  0, 255}, 
}

function Bricks:init(x, y, width, height, dist_x, dist_y, level)
   self.rows = 3 + level.number
   self.columns = ((screen_width - 40) / (width + dist_x))
   self.total = self.rows * self.columns
   self.top_left_pos_x = x
   self.top_left_pos_y = y
   self.width = width
   self.height = height
   self.dist_x = dist_x --horizontal distance between bricks
   self.dist_y = dist_y --vertical distance between bricks
   self.current_bricks = {}
end

function Bricks:build()
   for i = 1, self.rows do
      for j = 1, self.columns do
	      local horizontal_pos = self.top_left_pos_x + (j - 1) * (self.width + self.dist_x)
		   local vertical_pos = self.top_left_pos_y + (i - 1) * (self.height + self.dist_y)

         local color = math.random(1, 16)
         local btype = math.random(1, 2)
		   local brick = Brick(horizontal_pos, vertical_pos, self.width, self.height, btype, rgb[color])
		   table.insert(self.current_bricks, brick)
      end      
   end
end


function Bricks:hit_by_ball(i, brick, bonus_set)

   local brick = self.current_bricks[i]
   brick:hit()
   if brick:isDestroyed() then
      table.remove(self.current_bricks, i)
   
      --The numbes 1 to 6 represents respectively:
      --{"increase_size_paddle", "reduce_size_paddle", "increase_speed_ball",
      -- "reduce_speed_ball", "more_points", "more_lives"}
      math.randomseed(os.time() + math.random())
      bonustype = math.random(1, 6)

      bonus_set:generate_bonus(15, brick.pos_x, brick.pos_y, 0, 150, bonustype)

   elseif brick.btype == 2 then
      Brick:medium_to_cracked(brick)
   end
end

function Bricks:update(dt)
   for _, brick in pairs(self.current_bricks) do
      brick:update()
   end
end

function Bricks:draw()
   for _, brick in pairs(self.current_bricks) do
      brick:draw()
   end
end

return Bricks
------------------------------
