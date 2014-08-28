local class = require "cls.middleclass"
local c_entity = require "cls.entity"

local star = class("star", c_entity)
	
function star:initialize(world, x, y, w, h)
	c_entity.initialize(self, world, x, y, w, h, 0)

	self.type = "Block"
	self.collidable = true
	self.movable = false
	self.destroyable = false
	self.stackable = false
end

function star:update(dt)
	c_entity.update(self, dt)
end

function star:draw(dt)
	love.graphics.setColor(127, 127, 0)
	love.graphics.rectangle("fill", self.x - self.w/2, self.y - self.h/2, self.w, self.h)
	love.graphics.setColor(255, 255, 255)
end

return star
