------------------------------
-- Brick
------------------------------

local Class = require 'libs.hump.class'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local Brick = Class{}

function Brick:init(x, y, width, height, btype)
   self.pos_x = x
   self.pos_y = y
   self.width = width
   self.height = height
   self.btype = btype
end

function Brick:update_brick(b)
  --  bricks.total = #bricks.current_bricks
   
  --  if bricks.total == 0 then
  --    levels.number = levels.number + 1
  --    bricks.construct()
  --    ball.set_position(300, 300)
  -- end
end

function Brick:draw_brick(brick)

   --TODO: Discover how to call an internal function without losing the parameter value
   if (brick.btype == 1) then
      love.graphics.setColor(255, 0, 0)
      love.graphics.rectangle("fill", brick.pos_x, brick.pos_y, brick.width, brick.height)
   elseif (brick.btype == 2) then
      love.graphics.setColor(0, 255, 0)
      love.graphics.rectangle("fill", brick.pos_x, brick.pos_y, brick.width, brick.height)
   else
      love.graphics.setColor(0, 0, 255)
      love.graphics.rectangle("fill", brick.pos_x, brick.pos_y, brick.width, brick.height)
   end
   love.graphics.setColor(0, 0, 255)
    --local t = b.btype
    --love.graphics.newQuad(b.pos_x, b.pos_y, bricks.width, bricks.height, 500,160) 
end


function Brick:check_if_easy(brick)
   return brick.btype == 1
end

function Brick:check_if_medium(brick)
   return brick.btype == 2
end

function Brick:check_if_hard(brick)
   return brick.btype == 3
end

function Brick:medium_to_easy(brick)
   brick.btype = 1
   --bricks.redraw(brick)
end

function Brick:hard_to_medium(brick)
   brick.btype = 2
   --bricks.redraw(brick)
end

return Brick