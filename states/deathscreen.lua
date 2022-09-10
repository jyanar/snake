local deathscreen = {}

local score = 0

local textbox = {
    x = gw / 8,
    y = 4 * (gh / 6),
    width = gw * 0.75,
    height = 64 + 8,
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

function deathscreen:enter(previous, ntailsegments)
    if previous == States.game then
        score = ntailsegments
    end
end

function deathscreen:update(dt)
end

function deathscreen:draw()
    -- Title
    local titlew = Fonts.size64:getWidth('dead')
    local titleh = Fonts.size64:getHeight('dead')
    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 20
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('dead', Fonts.size64, titlex, titley)

    -- Score
    str = 'tail length: ' .. tostring(score)
    local titlew = Fonts.size64:getWidth(str)
    local titleh = Fonts.size64:getHeight(str)
    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 80
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(str, Fonts.size64, titlex, titley)
    
    -- Name
    score_str = 'name'
    local titlew = Fonts.size64:getWidth(score_str)
    local titleh = Fonts.size64:getHeight(score_str)
    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 3 * (gh / 6)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(score_str, Fonts.size64, titlex, titley)

    -- Textbox rectangle
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('fill', textbox.x - 2, textbox.y - 2,
        textbox.width + 4, textbox.height + 4)
    love.graphics.setColor(unpack(textbox.colors.background))
    love.graphics.rectangle('fill', textbox.x, textbox.y,
        textbox.width, textbox.height)

    -- Text box
    love.graphics.setColor(unpack(textbox.colors.text))
    love.graphics.printf(textbox.text, Fonts.size64, textbox.x, textbox.y+4,
        textbox.width, 'center')
end

function deathscreen:keypressed(key)
    if key == 'backspace' then
        textbox.text = textbox.text:sub(1, -2)
    end

    if key == 'return' then
        textbox.active = false
        local data = {}
        if love.filesystem.getInfo('scores.lua') ~= nil then
            local existing_data = love.filesystem.load('scores.lua')
            existing_data() -- table `data` loaded
        end
        table.insert(data, {score = score, name = textbox.text})
        love.filesystem.write('scores.lua', table.show(data, 'data'))
        State.switch(States.leaderboard)
    end
    -- User does not want to enter current score into list.
    -- Move back to start menu and clear buffer.
    if key == 'escape' then
        textbox.text = ''
        State.switch(States.start)
    end
end

return deathscreen



