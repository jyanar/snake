-- Snake.
-- [x] High score menu
-- [ ] sort high scores
-- [ ] Check whether killed on next turn, not after the fact
-- [ ] Smooth movement, but on a grid?

-- Libraries
Gamestate = require "libs/gamestate"
lume = require "libs/lume/lume"
require "libs/show"

-- Game states
pause = require "pause"
game = require "game"
start = require "start"
leaderboard = require "leaderboard"
deathscreen = require "deathscreen"

function love.load()
    m5x7_16 = love.graphics.newFont('m5x7.ttf', 16)
    m5x7_24 = love.graphics.newFont('m5x7.ttf', 24)
    m5x7_32 = love.graphics.newFont('m5x7.ttf', 32)
    m5x7_64 = love.graphics.newFont('m5x7.ttf', 64)
    Gamestate.registerEvents()
    Gamestate.switch(start)
    -- Gamestate.switch(leaderboard)
end

