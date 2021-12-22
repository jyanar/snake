-- SNAKE

require "globals"

function love.load()
    State.registerEvents()
    State.switch(States.start)
end

