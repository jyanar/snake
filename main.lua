-- Snake
-- [x] High score menu
-- [ ] sort high scores
-- [ ] Check whether killed on next turn, not after the fact
-- [ ] Smooth movement, but on a grid?
-- [ ] AI to play snake?

-- Libraries
Gamestate = require "libs/gamestate"
lume = require "libs/lume/lume"
require "libs/show"

-- Game states
state_pause = require "states.pause"
state_game  = require "states.game"
state_start = require "states.start"
state_leaderboard = require "states.leaderboard"
state_deathscreen = require "states.deathscreen"


function love.load()
    -- Fonts
    m5x7_16 = love.graphics.newFont('assets/m5x7.ttf', 16)
    m5x7_24 = love.graphics.newFont('assets/m5x7.ttf', 24)
    m5x7_32 = love.graphics.newFont('assets/m5x7.ttf', 32)
    m5x7_64 = love.graphics.newFont('assets/m5x7.ttf', 64)

    -- Sounds
    sound_death = love.audio.newSource("assets/death.wav", "static")
    sound_button = love.audio.newSource("assets/button.wav", "static")
    sound_egg = love.audio.newSource("assets/egg.wav", "static")


    Gamestate.registerEvents()
    Gamestate.switch(state_start)
end

