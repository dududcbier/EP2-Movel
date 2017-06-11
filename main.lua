------------------------------
--Breakout game
------------------------------

--Gamestate from the HUMP library
Gamestate = require 'libs.hump.gamestate'

-- Pull in each of our game states
Menu = require 'gamestates.menuScreen'
Game = require 'gamestates.game'
-- pause = require 'gamestates.pauseScreen'

local Score = require 'classes.Score'

--Get window width and height
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()


function love.load()
   math.randomseed(os.time())
   math.random() -- First random number is always the same in macOS
   Gamestate.registerEvents()
   Gamestate.switch(Menu)
end