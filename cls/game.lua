local class = require "cls.middleclass"
local c_world = require "cls.world"
local c_player = require "cls.player"
local c_block = require "cls.block"
local c_star = require "cls.star"
local c_enemy = require "cls.enemy"

local game = class("game")

local player

function game:initialize()
	self.world = c_world:new()
	player = c_player:new(self.world, 100, -100)
	self.world:add(player)
	for i=1, 10 do
		self.world:add(c_star:new(self.world, math.random()*800, -math.random()*200))
	end
	
	self.world:add(c_block:new(self.world, 600, 0, 1200, 100))
	self.world:add(c_block:new(self.world, -50, -100, 100, 400))
	self.world:add(c_block:new(self.world, 1050, -100, 100, 400))
	
	for i=1, 10 do
		self.world:add(c_enemy:new(self.world, math.random()*800, -4000*math.random()))
	end
end

function game:update(dt)
	self.world:update(dt)
end

function game:draw(dt)
	love.graphics.print(#self.world.all_objects)
	love.graphics.push()
	love.graphics.translate(-player.x + 400, -player.y + 400)
	self.world:draw(dt)
	love.graphics.pop()
	love.graphics.print(player.x .. ", " .. player.y, 0, 20)
end

function game:reset()
	self:initialize()
end

return game
