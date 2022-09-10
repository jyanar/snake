-- Libraries
Lume   = require "libs.lume"
Object = require "libs.classic"
Flux   = require "libs.flux"
Show   = require "libs.show"
State  = require "libs.state"
Timer  = require "libs.timer"
Inspect = require "libs.inspect"

-- Fonts
Fonts = {
    size16 = love.graphics.newFont("assets/m5x7.ttf", 16),
    size24 = love.graphics.newFont("assets/m5x7.ttf", 24),
    size32 = love.graphics.newFont("assets/m5x7.ttf", 32),
    size64 = love.graphics.newFont("assets/m5x7.ttf", 64),
    size128 = love.graphics.newFont("assets/m5x7.ttf", 128),
}

love.graphics.setDefaultFilter("nearest", "nearest")
-- Art
Art = {
    head  = love.graphics.newImage("assets/head.bmp"),
    apple = love.graphics.newImage("assets/apple.png"),
    human = love.graphics.newImage("assets/human.png"),
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

-- Objects
Obj = {
    snake = require "obj.snake"
}
