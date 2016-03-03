-- FIXED: fix small color bug between ball and polygons
-- TODO: polygon shape is updated via currLine
-- TODO: create tracers
-- FIXED: fix single click bug
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
	Physics:drawPhysicBodies(world)
end

function love.keypressed(key)
	if key == "r" then
		Lines.lines = {}
		Physics:removeBodies()
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
		-- fix single click bug by checking if the end points equal start points
		if line.e.x == line.s.x and line.e.y == line.s.y then
			print("Can't create polygon with single point!")
		else 
			Physics:createLinePolygon(world, line.s.x, line.s.y, line.e.x, line.e.y, 1.2)
		end
	elseif button == 2 then
		Physics:createCircle(world, x, y, 5, 1.5)
	elseif button == 3 then
		Physics:createRectangle(world, x,y, 32, 32)
	end
end