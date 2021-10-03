-- Snake.
-- [x] Let's get a square on the screen
-- [x] Let's get the square to move around at a certain speed
-- [x] Let's get the square to respond to user input
-- [x] Let's get the square to wrap around at boundaries
-- [x] Let's randomly generate an egg at some point in the arena
-- [x] Let's make it such that the egg disappears (and is generated
--     somewhere else) whenever there's a collision
-- [x] Let's make it such that the snake cannot turn back
-- [ ] Let's make it such that the snake has a tail
-- [ ] Let's make it such that both the egg and the snake are on a grid 

-- It's probably easier to move towards a grid system where movement is dictated
-- by timers instead of this dt * speed calculation.

function love.load()
    snake = {
        x = 10, y = 10, direction='down', speed=100, taillength=2
    }
    egg = {
        x = love.math.random(0, gw), y = love.math.random(0, gh)
    }
end

function love.update(dt)
    -- Snake movement
    if     snake.direction == 'up'    then snake.y = snake.y - dt * snake.speed
    elseif snake.direction == 'down'  then snake.y = snake.y + dt * snake.speed
    elseif snake.direction == 'left'  then snake.x = snake.x - dt * snake.speed
    elseif snake.direction == 'right' then snake.x = snake.x + dt * snake.speed
    end
    if snake.x > gw then snake.x = 0  end
    if snake.x < 0  then snake.x = gw end
    if snake.y > gh then snake.y = 0  end
    if snake.y < 0  then snake.y = gh end
    -- Check whether snake and egg are colliding
    distance = ((snake.x - egg.x)^2 + (snake.y - egg.y)^2)^0.5
    if distance < 10 then
        egg.x, egg.y = love.math.random(0, gw), love.math.random(0, gh)
    end
end

function love.draw()
    -- Let's make the grid have points every 10 pixels. To do this,
    -- we round down to the nearest factor of 10
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', snake.x, snake.y, 10, 10)
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle('fill', egg.x, egg.y, 7, 100)
end

function love.keypressed(key)
    if     key == 'up'    and snake.direction ~= 'down'  then snake.direction = 'up'
    elseif key == 'down'  and snake.direction ~= 'up'    then snake.direction = 'down'
    elseif key == 'left'  and snake.direction ~= 'right' then snake.direction = 'left'
    elseif key == 'right' and snake.direction ~= 'left'  then snake.direction = 'right'
    end
end






