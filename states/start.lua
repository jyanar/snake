local start = {}

local buttons = {}
local active_button = 0

function newbutton(text, fn)
    return {
        text = text,
        fn = fn,
        sound_played = false,
    }
end

function start:init()
    table.insert(buttons, newbutton(
        'start',
        function()
            State.switch(States.game)
        end))
    table.insert(buttons, newbutton(
        'leaderboard',
        function()
            State.switch(States.leaderboard)
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
    local titleW = Fonts.size64:getWidth('SNAKE')
    local titleH = Fonts.size64:getHeight('SNAKE')
    love.graphics.print('SNAKE', Fonts.size64,
        (ww * 0.5) - titleW * 0.5, wh / 10)
    local button_width = ww / 2
    local button_height = wh / 5.4
    -- local button_height = wh / 6.2
    local margin = 4
    local cursor_y = 25
    local total_height = (button_height + margin) * #buttons
    for i, button in ipairs(buttons) do
        local bx = (ww * 0.5) - (button_width * 0.5)
        local by = (wh * 0.5) - (total_height * 0.5) + cursor_y
        local color = {0.4, 0.4, 0.5, 1.0}
        if i == active_button then
            color = {0.8, 0.8, 0.9, 1.0}
            if not button.sound_played then
                love.audio.stop()
                Sounds.button:play()
                button.sound_played = true
            end
        end
        love.graphics.setColor(unpack(color))
        love.graphics.rectangle('fill', 
            bx, by,
            button_width,
            button_height
        )
        -- Text on buttons
        local textW = Fonts.size32:getWidth(button.text)
        local textH = Fonts.size32:getHeight(button.text)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(button.text, Fonts.size32,
            (ww * 0.5) - textW * 0.5,
            by + textH * 0.4)
        cursor_y = cursor_y + (button_height + margin)
    end
end

function start:keypressed(key)
    if key == 'return' and active_button ~= 0 then
        buttons[active_button].fn()
    end
    -- Navigation
    if key == 'down' and active_button ~= #buttons then
        active_button = active_button + 1
        if active_button - 1 ~= 0 then
            buttons[active_button - 1].sound_played = false
        end
    elseif key == 'up' and active_button ~= 1 then
        active_button = active_button - 1
        buttons[active_button + 1].sound_played = false
    end
end


return start

