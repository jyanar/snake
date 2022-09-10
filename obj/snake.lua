Snake = Object:extend()


function Snake:new(gridx, gridy, currdir, dt)
    self.gridx = gridx or 10
    self.gridy = gridy or 10
    self.alive = true
    self.currdir = currdir or 'down'
    self.dt = dt or 0.08
    self.dirbuffer = {[1] = '', [2] = ''}
    self.tail = {[1] = {gridx = 10, gridy = 9},
                 [2] = {gridx = 10, gridy = 8},
                 [3] = {gridx = 10, gridy = 7}}
    self.drawmode = 'normal'
end


-- Move the snake according to `currdir`
function Snake:move()
    -- Move tail segments
    for i = #self.tail, 2, -1 do
        self.tail[i].gridx = self.tail[i - 1].gridx
        self.tail[i].gridy = self.tail[i - 1].gridy
    end
    self.tail[1].gridx, self.tail[1].gridy = self.gridx, self.gridy
    -- Move the head
    if     self.currdir == 'up'    then self.gridy = self.gridy - 1
    elseif self.currdir == 'down'  then self.gridy = self.gridy + 1
    elseif self.currdir == 'left'  then self.gridx = self.gridx - 1
    elseif self.currdir == 'right' then self.gridx = self.gridx + 1
    end
end


-- Update the dirbuffer (used after move)
function Snake:update_dirbuffer()
    if self.dirbuffer[1] ~= '' then
        self.currdir = self.dirbuffer[1]
        self.dirbuffer[1] = self.dirbuffer[2]
        self.dirbuffer[2] = ''
    end
end


-- Add tail segment
function Snake:add_tail_segment()
    local lastsegment = self.tail[#self.tail]
    self.tail[#self.tail + 1] = {gridx = lastsegment.gridx,
                                 gridy = lastsegment.gridy}
end


function Snake:draw(time, blocksize)
    -- Draw head
    love.graphics.setColor(1, 1, 1)
    local px = self.gridx * blocksize
    local py = self.gridy * blocksize
    local frac_there = (love.timer.getTime() - time) / self.dt
    if self.currdir == 'right' then px = px + math.floor(frac_there * blocksize) end
    if self.currdir == 'up'    then py = py - math.floor(frac_there * blocksize) end
    if self.currdir == 'left'  then px = px - math.floor(frac_there * blocksize) end
    if self.currdir == 'down'  then py = py + math.floor(frac_there * blocksize) end

    love.graphics.rectangle('fill', px + 2, py, blocksize - 4, blocksize)
    love.graphics.rectangle('fill', px, py + 2, blocksize, blocksize - 4)

    -- Different drawing modes
    if self.drawmode == 'normal' then
        -- Draw segments
        for i, seg in ipairs(self.tail) do
            local px = seg.gridx * blocksize
            local py = seg.gridy * blocksize
            -- Here, we check the position of the previous segment. In the case of the first
            -- node, this is just the snake's head.
            if i == 1 then
                -- Previous segment is:
                -- LEFT
                if self.gridx < seg.gridx and self.gridy == seg.gridy then
                    px = px - math.floor(frac_there * blocksize)
                end
                -- RIGHT
                if self.gridx > seg.gridx and self.gridy == seg.gridy then
                    px = px + math.floor(frac_there * blocksize)
                end
                -- ABOVE
                if self.gridx == seg.gridx and self.gridy > seg.gridy then
                    py = py + math.floor(frac_there * blocksize)
                end
                -- BELOW
                if self.gridx == seg.gridx and self.gridy < seg.gridy then
                    py = py - math.floor(frac_there * blocksize)
                end
            else
                -- previous seg is to the left
                if self.tail[i-1].gridx < seg.gridx and self.tail[i-1].gridy == seg.gridy then
                    px = px - math.floor(frac_there * blocksize)
                end
                -- previous seg is to the right
                if self.tail[i-1].gridx > seg.gridx and self.tail[i-1].gridy == seg.gridy then
                    px = px + math.floor(frac_there * blocksize)
                end
                -- previous seg is below
                if self.tail[i-1].gridx == seg.gridx and self.tail[i-1].gridy > seg.gridy then
                    py = py + math.floor(frac_there * blocksize)
                end
                -- previous seg is above
                if self.tail[i-1].gridx == seg.gridx and self.tail[i-1].gridy < seg.gridy then
                    py = py - math.floor(frac_there * blocksize)
                end
            end
            -- love.graphics.rectangle('fill', px, py, blocksize, blocksize)
            love.graphics.rectangle('fill', px + 2, py, blocksize - 4, blocksize)
            love.graphics.rectangle('fill', px, py + 2, blocksize, blocksize - 4)
        end
    elseif self.drawmode == 'confused' then
        for i, seg in ipairs(self.tail) do
            local px = seg.gridx * blocksize
            local py = seg.gridy * blocksize
            local frac_there = (love.timer.getTime() - time) / self.dt
            if self.currdir == 'right' then px = px + math.floor(frac_there * blocksize) end
            if self.currdir == 'up'    then py = py - math.floor(frac_there * blocksize) end
            if self.currdir == 'left'  then px = px - math.floor(frac_there * blocksize) end
            if self.currdir == 'down'  then py = py + math.floor(frac_there * blocksize) end
            love.graphics.rectangle('fill', px, py, blocksize, blocksize)
        end
    end
end


return Snake

