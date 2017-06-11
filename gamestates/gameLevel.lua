-- Import our libraries.
--Gamestate = require 'libs.hump.gamestate'
Class = require 'libs.hump.class'

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
local level = nil
local launched
local DEFAULT_PADDLE_WIDTH = 70
local DEFAULT_BALL_RADIUS = 10


level = Level(width/4, 20, 1, 5)

local gameLevel = Class{}

function gameLevel:init()
   self.gameOver = false
end

function gameLevel:enter(score_obj, enter_first_time)

   ball = Ball(width - width/2, height - height/10 - DEFAULT_BALL_RADIUS, DEFAULT_BALL_RADIUS, 0, 0)
   paddle = Paddle(width - width/2 - DEFAULT_PADDLE_WIDTH / 2, height - height/10, DEFAULT_PADDLE_WIDTH, 20, 320)

   if enter_first_time then
      bricks = Bricks(width/18, height/10, width/18, height/16, 8, 8, level)
      bricks:build()
   end

   walls = Walls()
   walls:build()

   score = score_obj
   bonus_set = BonusSet()

   collisions = Collisions(ball, paddle, bricks, walls, score)
   launched = false
end


function gameLevel:update(dt)
    if launched then
      ball:update(dt)
      paddle:update(dt)
      bricks:update(dt)
      bonus_set:update(dt)
      level:update_lives(dt)
      collisions:treat(ball, paddle, bricks, walls, score, bonus_set, level)
    end

    if score.account > tonumber(score.highscore) then
      score.highscore = score.account
      love.filesystem.write("highscore.lua", "Highscore\n=\n" .. score.highscore)
    end

    local pos = ball:get_position(ball)
    if pos.y > height + 10 then
      local enter_first_time = false
      level:decrease_lives(1)

      if level.lives == 0 then
         self.gameOver = true
         over_song = love.audio.newSource("music/bomb_falling_exploding.wav", "static")
         over_song:play()
         score:reset()
      end
      gameLevel:enter(score, enter_first_time)
    end
end


function gameLevel:mousepressed(x, y)
  if launched then
    paddle:mousepressed(x)
  else
    local delta_x = x - ball:getX()
    local delta_y = y - ball:getY()
    local norm = math.sqrt(delta_x * delta_x + delta_y * delta_y)
    local speed_x = 500 * delta_x / norm
    local speed_y = 500 * delta_y / norm
    if speed_y > 0 then 
      speed_y = -speed_y
    end
    ball:launch(speed_x, speed_y)
    launched = true
  end
end


function gameLevel:draw()
  
   love.graphics.setColor(255, 255, 255)
   love.graphics.setBackgroundColor(22, 22, 22)

   ball:draw()
   love.graphics.setColor(200, 200, 200) --light gray
   paddle:draw()

   bricks:draw()
   love.graphics.setColor(0, 0, 0) --black
   walls:draw()

   score:draw()
   level:draw_lives()

   bonus_set:draw()


end

return gameLevel
