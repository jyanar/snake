local leaderboard = {}

function leaderboard:init()
    -- Input latest score
    if love.filesystem.getInfo('scores.lua') ~= nil then
        -- Load existing table
        local existing_data = love.filesystem.load('scores.lua')
        existing_data() -- table `data` loaded
    end

    -- Sort the data table

end


--     score = tostring(#snake.tail) .. '\n'
--     info = love.filesystem.getInfo('scores.txt')
--     if info then
--         success, msg = love.filesystem.append('scores.txt', score)
--     else
--         success, msg = love.filesystem.write('scores.txt', score)
--     end
--     print('ffffffffffffffffffff')
--     -- Read them all out
--     scores, size = love.filesystem.read('scores.txt')
-- end

function leaderboard:enter(previous)
    love.mouse.setVisible(true)
end

function leaderboard:update(dt)
end

function leaderboard:draw()
    local titlew = m5x7_32:getWidth('leaderboard')
    local titleh = m5x7_32:getHeight('leaderboard')

    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 20

    -- Title
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('leaderboard', m5x7_32, titlex, titley)

    -- List scores
    local cursor_y = titley + titleh + 20
    local cursor_x = (gw * 0.5) - (titlew * 0.5)
    local entry_h = 16
    local margin = 4
    local space_h = m5x7_24:getWidth('XXXXXXXX')
    for n, s in pairs(data) do
        love.graphics.print(n, m5x7_24, cursor_x, cursor_y)
        love.graphics.print(s, m5x7_24, cursor_x + space_h, cursor_y)
        cursor_y = cursor_y + margin + entry_h
    end
end

function leaderboard:keypressed(key)
    if key == 'escape' then
        Gamestate.switch(start)
    end
end

return leaderboard


