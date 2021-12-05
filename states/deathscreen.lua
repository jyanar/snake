local deathscreen = {}

local textbox = {
    x = gw / 8,
    y = 4 * (gh / 6),
    width = gw * 0.75,
    height = 32 + 8,
    text = '',
    active = true,
    colors = {
        background = {0, 0, 0},
        text = {1, 1, 1}
    }
}

function deathscreen:init()
end

function love.textinput(text)
    if textbox.active and #textbox.text < 6 then
        textbox.text = textbox.text .. text
    end
end

function deathscreen:enter(previous)
end

function deathscreen:update(dt)
end

function deathscreen:draw()
    -- Title
    local titlew = m5x7_32:getWidth('dead')
    local titleh = m5x7_32:getHeight('dead')
    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 20
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('dead', m5x7_32, titlex, titley)

    -- Score
    str = 'tail length: ' .. tostring(#snake.tail)
    local titlew = m5x7_32:getWidth(str)
    local titleh = m5x7_32:getHeight(str)
    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 50
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(str, m5x7_32, titlex, titley)
    
    -- Name
    score_str = 'name'
    local titlew = m5x7_32:getWidth(score_str)
    local titleh = m5x7_32:getHeight(score_str)
    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 3 * (gh / 6)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(score_str, m5x7_32, titlex, titley)

    -- Textbox rectangle
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', textbox.x - 2, textbox.y - 2,
        textbox.width + 4, textbox.height + 4)
    love.graphics.setColor(unpack(textbox.colors.background))
    love.graphics.rectangle('fill', textbox.x, textbox.y,
        textbox.width, textbox.height)
    -- Text box
    love.graphics.setColor(unpack(textbox.colors.text))
    love.graphics.printf(textbox.text, m5x7_32, textbox.x, textbox.y+4,
        textbox.width, 'center')
end

function deathscreen:keypressed(key)
    if key == 'backspace' then
        textbox.text = textbox.text:sub(1, -2)
    end

    if key == 'return' then
        textbox.active = false
        if love.filesystem.getInfo('scores.lua') ~= nil then
            local existing_data = love.filesystem.load('scores.lua')
            existing_data() -- table `data` loaded
        end
        table.insert(data, {score = #snake.tail, name = textbox.text})
        love.filesystem.write('scores.lua', table.show(data, 'data'))
        Gamestate.switch(state_leaderboard)
    end
    -- User does not want to enter current score into list.
    -- Move back to start menu and clear buffer.
    if key == 'escape' then
        textbox.text = ''
        Gamestate.switch(state_start)
    end
end

return deathscreen



