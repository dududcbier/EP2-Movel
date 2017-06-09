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

local launched = false

local DEFAULT_PADDLE_WIDTH = 70
local DEFAULT_BALL_RADIUS = 10


function gameLevel1:enter(score_obj)

  ball = Ball(width - width/2, height - height/10 - DEFAULT_BALL_RADIUS, DEFAULT_BALL_RADIUS, 0, 0)
  paddle = Paddle(width - width/2 - DEFAULT_PADDLE_WIDTH / 2, height - height/10, DEFAULT_PADDLE_WIDTH, 20, 320)
  
  bricks = Bricks(width/18, height/10, width/18, height/16, 10, 15)
  bricks:build()

  walls = Walls()
  walls:build()

  score = score_obj

  collisions = Collisions(ball, paddle, bricks, walls, score)
end

function gameLevel1:update(dt)
    if launched then
      ball:update(dt)
      paddle:update(dt)
      bricks:update(dt)
      collisions:treat(ball, paddle, bricks, walls)
    end

    if (not launched and (love.mouse.isDown("1") or love.keyboard.isDown("space"))) then
      local delta_x = love.mouse.getX() - ball:getX()
      local delta_y = love.mouse.getY() - ball:getY()
      local norm = math.sqrt(delta_x * delta_x + delta_y * delta_y)
      local speed_x = -450 * math.abs(delta_x / norm)
      local speed_y = -450 * math.abs(delta_y / norm)
      ball:launch(speed_x, speed_y)
      launched = true
    end

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
