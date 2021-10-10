local start = {}

local buttons = {}

function newbutton(text, fn)
    return {
        text = text,
        fn = fn,
        now = false,
        last = false
    }
end

function start:init()
    table.insert(buttons, newbutton(
        'start',
        function()
            Gamestate.switch(game)
        end))
    table.insert(buttons, newbutton(
        'leaderboard',
        function()
            Gamestate.switch(leaderboard)
        end))
    table.insert(buttons, newbutton(
        'exit',
        function()
            love.event.quit()
        end))
end

function start:enter(previous)
    love.mouse.setVisible(true)
end

function start:update(dt)
end

function start:draw()
    local ww = gw
    local wh = gh
    -- Draw title
    local titleW = m5x7_64:getWidth('SNAKE')
    local titleH = m5x7_64:getHeight('SNAKE')
    love.graphics.print('SNAKE', m5x7_64,
        (ww * 0.5) - titleW * 0.5, wh / 10)
    local button_width = ww / 2
    -- local button_height = wh / 5.4
    local button_height = wh / 5.4
    local margin = 4
    local cursor_y = 25
    local total_height = (button_height + margin) * #buttons
    for i, button in ipairs(buttons) do
        local bx = (ww * 0.5) - (button_width * 0.5)
        local by = (wh * 0.5) - (total_height * 0.5) + cursor_y
        local mx, my = love.mouse.getPosition()
        local hot = mx > bx and mx < bx + button_width and
                    my > by and my < by + button_height
        local color = {0.4, 0.4, 0.5, 1.0}
        if hot then
            color = {0.8, 0.8, 0.9, 1.0}
        end
        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot then
            button.fn()
        end
        love.graphics.setColor(unpack(color))
        love.graphics.rectangle('fill', 
            bx, by,
            button_width,
            button_height
        )
        -- Text on buttons
        local textW = m5x7_32:getWidth(button.text)
        local textH = m5x7_32:getHeight(button.text)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(button.text, m5x7_32,
            (ww * 0.5) - textW * 0.5,
            by + textH * 0.4)
        cursor_y = cursor_y + (button_height + margin)
    end

    -- -- Draw rotating snake
    -- snake = {
    --     gridx = 5,
    --     gridy = 20,
    --     alive = true,
    --     currdir = 'down',
    --     speed = 0.08,
    --     tail = {[1] = {gridx = 6, gridy = 20},
    --             [2] = {gridx = 7, gridy = 20},
    --             [3] = {gridx = 8, gridy = 20}}
    -- }
    -- love.graphics.setColor(1, 1, 1)
    -- love.graphics.rectangle('fill', snake.gridx * 10, snake.gridy * 10, 10, 10)
    -- for isegment, segment in ipairs(snake.tail) do
    --     love.graphics.rectangle('fill', segment.gridx * 10, segment.gridy * 10, 10, 10)
    -- end
end

function start:keypressed(key)
    if key == 'return' then
        Gamestate.switch(game)
    end
end


return start

