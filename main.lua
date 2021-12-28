-- SNAKE

require "globals"

function love.load()
    love.mouse.setVisible(false)
    State.registerEvents()
    State.switch(States.start)
end

