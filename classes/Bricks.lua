------------------------------
-- Bricks
------------------------------

local Class = require 'libs.hump.class'
local Brick = require 'classes.Brick'
local Level = require 'classes.Level'

local screen_width = love.graphics.getWidth()
local screen_height = love.graphics.getHeight()

local Bricks = Class{
   __includes = Brick,
   __includes = Level
}

level = Level(1)

function Bricks:init(x, y, width, height, dist_x, dist_y)
   ---------------------------------
-- IMPORTANT: Fix rows, columns and
--also the levels
 ---------------------------------
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

        local number = math.random(1, 3)
		    local brick = Brick(horizontal_pos, vertical_pos, self.width, self.height, number)
		    table.insert(self.current_bricks, brick)
      end      
   end
end

function Bricks:hit_by_ball(i, brick, horizontal_shift, vertical_shift)
   
   table.remove(self.current_bricks, i)
   level:update_score(1)
   -- if bricks.check_if_easy(brick) then
   --    table.remove(bricks.current_bricks, i)
   -- elseif bricks.check_if_medium(brick) then
   --    bricks.medium_to_easy(brick)
   -- else
   --    bricks.hard_to_medium(brick)
   -- end

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
