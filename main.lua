------------------------------
--Breakout game
------------------------------

--Gamestate from the HUMP library
Gamestate = require 'libs.hump.gamestate'

-- Pull in each of our game states
local menuScreen = require 'gamestates.menuScreen'
local gameLevel1 = require 'gamestates.gameLevel1'
local pause = require 'gamestates.pauseScreen'

function love.load()
   img = love.graphics.newImage("img/sky_grass.jpg")
   Gamestate.registerEvents()
   Gamestate.switch(gameLevel1)
   --Gamestate.switch(menuScreen)
end

function love.keypressed(key)
   if key == "escape" then
      love.event.push("quit")
   end
end

function love.quit()
   print("Goodbye! Thanks for playing!")
end