local game = {}

function game:init()
    grid = {
        width = gw / 10,
        height = gh / 10
    }
    snake = {
        x = 10,
        y = 10,
        alive = true,
        currdir = 'down',
        speed = 0.1,
        tail = {[1] = {x = 10, y = 9},
                [2] = {x = 10, y = 8},
                [3] = {x = 10, y = 7}}
    }
    dirbuffer = {[1] = '', [2] = ''}
    egg = {
        x = love.math.random(0, gw / 10),
        y = love.math.random(0, gh / 10)
    }
    time = love.timer.getTime()
end


function game:update(dt)
    if snake.alive then
        -- Update snake position, if requisite time has passed
        if (love.timer.getTime() - time) > snake.speed then
            time = love.timer.getTime()
            -- Check whether user has provided input
            if dirbuffer[1] == '' then
                movesnake(snake, snake.currdir)
            else
                movesnake(snake, dirbuffer[1])
                snake.currdir = dirbuffer[1]
                -- Update dirbuffer
                dirbuffer[1] = dirbuffer[2]
                dirbuffer[2] = ''
            end

            -- Hit wall, die
            if snake.x > grid.width - 1  then snake.alive = false end
            if snake.x < 0               then snake.alive = false end
            if snake.y > grid.height - 1 then snake.alive = false end
            if snake.y < 0               then snake.alive = false end
            -- Hit self, die
            for _, seg in ipairs(snake.tail) do
                if is_same_location(snake, seg) then snake.alive = false end
            end

            -- Egg consumed
            if is_same_location(snake, egg) then
                -- Update egg location -- just don't generate it on an occupied square
                egg.x = love.math.random(1, grid.width - 1)
                egg.y = love.math.random(1, grid.height - 1)
                while is_occupied(snake, egg) do
                    egg.x = love.math.random(1, grid.width - 1)
                    egg.y = love.math.random(1, grid.height - 1)
                end
                -- Snake moves faster now
                snake.speed = snake.speed - 0.001
                -- Add another tail segment
                local lastsegment = snake.tail[#snake.tail]
                snake.tail[#snake.tail + 1] = {x = lastsegment.x, y = lastsegment.y}
            end
        end
    else
        Gamestate.push(highscore)
    end
end


function game:draw()
    -- Let's make the grid have points every 10 pixels. To do this,
    -- we round down to the nearest factor of 10
    if ispaused then
        love.graphics.printf('Press esc or p to continue', 0, 100, 400, 'center')
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('fill', snake.x * 10, snake.y * 10, 10, 10)
        for isegment, segment in ipairs(snake.tail) do
            love.graphics.rectangle('fill', segment.x * 10, segment.y * 10, 10, 10)
        end
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle('fill', egg.x * 10, egg.y * 10, 10, 10)
    else
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('fill', snake.x * 10, snake.y * 10, 10, 10)
        for isegment, segment in ipairs(snake.tail) do
            love.graphics.rectangle('fill', segment.x * 10, segment.y * 10, 10, 10)
        end
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle('fill', egg.x * 10, egg.y * 10, 10, 10)
    end
end


function game:keypressed(key)
    if key == 'up' or key == 'down' or key == 'left' or key == 'right' then
        if     dirbuffer[1] == '' and isvaliddir(snake.currdir, key) then dirbuffer[1] = key
        elseif dirbuffer[2] == '' and isvaliddir(dirbuffer[1], key)  then dirbuffer[2] = key
        end
    elseif key == 'escape' or key == 'p' then
        -- Pause menu
        Gamestate.push(menu)
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


function is_same_location(a, b)
    if a.x == b.x and a.y == b.y then
        return true
    else
        return false
    end
end


-- Check if the obj is located on a gridpoint occupied
-- by the snake or any of its segments
function is_occupied(snake, obj)
    if is_same_location(snake, obj) then return true end
    for _, segment in ipairs(snake.tail) do
        if is_same_location(segment, obj) then
            return true
        end
    end
    return false
end

return game
