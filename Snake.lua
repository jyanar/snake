Snake = Object:extend()

function Snake:new()
	self.gridx = 10
    self.gridx = 10
    self.gridy = 10
    self.alive = true
    self.currdir = 'down'
    self.speed = 0.1
    self.tail = {[1] = {gridx = 10, gridy = 9},
                 [2] = {gridx = 10, gridy = 8},
                 [3] = {gridx = 10, gridy = 7}}
end

