------------------------------
-- Bricks
------------------------------

local Class = require 'libs.hump.class'
local Brick = require 'classes.Brick'

local screen_width = love.graphics.getWidth()
local screen_height = love.graphics.getHeight()

local Bricks = Class{
   __includes = Brick,
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

   {200, 200, 200, 255} 
}

function Bricks:init(x, y, width, height, dist_x, dist_y, difficulty)

   if (difficulty <= 5) then
      self.rows = difficulty + 1
   elseif (difficulty < 10) then
      self.rows = difficulty - 3
   else
      self.rows = 6
   end
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

function Bricks:build(difficulty)
   for i = 1, self.rows do
      for j = 1, self.columns do
         local spawn = math.random(1, 100)
         -- Bricks have a (20 - difficulty * 2)% chance of not spawning
         if (spawn > 20 - difficulty * 2) then spawn = true else spawn = false end
         if spawn then 
   	      local horizontal_pos = self.top_left_pos_x + (j - 1) * (self.width + self.dist_x)
   		   local vertical_pos = self.top_left_pos_y + i * (self.height + self.dist_y)

            local color = math.random(1, 16)
            local btype = math.random(1, 100)
            -- Bricks have a 50 + floor(difficulty / 2) * 10% chance of being spawned as a type 2 brick
            if (btype > math.floor(difficulty / 2) * 10 + 50) then btype = 1 else btype = 2 end
   		   local brick = Brick(horizontal_pos, vertical_pos, self.width, self.height, btype, rgb[color])
   		   table.insert(self.current_bricks, brick)
         end
      end      
   end
   if (difficulty > 3 and difficulty < 6) then 
      local side = {"right", "left", "both"}
      self:putUnbreakableBrick(side[math.random(1, 3)])
   elseif difficulty >= 6 and difficulty < 9 then
      local position = {"top", "bottom"}
      self:putUnbreakableBrickRow(position[math.random(1, 2)])
   elseif difficulty == 9 then
      local position = {"top", "bottom"}
      local side = {"right", "left", "both"}
      self:putUnbreakableBrickRow(position[math.random(1, 2)])
      self:putUnbreakableBrickColumn(side[math.random(1, 2)])
   elseif difficulty == 10 then
      self:putUnbreakableBrickRow("top")
      self:putUnbreakableBrickColumn("both")
   end

end

function Bricks:putUnbreakableBrick(side)
   local vertical_pos = self.top_left_pos_y + (self.rows + 1) * (self.height + self.dist_y)
   local color = 17
   local btype = -1
   local horizontal_pos
   if (side == "right" or side == "both") then
      horizontal_pos = self.top_left_pos_x + (self.columns - 1) * (self.width + self.dist_x) + self.dist_x
      local brick = Brick(horizontal_pos, vertical_pos, self.width, self.height, btype, rgb[color])
      table.insert(self.current_bricks, brick)
   end
   if (side == "left" or side == "both") then
      horizontal_pos = self.top_left_pos_x - self.width - self.dist_x
      local brick = Brick(horizontal_pos, vertical_pos, self.width, self.height, btype, rgb[color])
      table.insert(self.current_bricks, brick)
   end
end

function Bricks:putUnbreakableBrickRow(position)
   local vertical_pos
   if position == "top" then vertical_pos = self.top_left_pos_y
   elseif position == "bottom" then vertical_pos = self.top_left_pos_y + (self.height + self.dist_y) * (self.rows + 1) end
   local color = 17
   local btype = -1
   for j = 1, self.columns do
      local horizontal_pos = self.top_left_pos_x + (j - 1) * (self.width + self.dist_x)
      local brick = Brick(horizontal_pos, vertical_pos, self.width, self.height, btype, rgb[color])
      table.insert(self.current_bricks, brick)
   end
end

function Bricks:putUnbreakableBrickColumn(side)
   local color = 17
   local btype = -1
   local horizontal_pos
   if (side == "right" or side == "both") then
      horizontal_pos = self.top_left_pos_x + (self.columns - 1) * (self.width + self.dist_x) + self.dist_x
      for i = 1, self.rows do
         vertical_pos = self.top_left_pos_y + i * (self.height + self.dist_y)
         local brick = Brick(horizontal_pos, vertical_pos, self.width, self.height, btype, rgb[color])
         table.insert(self.current_bricks, brick)
      end
   end
   if (side == "left" or side == "both") then
      horizontal_pos = self.top_left_pos_x - self.width - self.dist_x
      for i = 1, self.rows do
         vertical_pos = self.top_left_pos_y + i * (self.height + self.dist_y)
         local brick = Brick(horizontal_pos, vertical_pos, self.width, self.height, btype, rgb[color])
         table.insert(self.current_bricks, brick)
      end
   end
end

function Bricks:hit(i, bonus_set)
   local brick = self.current_bricks[i]
   brick:hit()
   if brick:isDestroyed() then
      table.remove(self.current_bricks, i)

      -- The power-ups are:
      -- 1 - extend_paddle  | 2 - shrink_paddle | 3 - speed_ball_up
      -- 4 - slow_ball_down | 5 - bonus_points  | 6 - extra_lives

      bonustype = math.random(1, 6)
      bonus_set:generate_bonus(15, brick.pos_x, brick.pos_y, 0, 150, bonustype)
   end
end

function Bricks:draw()
   for _, brick in pairs(self.current_bricks) do
      brick:draw()
   end
end

return Bricks
------------------------------
