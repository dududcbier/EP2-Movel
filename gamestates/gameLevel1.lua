-- Import our libraries.
Gamestate = require 'libs.hump.gamestate'
Class = require 'libs.hump.class'

--Get window width and height
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

-- Create our Gamestate
local gameLevel1 = Gamestate.new()

-- Import the Classes
local Ball = require 'classes.Ball'
local Paddle = require 'classes.Paddle'
local Bricks = require 'classes.Bricks'
local Walls = require 'classes.Walls'
local Collisions = require 'classes.Collisions'

-- Important variables
local ball = nil
local paddle = nil
local bricks = nil
local walls = nil
local collisions = nil

function love.load()
    img = love.graphics.newImage("../img/sky_grass.jpg")
    Gamestate.registerEvents()
    --Gamestate.switch(menu)
end


function gameLevel1:enter()
  ball = Ball(300, 300, 10, 300, 300)
  paddle = Paddle(width - width/2, height - height/10, 70, 20, 320)
  
  bricks = Bricks(width/18, height/10, width/18, height/16, 10, 15)
  bricks:build()

  walls = Walls()
  walls:build()

  collisions = Collisions(ball, paddle, bricks, walls)
end

function gameLevel1:update(dt)
  ball:update(dt)
  paddle:update(dt)
  bricks:update(dt)
  collisions:treat(ball, paddle, bricks, walls)
end

function gameLevel1:draw()
  
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(img, 0, 0)

  ball:draw()
  love.graphics.setColor(0,0,0) --black
  paddle:draw()

  love.graphics.setColor(0,0,139) --darkblue
  bricks:draw()
  walls:draw()
end

return gameLevel1
