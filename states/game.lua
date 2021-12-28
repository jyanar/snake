local game = {}

-- Local objects
local snake = {}
local grid = {}
local dirbuffer = {}
local egg = {}
local time = {}

function game:init()
end


function game:enter(previous)
    if previous == States.start then
        -- Generate game objects
        grid = { width = 20, height = 20 }
        snake = {
            gridx = 10,
            gridy = 10,
            alive = true,
            currdir = 'down',
            dt = 0.08,
            tail = {[1] = {gridx = 10, gridy = 9},
                    [2] = {gridx = 10, gridy = 8},
                    [3] = {gridx = 10, gridy = 7}}
        }
        dirbuffer = {[1] = '', [2] = ''}
        egg = {
            gridx = love.math.random(1, grid.width - 1),
            gridy = love.math.random(1, grid.height - 1)
        }
        time = love.timer.getTime()
    end
end


function game:update(dt)
    if snake.alive then
        -- Update snake position, if requisite time has passed
        if (love.timer.getTime() - time) > snake.dt then
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
            if snake.gridx > grid.width - 1  then snake.alive = false end
            if snake.gridx < 0               then snake.alive = false end
            if snake.gridy > grid.height - 1 then snake.alive = false end
            if snake.gridy < 0               then snake.alive = false end
            -- Hit self, die
            for _, seg in ipairs(snake.tail) do
                if is_same_location(snake, seg) then snake.alive = false end
            end
            if snake.alive == false then
                Sounds.death:play()
            end

            -- Egg consumed
            if is_same_location(snake, egg) then
                -- Update egg location -- just don't generate it on an occupied square
                egg.gridx = love.math.random(1, grid.width - 1)
                egg.gridy = love.math.random(1, grid.height - 1)
                while is_occupied(snake, egg) do
                    egg.gridx = love.math.random(1, grid.width - 1)
                    egg.gridy = love.math.random(1, grid.height - 1)
                end
                -- Snake moves faster now
                snake.dt = snake.dt - 0.001
                -- Add another tail segment
                local lastsegment = snake.tail[#snake.tail]
                snake.tail[#snake.tail + 1] = {gridx = lastsegment.gridx,
                                               gridy = lastsegment.gridy}
                -- Play sound
                Sounds.egg:play()
            end
        end
    else
        State.switch(States.deathscreen, #snake.tail)
    end
end


function game:draw()
    if ispaused then
        love.graphics.printf('Press esc or p to continue', 0, 100, 400, 'center')
    else
        -- Draw grid
        blocksize = WINDOW_SIZE / grid.width
        love.graphics.setColor(1,1,1, 0.1)
        for i = 1, grid.width do
            for j = 1, grid.width do
                love.graphics.rectangle('fill', (i * blocksize), (j * blocksize), 2, 2)
            end
        end
        -- Draw snake
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('fill', (snake.gridx * blocksize), (snake.gridy * blocksize),
                                        blocksize, blocksize)
        for isegment, segment in ipairs(snake.tail) do
            love.graphics.rectangle('fill', (segment.gridx * blocksize), (segment.gridy * blocksize),
                                            blocksize, blocksize)
        end
        -- Draw egg
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle('fill', egg.gridx * blocksize, egg.gridy * blocksize,
                                        blocksize, blocksize)
    end
end


function game:keypressed(key)
    if key == 'up' or key == 'down' or key == 'left' or key == 'right' then
        if     dirbuffer[1] == '' and isvaliddir(snake.currdir, key) then dirbuffer[1] = key
        elseif dirbuffer[2] == '' and isvaliddir(dirbuffer[1], key)  then dirbuffer[2] = key
        end
    elseif key == 'escape' or key == 'p' then
        -- Pause menu
        State.push(States.pause)
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
        snake.tail[i].gridx = snake.tail[i - 1].gridx
        snake.tail[i].gridy = snake.tail[i - 1].gridy
    end
    snake.tail[1].gridx, snake.tail[1].gridy = snake.gridx, snake.gridy
    -- Now move the head
    if snake.currdir == 'up' then
        snake.gridy = snake.gridy - 1
    elseif snake.currdir == 'down' then
        snake.gridy = snake.gridy + 1
    elseif snake.currdir == 'left' then 
        snake.gridx = snake.gridx - 1
    elseif snake.currdir == 'right' then
        snake.gridx = snake.gridx + 1
    end
end


function is_same_location(a, b)
    if a.gridx == b.gridx and a.gridy == b.gridy then
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

