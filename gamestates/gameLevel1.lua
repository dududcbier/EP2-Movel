-- Import our libraries.
--Gamestate = require 'libs.hump.gamestate'
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

local Level = require 'classes.Level'

-- Important variables
local ball = nil
local paddle = nil
local bricks = nil
local walls = nil
local score = nil
local collisions = nil


function gameLevel1:enter(score_obj)

  ball = Ball(300, 300, 10, 300, 300)
  paddle = Paddle(width - width/2, height - height/10, 70, 20, 320)
  
  bricks = Bricks(width/18, height/10, width/18, height/16, 10, 15)
  bricks:build()

  walls = Walls()
  walls:build()

  score = score_obj

  collisions = Collisions(ball, paddle, bricks, walls, score)
end

function gameLevel1:update(dt)

   ball:update(dt)
   paddle:update(dt)
   bricks:update(dt)
   collisions:treat(ball, paddle, bricks, walls)

   if score.account > tonumber(score.highscore) then
      score.highscore = score.account
      love.filesystem.write("highscore.lua", "Highscore\n=\n" .. score.highscore)
   end

   local pos = ball:get_position(ball)
   if pos.y > height + 10 then
     gameOver = true
     over_song = love.audio.newSource("music/bomb_falling_exploding.wav", "static")
     over_song:play()
   end

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

  love.graphics.setColor(139,0,0) --darkblue
  score:draw()
end

return gameLevel1
