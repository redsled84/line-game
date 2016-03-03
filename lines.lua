local Lines = {}

-- Initialize the tables necessary to create lines
function Lines:initialize()
	self.currLine = {}
	self.lines = {}
end

-- Create an updatable line
function Lines:createNewLine(x, y)
	local currLine = { 
		s = { 
				x=x, 
				y=y 
			}, 
		e = { 
				x=nil, 
				y=nil 
			} 
	}
	-- self.currLine table is made a reference to the local table in the function
	setmetatable(self.currLine, {__index=currLine})
end


function Lines:updateEndPoint()
	local mt = getmetatable(self.currLine)
	-- Is updated every frame so need to check if an updatable line was even created 
	if mt ~= nil then
		-- Set the updatable lines end points to the current position of the mouse
		mt.__index.e.x = love.mouse.getX()
		mt.__index.e.y = love.mouse.getY()
	end
end

-- Assign the points to currLine, insert the finished line into the lines table, make self.currLine an empty table
function Lines:assignEndPoint(x, y)
	local mt = getmetatable(self.currLine)
	-- Set end x and y positions
	mt.__index.e.x = x
	mt.__index.e.y = y
	-- Insert the metatable data into lines table, not the reference table (metatable)
	table.insert(self.lines, mt.__index)
	local temp = mt.__index
	self.currLine = {}
	return temp
end

function Lines:getCurrLine()
	local mt = getmetatable(self.currLine)
	return mt.__index
end

function Lines:drawLines()
	local currLine_mt = getmetatable(self.currLine)
	-- Make sure there is a currLine metatable inside the self.currLine table
	if currLine_mt ~= nil then
		local mt = currLine_mt
		love.graphics.setColor(255,255,255)
		love.graphics.line(mt.__index.s.x, mt.__index.s.y, mt.__index.e.x, mt.__index.e.y)
	end
	if #self.lines ~= 0 then
		for _,v in ipairs(self.lines) do
			love.graphics.setColor(255,0,0)
			love.graphics.line(v.s.x, v.s.y, v.e.x, v.e.y)
		end
	end
end

return Lines