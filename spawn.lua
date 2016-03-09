local Spawn = {}


function Spawn:createSpawn(x, y)
	self.x = x; self.y = y
end


function Spawn:removeSpawn()
	self.x = nil; self.y = nil
end


function Spawn:drawSpawn()
	love.graphics.setColor(255,255,255)
	love.graphics.points(self.x, self.y)
end

return Spawn