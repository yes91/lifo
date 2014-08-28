local class = require "cls.middleclass"
local util = require "util"

local world = class("world")

function world:initialize()
	self.all_objects = {}
end

function world:update(dt)
	for i=#self.all_objects, 1, -1  do
		if not self.all_objects[i].alive then
			table.remove(self.all_objects, i)
			--self.all_objects[i] = nil
		end
	end
	
	for k, v in ipairs(self.all_objects) do
		v.px = v.x
		v.py = v.y
		v:update(dt)
		v.on_ground = false
		if v.collidable and v.movable then
			local collisions = {}
			for l, w in ipairs(self.all_objects) do
				if w.collidable and w ~= v then
					if self:check_collision(v, w) then
						table.insert(collisions, w)
					end
				end
			end
			
			for l, w in ipairs(collisions) do
				world:resolve_collision(v, w)
			end
			
			if v.on_ground then
			
			else
				v.vy = v.vy + 980*dt 
			end
	
			v.x = v.x + v.vx * dt
			v.y = v.y + v.vy * dt
		elseif not v.collidable and v.movable then
			v.x = v.x + v.vx * dt
			v.y = v.y + v.vy * dt
		end
	end
end

function world:draw(dt)
	for k, v in ipairs(self.all_objects) do
		v:draw(dt)
	end
end

function world:get_all_objects()
	return self.all_objects
end

function world:add(object)
	table.insert(self.all_objects, object)
end

function world:remove(index)
	table.remove(self.all_objects, index)
end

function world:check_collision(a, b) 
	if (a.x + a.w/2) <= (b.x - b.w/2) or
	(a.x - a.w/2) >= (b.x + b.w/2) or
	(a.y + a.h/2) <= (b.y - b.h/2) or
	(a.y - a.h/2) >= (b.y + b.h/2) then
		return false
	else
		return true
	end
end

function world:collision_area(a, b)
	local ahw, ahh = a.w/2, a.h/2
	local bhw, bhh = b.w/2, b.h/2
	local ix, iy
	
	if a.x > b.x then
		ix = (b.x + bhw) - (a.x - ahw)
	else
		ix = (a.x + ahw) - (b.x - bhw) 
	end
	
	if a.y > b.y then
		iy = (b.y + bhh) - (a.y - ahh)
	else
		iy = (a.y + ahh) - (a.y - ahh)
	end
	
	return (ix * iy)
end

function world:resolve_collision(a, b)
	a:collide(b)
	b:collide(a)
	if not (b.stackable and a.type == "Player" or b.type=="Player" and a.stackable or b.type=="Player") then
		local ahw, ahh = a.w/2, a.h/2
		local bhw, bhh = b.w/2, b.h/2
		local ix, iy
		
		if a.x > b.x then
			ix = (b.x + bhw) - (a.x - ahw)
		else
			ix = (b.x - bhw) - (a.x + ahw) --Results in negative
		end
		
		if a.y > b.y then
			iy = (b.y + bhh) - (a.y - ahh)
		else
			iy = (b.y - bhh) - (a.y + ahh) --Results in negative
		end
		
		if math.abs(ix) < math.abs(iy) then
			if b.movable then  -- Both are movable!
				a.x = a.x + ix/2
				b.x = b.x - ix/2
				local peen = a.vx
				a.vx = b.vx * (b.w/a.w)
				b.vx = peen * (a.w/b.w)
			else
				a.x = a.x + ix
				if ix < 0 and a.vx > 0 then
					a.vx = 0
				elseif ix > 0 and a.vx < 0 then
					a.vx = 0
				end
			end
		else
			if b.movable then  -- Both are movable!
				a.y = a.y + iy/2
				b.y = b.y - iy/2
				local peen = a.vy
				a.vy = b.vy
				b.vy = peen
			else
				a.y = a.y + iy
				if iy < 0 and a.vy > 0 then
					a.vy = 0
				elseif iy > 0 and a.vy < 0 then
					a.vy = 0
				end
			end
			
			if iy <= 0 then
				a.on_ground = true
			end
		end
	end
end

function world:resolve_collision2(a, b)
	if not (b.stackable and a.type == "Player" or b.type=="Player" and a.stackable) then
		local angle = math.atan((a.y-a.py)/(a.x-a.px))
		if a.px <= a.x then
			angle = math.pi + angle
		end
		local xn = math.cos(angle)
		local yn = math.sin(angle)
		local cnt = 0
		while (self:check_collision(a, b)) do
			a.x = a.x + 0
			a.y = a.y - .2
			a.vx = 0
			a.vy = 0
			cnt = cnt + 1
		end
	end
end

return world
