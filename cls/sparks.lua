local class = require "cls.middleclass"
local c_entity = require "cls.entity"

local Spark = class("Spark", c_entity)
	
function Spark:initialize(world, x, y, vx, vy)
	self.r = math.random(2, 6)

	c_entity.initialize(self, world, x, y, self.r, self.r, 0)

	self.type = "Spark"
	self.collidable = true
	self.movable = true
	self.destroyable = false
	self.stackable = false
	
	self.vx = vx
	self.vy = vy
	
	self.color = {math.random(200)+55, math.random(200)+55, math.random(67)}
	self.lt = 0
	self.mlt = math.random()*2 + 2
end

function Spark:update(dt)
	c_entity.update(self, dt)
	if self.lt > self.mlt then
		self.lt = self.lt + dt
	else
		self.alive = false
	end
end

function Spark:draw(dt)
	love.graphics.setColor(self.color, 55 + 200*(self.lt/self.mlt))
	love.graphics.circle("fill", self.x, self.y, self.r, 12)
	love.graphics.setColor(255, 255, 255)
end

return Spark
