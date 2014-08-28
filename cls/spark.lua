local class = require "cls.middleclass"
local c_entity = require "cls.entity"

local Spark = class("Spark", c_entity)
	
function Spark:initialize(world, x, y, vx, vy, color)
	self.r = math.random(1, 3)

	c_entity.initialize(self, world, x, y, self.r, self.r, 0)

	self.type = "Spark"
	self.collidable = false
	self.movable = true
	self.destroyable = false
	self.stackable = false
	
	self.vx = vx
	self.vy = vy
	
	self.color = color
	self.lt = 0
	self.mlt = math.random()
end

function Spark:update(dt)
	c_entity.update(self, dt)
	if self.lt > self.mlt then
		self.alive = false
	else
		self.lt = self.lt + dt
	end
end

function Spark:draw(dt)
	love.graphics.setColor(self.color[1], self.color[2], self.color[3], 255 - 200*(self.lt/self.mlt))
	love.graphics.circle("line", self.x, self.y, self.r, 12)
	love.graphics.setColor(255, 255, 255)
end

return Spark
