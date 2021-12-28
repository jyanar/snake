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
    if self.currdir == 'up' then
        self.gridy = self.gridy - 1
    elseif self.currdir == 'down' then
        self.gridy = self.gridy + 1
    elseif self.currdir == 'left' then
        self.gridx = self.gridx - 1
    elseif self.currdir == 'right' then
        self.gridx = self.gridx + 1
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


return Snake

