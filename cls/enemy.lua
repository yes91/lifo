local class = require "cls.middleclass"
local c_entity = require "cls.entity"

local c_spark = require "cls.spark"

local enemy = class("enemy", c_entity)

local WIDTH = 32
local HEIGHT = 32
function enemy:initialize(world, x, y)
	c_entity.initialize(self, world, x, y, WIDTH, HEIGHT, 0)

	self.type = "Enemy"
	self.collidable = true
	self.movable = true
	self.destroyable = true
	self.stackable = false
	
	self.hp = 100
end

function enemy:update(dt)
	c_entity.update(self, dt)
	self.vy = self.vy
end

function enemy:draw(dt)
	love.graphics.rectangle("line", self.x - self.w/2, self.y - self.h/2, self.w, self.h)
end

function enemy:collide(obj)
	if math.abs(self.vx - obj.vx) > 500 or math.abs(self.vy - obj.vy) > 500 then
		self.hp = self.hp - 10
	end
end

function enemy:die()
	for i=1, 200 do
		local angle = math.random()*2*math.pi
		local power = math.random(200, 500)
		local color = {math.random()*55 + 200, math.random()*50 + 150, 0}
		self.world:add(c_spark:new(self.world, self.x, self.y, math.cos(angle)*power, math.sin(angle)*power, color))
	end
	c_entity.die(self)
end

return enemy
