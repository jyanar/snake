local leaderboard = {}


function leaderboard:init()
    ---------------------
    -- Load latest scores
    ---------------------
    if love.filesystem.getInfo('scores.lua') ~= nil then
        -- Load existing table
        local existing_data = love.filesystem.load('scores.lua')
        existing_data() -- table `data` loaded
        data = Lume.sort(data, function(a, b) return a.score > b.score end)
    else
        data = {}
    end
end

function leaderboard:enter(previous)
    -- Previous state was deathscreen, therefore new score is available.
    -- Re-load the table.
    if previous == state_deathscreen then
        if love.filesystem.getInfo('scores.lua') ~= nil then
            -- Load existing table
            local existing_data = love.filesystem.load('scores.lua')
            existing_data() -- table `data` loaded
        end
        -- Sort the data table
        data = Lume.sort(data, function(a, b) return a.score > b.score end)
    end
    love.mouse.setVisible(true)
end

function leaderboard:draw()
    -- Title
    local titlew = Fonts.size32:getWidth('leaderboard')
    local titleh = Fonts.size32:getHeight('leaderboard')
    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 20
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('leaderboard', Fonts.size32, titlex, titley)

    -- List scores
    local space_h = Fonts.size24:getWidth('XXXXXXXX')
    local cursor_y = titley + titleh + 20
    local cursor_x = (gw * 0.5) - (space_h * 0.7)
    local entry_h = 16
    local margin = 4
    for i, s in ipairs(data) do
        if i <= 7 then -- Print out first 7
            love.graphics.print(s.name, Fonts.size24, cursor_x, cursor_y)
            love.graphics.print(s.score, Fonts.size24, cursor_x + space_h, cursor_y)
            cursor_y = cursor_y + margin + entry_h
        end
    end
end

function leaderboard:keypressed(key)
    if key == 'escape' then
        State.switch(States.start)
    end
end

return leaderboard


