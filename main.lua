-- Snake.
-- [x] Let's get a square on the screen
-- [x] Let's get the square to move around at a certain speed
-- [x] Let's get the square to respond to user input
-- [x] Let's get the square to wrap around at boundaries
-- [x] Let's randomly generate an egg at some point in the arena
-- [x] Let's make it such that the egg disappears (and is generated
--     somewhere else) whenever there's a collision
-- [x] Let's make it such that the snake cannot turn back
-- [x] Let's make it such that both the egg and the snake are on a grid 
--  [x] Given the gw and gh, generate grid
--  [x] Snake starts on a given gridspace, and moves on a timer
--  [x] Timer gets shorter with each egg consumed
-- [x] Let's make it such that the snake has a tail
--  [x] Single segment tail
--  [x] Multiple segment tail
-- [x] Tail gets longer when you eat an egg
-- [x] Walls kill you
-- [x] Tail collisions kill you
-- [ ] Inputting two keys in quick succession should result in that execution
--  [ ] Construct 2-length key buffer
-- [ ] Check whether killed on next turn, not after the fact

-- It's probably easier to move towards a grid system where movement is dictated
-- by timers instead of this dt * speed calculation.

function love.load()
    grid = {
        width = gw / 10,
        height = gh / 10
    }
    snake = {
        x = 10,
        y = 10,
        alive = true,
        currdir = 'down',
        nextdir = 'down',
        speed = 0.1,
        tail = {[1] = {x = 10, y = 9},
                [2] = {x = 10, y = 8},
                [3] = {x = 10, y = 7}}
    }
    egg = {
        x = love.math.random(0, gw / 10),
        y = love.math.random(0, gh / 10)
    }
    buffer = {[1] = '', [2] = ''}
    time = love.timer.getTime()
end

function love.update(dt)
    -- If alive, then update
    if snake.alive then
        -- Update snake position, if requisite time has passed
        if (love.timer.getTime() - time) > snake.speed then
            time = love.timer.getTime()
            -- Check whether user has provided input
            if snake.currdir ~= snake.nextdir then
                movesnake(snake, snake.nextdir)
                snake.currdir = snake.nextdir
            else
                movesnake(snake, snake.currdir)
            end
            -- Hit wall, die
            if snake.x > grid.width - 1  then snake.alive = false end
            if snake.x < 0               then snake.alive = false end
            if snake.y > grid.height - 1 then snake.alive = false end
            if snake.y < 0               then snake.alive = false end
            -- Hit self, die
            -- Check whether head segment is hitting any tail segments. If so,
            -- die
            for _, seg in ipairs(snake.tail) do
                if snake.x == seg.x and snake.y == seg.y then
                    snake.alive = false
                end
            end

            -- -- Wrap around
            -- if snake.x > grid.width - 1  then snake.x = 0           end
            -- if snake.x < 0               then snake.x = grid.width  end
            -- if snake.y > grid.height - 1 then snake.y = 0           end
            -- if snake.y < 0               then snake.y = grid.height end
            -- Egg consumed
            if (egg.x == snake.x) and (egg.y == snake.y) then
                -- Update egg location
                egg.x, egg.y = love.math.random(1, grid.width - 1), love.math.random(1, grid.height - 1)
                -- Snake moves faster now
                snake.speed = snake.speed - 0.01
                -- Add another tail segment
                local lastsegment = snake.tail[#snake.tail]
                snake.tail[#snake.tail + 1] = {x = lastsegment.x, y = lastsegment.y}
            end
        end
    else
        -- local x = io.read()
    end
end


function love.draw()
    -- Let's make the grid have points every 10 pixels. To do this,
    -- we round down to the nearest factor of 10
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', snake.x * 10, snake.y * 10, 10, 10)
    for isegment, segment in ipairs(snake.tail) do
        love.graphics.rectangle('fill', segment.x * 10, segment.y * 10, 10, 10)
    end
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', egg.x * 10, egg.y * 10, 10, 10)
end


function love.keypressed(key)
    if     key == 'up'    and snake.currdir ~= 'down'  then snake.nextdir = 'up'
    elseif key == 'down'  and snake.currdir ~= 'up'    then snake.nextdir = 'down'
    elseif key == 'left'  and snake.currdir ~= 'right' then snake.nextdir = 'left'
    elseif key == 'right' and snake.currdir ~= 'left'  then snake.nextdir = 'right'
    end
end


function isvaliddir(currdir, nextdir)
    if currdir == 'up'    and nextdir == 'down'  then return false end
    if currdir == 'down'  and nextdir == 'up'    then return false end
    if currdir == 'left'  and nextdir == 'right' then return false end
    if currdir == 'right' and nextdir == 'left'  then return false end
    return true
end


function movesnake(snake, dir)
    -- Move tail segments
    for i = #snake.tail, 2, -1 do
        snake.tail[i].x = snake.tail[i - 1].x
        snake.tail[i].y = snake.tail[i - 1].y
    end
    snake.tail[1].x, snake.tail[1].y = snake.x, snake.y
    -- Now move the head
    if snake.currdir == 'up' then
        snake.y = snake.y - 1
    elseif snake.currdir == 'down' then
        snake.y = snake.y + 1
    elseif snake.currdir == 'left' then 
        snake.x = snake.x - 1
    elseif snake.currdir == 'right' then
        snake.x = snake.x + 1
    end
end




