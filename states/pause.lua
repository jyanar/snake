local pause = {}

function pause:init()
end

function pause:enter(previous)
    love.mouse.setVisible(true)
end

function pause:update(dt)
end

function pause:draw()
    local text = 'game paused'
    local titlew = m5x7_32:getWidth(text)
    local titleh = m5x7_32:getHeight(text)
    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 20
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, m5x7_32, titlex, titley)
end

function pause:keypressed(key)
    if key == 'p' or key == 'escape' then
        Gamestate.pop()
    end
end

return pause

