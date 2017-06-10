------------------------------
--Breakout game
------------------------------

--Gamestate from the HUMP library
Gamestate = require 'libs.hump.gamestate'

-- Pull in each of our game states
local menuScreen = require 'gamestates.menuScreen'
local GameLevel = require 'gamestates.gameLevel'
local pause = require 'gamestates.pauseScreen'
local gameOver = require 'gamestates.gameOverScreen'

local Score = require 'classes.Score'

--Get window width and height
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()


function love.load()

	highscore = {}
	score = Score(width/20, 20, 0)
   
   if not love.filesystem.exists("highscore.lua") then
      love.filesystem.newFile("highscore.lua")
      love.filesystem.write("highscore.lua", "Highscore\n=\n" .. score.highscore)
   end

   for line in love.filesystem.lines("highscore.lua") do
      table.insert(highscore, line)
   end

   score.highscore = highscore[3]
   love.filesystem.write("highscore.lua", "highscore\n=\n" .. score.highscore)

   local enter_first_time = true
   gameLevel = GameLevel()
   gameLevel:enter(score, enter_first_time)

end


function love.update(dt)
	if gameLevel.gameOver == false then
	   gameLevel:update(dt)
   end
end

function love.draw()
	if gameLevel.gameOver == false then
	   gameLevel:draw()
	else
		gameOver:draw()
	end
end

function love.keypressed(key)
   if key == "escape" then
      love.event.push("quit")
   end
end

function love.mousepressed(x, y, button, istouch)
   gameLevel:mousepressed(x,y)
end

function love.quit()
   print("Goodbye! Thanks for playing!")
end