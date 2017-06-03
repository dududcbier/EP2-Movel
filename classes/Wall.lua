------------------------------
-- Wall
------------------------------

local Class = require 'libs.hump.class'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local Wall = Class{}

function Wall:init(pos_x, pos_y, width, height)
   self.pos_x = pos_x
   self.pos_y = pos_y
   self.width = width
   self.height = height 
end

function Wall:get_rect(wall)
   return { x = wall.pos_x, y = wall.pos_y, width = wall.width, height = wall.height } 
end

function Wall:draw_wall(wall)
   love.graphics.rectangle('fill', wall.pos_x, wall.pos_y, wall.width, wall.height)
end

return Wall