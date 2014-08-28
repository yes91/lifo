local class = require "cls.middleclass"
local c_entity = require "cls.entity"
local c_spark = require "cls.spark"

local star = class("star", c_entity)

local WIDTH = 16
local HEIGHT = 16

local colors = {}
	colors[1] = {255, 63, 63}
	colors[2] = {63, 255, 63}
	colors[3] = {63, 63, 255}
	colors[4] = {255, 63, 255}
	colors[5] = {63, 255, 255}
	colors[6] = {255, 255, 63}
	
function star:initialize(world, x, y, c)
	c_entity.initialize(self, world, x, y, WIDTH, HEIGHT, 0)

	self.type = "Star"
	self.collidable = true
	self.movable = true
	self.destroyable = false
	self.stackable = true
	
	if c == nil then
		self.color = colors[math.random(1, #colors)]
	else
		self.color = c
	end
	
	self.lt = math.random()*2
end

function star:update(dt)
	c_entity.update(self, dt)
	self.lt = self.lt + dt
end

function star:draw(dt)
	love.graphics.setColor(self.color)
	local size = 1 + math.sin(self.lt*2)/8
	--love.graphics.rectangle("fill", (self.x - (self.w/2)*size), (self.y - (self.h/2)*size), self.w*size, self.h*size)
	love.graphics.rectangle("line", self.x - self.w/2, self.y - self.h/2, self.w, self.h)
	love.graphics.setColor(255, 255, 255)
end

function star:collide(obj)
	if math.abs(self.vx - obj.vx) > 500 or math.abs(self.vy - obj.vy) > 500 then
		for i=1, 4 do
			local angle = math.random()*2*math.pi
			local power = math.random(200, 500)
			local color
			if obj.color ~= nil then
				color = {(self.color[1] + obj.color[1])/2, (self.color[2] + obj.color[2])/2, (self.color[3] + obj.color[3])/2} 
			else 
				color = self.color
			end
			self.world:add(c_spark:new(self.world, self.x, self.y, math.cos(angle)*power, math.sin(angle)*power, color))
		end
	end
end

return star
