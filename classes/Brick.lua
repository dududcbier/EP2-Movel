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
   self.image = love.graphics.newImage("img/brick.png")
   self.tileset_width = 384
   self.tileset_height = 160
end

function Brick:get_rect(brick)
   return { x = brick.pos_x, y = brick.pos_y, width = brick.width, height = brick.height }
end

function Brick:draw()
    love.graphics.setColor(self.color)
    if (self.btype == 1) then
      love.graphics.rectangle("line", self.pos_x, self.pos_y, self.width, self.height)
    else
      love.graphics.rectangle("fill", self.pos_x, self.pos_y, self.width, self.height)
    end
end

function Brick:hit()
  self.btype = self.btype - 1
end

function Brick:isDestroyed()
  return self.btype == 0
end

return Brick