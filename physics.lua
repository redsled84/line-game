local inspect = require 'inspect'
local Physics = {}

function Physics:initialize()
	self.bodies = {}
end

-- Takes start-x, start-y, end-x, end-y
function Physics:createLinePolygon(world, sx, sy, ex, ey, size)
	local polygon = {
		body = love.physics.newBody(world, 0, 0, "static"),
		shape = love.physics.newPolygonShape({sx, sy, ex, ey, 
			sx+size, sy+size, ex+size, ey+size})
	}
	polygon.fixture = love.physics.newFixture(polygon.body, polygon.shape, 1)
	print(inspect(polygon.body))
	table.insert(self.bodies, polygon)
end

function Physics:createCircle(world, x, y, radius, bounciness)
	bounciness = bounciness or 0.9
	local circle = {
		body = love.physics.newBody(world, x, y, "dynamic"),
		shape = love.physics.newCircleShape(radius)
	}
	circle.fixture = love.physics.newFixture(circle.body, circle.shape, 1):setRestitution(bounciness)
	table.insert(self.bodies, circle)
end

function Physics:updateWorld(dt, world)
	world:update(dt)
end

function Physics:drawPhysicBodies()
	for _,v in ipairs(self.bodies) do
		if v.shape:getType() == 'circle' then
			love.graphics.setColor(0,255,0)
			love.graphics.circle("fill", v.body:getX(), v.body:getY(), v.shape:getRadius())
		else
			love.graphics.setColor(255,0,0)
			love.graphics.polygon("fill", v.body:getWorldPoints(v.shape:getPoints()))
		end
	end
end

return Physics