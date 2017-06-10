-- Import our libraries.
--Gamestate = require 'libs.hump.gamestate'
Class = require 'libs.hump.class'

--Get window width and height
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

-- Create our Gamestate
local gameLevel = Gamestate.new()

-- Import the Classes
local Ball = require 'classes.Ball'
local Paddle = require 'classes.Paddle'
local Bricks = require 'classes.Bricks'
local Walls = require 'classes.Walls'
local Collisions = require 'classes.Collisions'
local BonusSet = require 'classes.BonusSet'

local Level = require 'classes.Level'

-- Important variables
local ball = nil
local paddle = nil
local bricks = nil
local walls = nil
local collisions = nil
local bonus_set = nil

local score = nil

function gameLevel:enter(score_obj)
  
  self.gameOver = false

  ball = Ball(300, 300, 10, 300, 300)
  paddle = Paddle(width - width/2, height - height/10, 70, 20, 320)
  
  bonus_set = BonusSet()
  
  bricks = Bricks(width/18, height/10, width/18, height/16, 10, 15)
  bricks:build()

  walls = Walls()
  walls:build()

  score = score_obj

  collisions = Collisions(ball, paddle, bricks, walls, score)
end

function gameLevel:update(dt)

   ball:update(dt)
   paddle:update(dt)
   bricks:update(dt)

   bonus_set:update(dt)
   
   collisions:treat(ball, paddle, bricks, walls, bonus_set)

   if score.account > tonumber(score.highscore) then
      score.highscore = score.account
      love.filesystem.write("highscore.lua", "Highscore\n=\n" .. score.highscore)
   end

   local pos = ball:get_position(ball)
   if pos.y > height + 10 then
     self.gameOver = true
     over_song = love.audio.newSource("music/bomb_falling_exploding.wav", "static")
     over_song:play()
   end

end

function gameLevel:draw()
  
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

  --love.graphics.setColor(139,0,0) Put the correct color according with bonustype
   bonus_set:draw()

end

return gameLevel
