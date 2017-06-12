-- Import our libraries.
Gamestate = require 'libs.hump.gamestate'
Class = require 'libs.hump.class'

--Get window width and height
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

-- Create our Gamestate
local Game = {}

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
local score = nil
local collisions = nil
local level = nil

local launched

local DEFAULT_PADDLE_WIDTH = 70
local DEFAULT_BALL_RADIUS = 10

local music = love.audio.newSource("music/background.mp3", "static")

function Game:enter(from, score_obj, number, difficulty, lives)

  music:stop()
  music:play()

  level = Level(number, difficulty, lives)
  
  bricks = Bricks(width/18, height/10, width/18, height/16, 8, 8, difficulty)
  bricks:build(difficulty)

  walls = Walls()
  walls:build()

  score = score_obj
  bonus_set = BonusSet()

  Game:startGame()

  collisions = Collisions(ball, paddle, bricks, walls, score)
end

function Game:startGame()
   ball = Ball(width - width/2, height - height/10 - DEFAULT_BALL_RADIUS, DEFAULT_BALL_RADIUS, 0, 0)
   paddle = Paddle(width - width/2 - DEFAULT_PADDLE_WIDTH / 2, height - height/10, DEFAULT_PADDLE_WIDTH, 20, 320)
   launched = false
end

function Game:update(dt)
    dt = math.min(dt, 0.016)
    if launched then
      ball:update(dt)
      paddle:update(dt)
      bonus_set:update(dt)
      level:update(dt)
      collisions:treat(ball, paddle, bricks, walls, score, bonus_set, level)
    end

    if score.account > tonumber(score.highscore) then
      score.highscore = score.account
      love.filesystem.write("highscore.lua", "Highscore\n=\n" .. score.highscore)
    end

    local pos = ball:get_position(ball)
   if pos.y > height + 10 then
      over_song = love.audio.newSource("music/bomb_falling_exploding.wav", "static")
      over_song:play()
      level:decrease_lives(1)
      --Game Over
      if (level.lives == 0) then
         score:reset()
         music:stop()
         Gamestate.switch(Menu)
      --Continue game
      else
         Game:startGame()
      end
   end

   --Next level
   if bricks.total == 0 then
      if (level.difficulty < 10) then
         level.difficulty = level.difficulty + 1
      end
      level.number = level.number + 1
      Game:enter(Game, score, level.number, level.difficulty, level.lives)
   end
end

function Game:mousepressed(x, y)
  self:clicked(x, y)
end

function Game:touchpressed(id, x, y, dx, dy, pressure)
   self:clicked(x, y)
end

function Game:touchmoved(id, x, y, dx, dy, pressure)
   self:clicked(x, y)
end

function Game:clicked(x, y) 
  if (pointInRectangle(x, y, width-20, 0, 20, 20)) then
    Gamestate.switch(Menu)
  else
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
end

function Game:draw()
  
  love.graphics.setBackgroundColor(22, 22, 22)

  ball:draw()
  paddle:draw()
  level:draw()
  bricks:draw()
  walls:draw()
  score:draw()
  bonus_set:draw()

  love.graphics.setColor({200, 200, 200, 255})
  love.graphics.rectangle("fill", width - 20, 0, 20, 20)

end

function pointInRectangle(pointx, pointy, rectx, recty, rectwidth, rectheight)
    return pointx > rectx and pointy > recty and pointx < rectx + rectwidth and pointy < recty + rectheight
end

return Game
