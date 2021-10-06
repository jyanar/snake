local highscore = {}

function highscore:init()
    -- Input latest score
    score = tostring(#snake.tail) .. '\n'
    info = love.filesystem.getInfo('scores.txt')
    if info then
        success, msg = love.filesystem.append('scores.txt', score)
    else
        success, msg = love.filesystem.write('scores.txt', score)
    end
    -- Read them all out
    scores, size = love.filesystem.read('scores.txt')
end

function highscore:enter(previous)
    -- success, msg = love.filesystem.write('hsc.txt', tostring(#snake.tail) .. '\n', 100)
    -- print(success)
    -- print(msg)
end

function highscore:update(dt)
end

function highscore:draw()
    -- love.graphics.clear(0, 0, 0) -- not necessary, seemingly
    love.graphics.print('HIGH SCORES', 20, 20, 0)
    love.graphics.print(scores, 20, 30, 0)
end

function highscore:keypressed(key)
    if key == 'p' or key == 'escape' then
        Gamestate.pop()
    end

end

return highscore


