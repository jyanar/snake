-- Libraries
Lume    = require "libs.lume"
Classic = require "libs.classic"
Flux    = require "libs.flux"
Show    = require "libs.show"
State   = require "libs.state"
Timer   = require "libs.timer"

-- Fonts
Fonts = {
    size16 = love.graphics.newFont("assets/m5x7.ttf", 16),
    size24 = love.graphics.newFont("assets/m5x7.ttf", 24),
    size32 = love.graphics.newFont("assets/m5x7.ttf", 32),
    size64 = love.graphics.newFont("assets/m5x7.ttf", 64),
}

-- Sounds
Sounds = {
    death  = love.audio.newSource("assets/death.wav", "static"),
    button = love.audio.newSource("assets/button.wav", "static"),
    egg    = love.audio.newSource("assets/egg.wav", "static"),
}

-- States
States = {
    start       = require "states.start",
    game        = require "states.game",
    pause       = require "states.pause",
    leaderboard = require "states.leaderboard",
    deathscreen = require "states.deathscreen",
}
