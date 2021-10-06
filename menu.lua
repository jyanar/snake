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
    love.graphics.rectangle('fill', snake.x * 10, snake.y * 10, 10, 10)
    for isegment, segment in ipairs(snake.tail) do
        love.graphics.rectangle('fill', segment.x * 10, segment.y * 10, 10, 10)
    end
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', egg.x * 10, egg.y * 10, 10, 10)
end

function menu:keypressed(key)
    if key == 'p' or key == 'escape' then
        Gamestate.pop()
    end

end

return menu

