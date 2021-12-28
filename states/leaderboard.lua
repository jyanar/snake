local leaderboard = {}

local scoredata = {}

function leaderboard:init()
    -- Load latest scores
    if love.filesystem.getInfo('scores.lua') ~= nil then
        -- Load existing table
        local existing_data = love.filesystem.load('scores.lua')
        existing_data() -- table `data` loaded
        scoredata = Lume.sort(data, function(a, b) return a.score > b.score end)
    end
end

function leaderboard:enter(previous)
    -- -- Regardless from where we came, load the table
    -- if love.filesystem.getInfo('scores') ~= nil then
    --     local existing_data = love.filesystem.load('scores.lua')
    --     data = existing_data()
    --     data = Lume.sort(data, function(a, b) return a.score > b.score end)
    -- else
    --     data = {}
    -- end


    -- Previous state was deathscreen, therefore new score is available.
    -- Re-load the table.
    if previous == state_deathscreen then
        if love.filesystem.getInfo('scores.lua') ~= nil then
            -- Load existing table
            local existing_data = love.filesystem.load('scores.lua')
            existing_data() -- table `data` loaded
        end
    end
    -- Sort the data table
    scoredata = Lume.sort(data, function(a, b) return a.score > b.score end)
    love.mouse.setVisible(true)
end

function leaderboard:draw()
    -- Title
    local titlew = Fonts.size64:getWidth('leaderboard')
    local titleh = Fonts.size64:getHeight('leaderboard')
    local titlex = (gw * 0.5) - (titlew * 0.5)
    local titley = 20
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('leaderboard', Fonts.size64, titlex, titley)

    -- List scores
    local space_h = Fonts.size32:getWidth('XXXXXXXX')
    local cursor_y = titley + titleh + 20
    local cursor_x = (gw * 0.5) - (space_h * 0.7)
    local entry_h = 16
    local margin = 4
    for i, s in ipairs(scoredata) do
        if i <= 10 then -- Print out first 10
            love.graphics.print(s.name, Fonts.size32, cursor_x, cursor_y)
            love.graphics.print(s.score, Fonts.size32, cursor_x + space_h, cursor_y)
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


