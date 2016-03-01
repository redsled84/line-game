local inspect = require 'inspect'
local Lines = { currLine={}, lines={} }

function Lines:createNewLine(x, y)
	local currLine = { s={x=x, y=y}, e={x=0, y=0} }
	setmetatable(self.currLine, {__index=currLine})
end

function Lines:assignEndPoint(x, y)
	local mt = getmetatable(self.currLine)
	mt.__index.e.x = x; mt.__index.e.y = y;
	table.insert(self.lines, mt.__index)
	self.currLine = {}
end

function Lines:updateEndPoint()
	local mt = getmetatable(Lines.currLine)
	if mt ~= nil then
		mt.__index.e.x = love.mouse.getX(); mt.__index.e.y = love.mouse.getY()
	end
end

function Lines:drawLines()
	local currLine_mt = getmetatable(self.currLine)
	if currLine_mt ~= nil then
		local mt = currLine_mt
		love.graphics.line(mt.__index.s.x, mt.__index.s.y, mt.__index.e.x, mt.__index.e.y)
	end
	if #self.lines ~= 0 then
		for _,v in ipairs(self.lines) do
			love.graphics.line(v.s.x, v.s.y, v.e.x, v.e.y)
		end
	end
end

function love.load()

end

function love.update(dt)
	Lines:updateEndPoint()
end

function love.draw()
	Lines:drawLines()
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
		Lines:createNewLine(x, y)
	end
end

function love.mousereleased(x, y, button, istouch)
	if button == 1 then
		Lines:assignEndPoint(x, y)
	end
end