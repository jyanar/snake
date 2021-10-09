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
    -- font = love.graphics.newFont(32)
    -- font = love.font.newRasterizer('m5x7.ttf', 32)
    m5x7_32 = love.graphics.newFont('m5x7.ttf', 32)
    m5x7_64 = love.graphics.newFont('m5x7.ttf', 64)
    table.insert(buttons, newbutton('Start', function() Gamestate.switch(game) end))
    table.insert(buttons, newbutton('Exit', function() love.event.quit() end))
end

function start:enter(previous)
end

function start:update(dt)
end

function start:draw()
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()
    -- Draw title
    local titleW = m5x7_64:getWidth('SNAKE')
    local titleH = m5x7_64:getHeight('SNAKE')
    love.graphics.print('SNAKE', m5x7_64,
        (ww * 0.5) - titleW * 0.5,
        45)
    local button_width = ww / 2
    local button_height = 50
    local margin = 4
    local cursor_y = 0
    local total_height = (button_height + margin) * #buttons
    for i, button in ipairs(buttons) do
        local bx = (ww * 0.5) - (button_width * 0.5)
        local by = (ww * 0.5) - (total_height * 0.5) + cursor_y
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
end

function start:keypressed(key)
    if key == 'return' then
        Gamestate.switch(game)
    end
end


return start

