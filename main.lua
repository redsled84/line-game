-- FIXED: fix small color bug between ball and polygons
-- TODO: polygon shape is updated via currLine
-- TODO: create tracers
-- FIXED: fix single click bug
-- TODO: add hoops, complete level when ball goes in hoop
-- TODO: random spawn of ball, random spawn of hoop, on click event start game
local inspect = require 'inspect'
local Lines = require 'lines'
local Physics = require 'physics'
local Spawn = require 'spawn'

local meter = 64; love.physics.setMeter(meter)
local world = love.physics.newWorld(0, 9.18 * meter, true)

function love.load()
	Lines:initialize()
	Physics:initialize()
end


function love.update(dt)
	Lines:updateEndPoint()
	Physics:updateWorld(dt, world)
end


function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.print("Controls: ", 10, 12)
	love.graphics.print("Right click to create balls at spawn point", 20, 20)
	love.graphics.print("Left click to create lines", 20, 28)
	love.graphics.print("Middle click to create rectangles", 20, 36)

	Lines:drawLines()
	Physics:drawPhysicBodies(world)
	Spawn:drawSpawn()
end


function love.keypressed(key)
	if key == "r" then
		Lines.lines = {}
		Physics:removeAllBodies()
		Spawn:removeSpawn()
	end
	if key == "space" then
		Spawn:createSpawn(love.math.random(100,400), love.math.random(100,400))
	end
	if key == "escape" then
		love.event.quit()
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
		Physics:createCircle(world, Spawn.x, Spawn.y, 5, 1)
	elseif button == 3 then
		Physics:createRectangle(world, x, y, 32, 32)
	end
end