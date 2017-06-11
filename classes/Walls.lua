------------------------------
-- Walls 
------------------------------

local Class = require 'libs.hump.class'
local Wall = require 'classes.Wall'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local Walls = Class{
   __includes = Wall
}

function Walls:init()
   self.thickness = 10
   self.current_walls = {}
end

function Walls:build()
   local left_wall = Wall(0, 0, self.thickness, love.graphics.getHeight())
   
   local right_wall = Wall(
      love.graphics.getWidth() - self.thickness, 0, self.thickness, love.graphics.getHeight())

   local top_wall = Wall(0, 0, love.graphics.getWidth(), self.thickness)

    self.current_walls["left"] = left_wall
    self.current_walls["right"] = right_wall
    self.current_walls["top"] = top_wall
end

function Walls:draw()
  love.graphics.setColor(0, 0, 0) --black 
  for _, wall in pairs(self.current_walls) do
    Wall:draw_wall(wall)
  end
end

return Walls
------------------------------
