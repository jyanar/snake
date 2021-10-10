local deathscreen = {}

local textbox = {
    x = gw / 8,
    y = gh / 4,
    width = gw * 0.75,
    height = 32 + 8,
    text = '',
    active = true,
    colors = {
        background = {0, 0, 0},
        text = {1, 1, 1}
    }
}

-- local data = {}

function deathscreen:init()
    -- Input latest score
    score = #snake.tail
end

function love.textinput(text)
    if textbox.active then
        textbox.text = textbox.text .. text
    end
end

function deathscreen:enter(previous)
end

function deathscreen:update(dt)
end

function deathscreen:draw()
    -- local titlew = m5x7_32:getWidth('leaderboard')
    -- local titleh = m5x7_32:getHeight('leaderboard')

    -- local titlex = (gw * 0.5) - (titlew * 0.5)
    -- local titley = 20

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
        local existing_data = love.filesystem.load('scores.lua')
        existing_data()
        data[textbox.text] = score
        love.filesystem.write('scores.lua', table.show(data, 'data'))
        Gamestate.switch(leaderboard)
    end
end

return deathscreen



