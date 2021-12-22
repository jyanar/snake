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
    local titlew = Fonts.size32:getWidth(text)
    local titleh = Fonts.size32:getHeight(text)
    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 20
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, Fonts.size32, titlex, titley)
end

function pause:keypressed(key)
    if key == 'p' or key == 'escape' then
        State.pop()
    end
end

return pause

