local class = require "cls.middleclass"
local c_entity = require "cls.entity"

local c_star = require "cls.star"

local player = class("player", c_entity)

local WIDTH = 32
local HEIGHT = 32
function player:initialize(world, x, y)
	c_entity.initialize(self, world, x, y, WIDTH, HEIGHT, 0)

	self.type = "Player"
	self.collidable = true
	self.movable = true
	self.destroyable = true
	self.stackable = false
	
	self.hp = 100
	
	self.stack = {}
	self.last_launch = 0
	
	self.dir = 1
end

function player:update(dt)
	if (love.keyboard.isDown("up") or love.keyboard.isDown("z")) and self.on_ground then
		self.vy = self.vy - 980
	end
	
	if love.keyboard.isDown("left") then
		self.vx = math.max(self.vx - 900*dt, -300)
		self.dir = -1
	elseif love.keyboard.isDown("right") then
		self.vx = math.min(self.vx + 900*dt, 300)
		self.dir = 1
	elseif self.on_ground then
		if self.vx > 2 then
			self.vx = self.vx - 900*dt
		elseif self.vx < -2 then
			self.vx = self.vx + 900*dt
		else
			self.vx = 0
		end
	end
	
	if self.last_launch > .2 then
		if #self.stack > 0 then
			if love.keyboard.isDown("c") then
				local star = c_star:new(self.world, self.x, self.y - 32 - 8, table.remove(self.stack))
				self.world:add(star)
				star.vy = -490
				self.last_launch = 0
			elseif love.keyboard.isDown("x") then
				local star = c_star:new(self.world, self.x + self.w*self.dir + 8*self.dir, self.y - 16, table.remove(self.stack))
				self.world:add(star)
				star.vx = 2000 * self.dir
				star.vy = -100
				self.last_launch = 0
			end
		end
	else
		self.last_launch = self.last_launch + dt
	end
	
	c_entity.update(self, dt)
end

function player:draw(dt)
	love.graphics.rectangle("fill", self.x - self.w/2, self.y - self.h/2, self.w, self.h)
	for i=#self.stack, 1, -1 do
		love.graphics.setColor(self.stack[i])
		love.graphics.rectangle("fill", (self.x)-4, (self.y - self.w/2) - (#self.stack - i) * 8, 8, 8)
		love.graphics.setColor(255, 255, 255)
	end
	if self.on_ground then
		love.graphics.print("on ground", 0, 20)
	end
end

function player:collide(obj)
	if obj.stackable and obj.alive then
		obj.alive = false
		table.insert(self.stack, obj.color)
	end
end

return player
