-- TODO: fix small color bug between ball and polygons
-- TODO: polygon shape is updated via currLine
-- TODO: create tracers
-- TODO: fix single click bug
-- TODO: add hoops, complete level when ball goes in hoop
-- TODO: random spawn of ball, random spawn of hoop, on click event start game
local inspect = require 'inspect'
local Lines = require 'lines'
local Physics = require 'physics'

local meter = 64; love.physics.setMeter(meter)
local world = love.physics.newWorld(0, 9.18*meter, true)

function love.load()
	Lines:initialize()
	Physics:initialize()
end

function love.update(dt)
	Lines:updateEndPoint()
	Physics:updateWorld(dt, world)
end

function love.draw()
	Lines:drawLines()
	Physics:drawPhysicBodies()
end

function love.keypressed(key)
	if key == "space" then
		Physics:createCircle(world, 10, 10, 10, .92)
	end
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
		Lines:createNewLine(x, y)
	end
end

function love.mousereleased(x, y, button, istouch)
	if button == 1 then
		local line = Lines:assignEndPoint(x, y)
		-- fix single click bug by checking if the end points are nil
		Physics:createLinePolygon(world, line.s.x, line.s.y, line.e.x, line.e.y, 2)
	end
end