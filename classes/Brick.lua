------------------------------
-- Brick
------------------------------

local Class = require 'libs.hump.class'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local Brick = Class{}

function Brick:init(x, y, width, height, btype, color)
   self.pos_x = x
   self.pos_y = y
   self.width = width
   self.height = height
   self.btype = btype
   self.color = color
   self.tileset_width = 384
   self.tileset_height = 160
end

function Brick:get_rect(brick)
   return { x = brick.pos_x, y = brick.pos_y, width = brick.width, height = brick.height }
end

function Brick:update(b)
  --  bricks.total = #bricks.current_bricks
   
  --  if bricks.total == 0 then
  --    levels.number = levels.number + 1
  --    bricks.construct()
  --    ball.set_position(300, 300)
  -- end
end

function Brick:draw()

    love.graphics.setColor(self.color)

    if (self.btype == 1) then
      love.graphics.rectangle("line", self.pos_x, self.pos_y, self.width, self.height)
    elseif (self.btype == 2) then
      love.graphics.rectangle("fill", self.pos_x, self.pos_y, self.width, self.height)
    end

   love.graphics.setColor(0, 0, 255)
end

function Brick:hit()
  self.btype = self.btype - 1
end

function Brick:isDestroyed()
  return self.btype == 0
end

-- function Brick:check_if_easy(brick)
--    return brick.btype == 1
-- end

-- function Brick:check_if_medium(brick)
--    return brick.btype == 2
-- end

function Brick:medium_to_cracked(brick)
   brick.btype = 1
end

return Brick