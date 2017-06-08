------------------------------
--Breakout game
------------------------------

--Gamestate from the HUMP library
Gamestate = require 'libs.hump.gamestate'

-- Pull in each of our game states
local menuScreen = require 'gamestates.menuScreen'
local gameLevel1 = require 'gamestates.gameLevel1'
local pause = require 'gamestates.pauseScreen'

local Score = require 'classes.Score'

--Get window width and height
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()


function love.load()

	highscore = {}
	score = Score(20, 20, 0)
   img = love.graphics.newImage("img/sky_grass.jpg")
   
   if not love.filesystem.exists("highscore.lua") then
      love.filesystem.newFile("highscore.lua")
      love.filesystem.write("highscore.lua", "Highscore\n=\n" .. score.highscore)
   end

   for line in love.filesystem.lines("highscore.lua") do
      table.insert(highscore, line)
   end

   score.highscore = highscore[3]
   love.filesystem.write("highscore.lua", "highscore\n=\n" .. score.highscore)

   --Gamestate.registerEvents()
   --Gamestate.switch(gameLevel1)
   --Gamestate.switch(menuScreen)
   gameLevel1:enter(score)

end


function love.update(dt)
	gameLevel1:update(dt)
end

function love.draw()
	gameLevel1:draw()
end

function love.keypressed(key)
   if key == "escape" then
      love.event.push("quit")
   end
end

function love.quit()
   print("Goodbye! Thanks for playing!")
end