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

level = Level(1)
rgb = { "red", "green", "blue" }

function Bricks:init(x, y, width, height, dist_x, dist_y)

   self.rows = level.number
   self.columns = ((screen_width - 100) / 60) --Brick width + dist_x = 60, pos_x to left and to the right = 50+50 = 100
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

         local color = math.random(1, 3)
         local btype = math.random(1, 2)
		   local brick = Brick(horizontal_pos, vertical_pos, self.width, self.height, btype, rgb[color])
		   table.insert(self.current_bricks, brick)
      end      
   end
end

function Bricks:hit_by_ball(i, brick, bonus_set)

   if brick.btype == 1 then
      table.remove(self.current_bricks, i)

      --The numbes 1 to 5 represents respectively:
      --{"increase_size_paddle", "reduce_size_paddle", "increase_speed_ball", "reduce_speed_ball", "more_balls"}
      bonustype = math.random(1, 4)

      bonus_set:generate_bonus(15, brick.pos_x, brick.pos_y, 0, 150, bonustype)

   elseif brick.btype == 2 then
      Brick:medium_to_cracked(brick)
   end

end

function Bricks:update(dt)
   for _, brick in pairs(self.current_bricks) do
      Brick:update_brick(brick)
   end
end

function Bricks:draw()
   for _, brick in pairs(self.current_bricks) do
      Brick:draw_brick(brick)
   end
end

return Bricks
------------------------------