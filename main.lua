-- Snake.
-- [ ] High score menu
-- [ ] Check whether killed on next turn, not after the fact
-- [ ] Smooth movement, but on a grid?
-- [x] hump integration
Gamestate = require "libs/gamestate"
menu = require "menu"
game = require "game"
highscore = require "highscore"

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(game)
end

-- function love.update(dt)
-- end


-- function love.draw()
-- end






