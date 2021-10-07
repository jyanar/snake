local menu = {}

function menu:init()
    -- self.background = love.graphics.newImage('bg.png')
end

function menu:enter(previous) -- runs every time the state is entered
end

function menu:update(dt) -- runs every frame
end

function menu:draw()
    -- love.graphics.draw(self.background, 0, 0)
    love.graphics.printf('Press esc or p to continue', 0, 100, 400, 'center')
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', snake.gridx * 10, snake.gridy * 10, 10, 10)
    for isegment, segment in ipairs(snake.tail) do
        love.graphics.rectangle('fill', segment.gridx * 10, segment.gridy * 10, 10, 10)
    end
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', egg.gridx * 10, egg.gridy * 10, 10, 10)
end

function menu:keypressed(key)
    if key == 'p' or key == 'escape' then
        Gamestate.pop()
    end

end

return menu

