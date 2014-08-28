local class = require "cls.middleclass"
local util = require "util"

local entity = class("entity")

function entity:initialize(world, x, y, w, h, rot)
	self.alive = true
	self.world = world
	
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.rot = rot
	
	self.vx = 0
	self.vy = 0
	
	self.type = "Entity"
	self.collidable = false
	self.movable = false
	self.destroyable = false
	self.stackable = false
	
	self.on_ground = false
end


local GRAVITY = 980
function entity:update(dt)
	if self.destroyable then
		if self.hp <= 0 then
			self:die()
		end
	end
end

function entity:take_damage(amount)
	if self.destroyable then
		self.hp = self.hp - amount
		if self.hp <= 0 then
			entity:die()
		end
	end
end

function entity:die()
	self.alive = false
end

function entity:collide(a)

end

return entity
