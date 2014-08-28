local util = {}

--[[
function util.dist(x1, y1, z1, x2, y2, z2)
	local a = math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
	return math.sqrt(math.pow(a, 2) + math.pow(z1 - z2, 2))
end

function util.dist_obj(obj1, obj2)
	local x1, y1, z1 = obj1.x, obj1.y, obj1.z
	local x2, y2, z2 = obj2.x, obj2.y, obj2.z
	local a = math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
	return math.sqrt(math.pow(a, 2) + math.pow(z1 - z2, 2))
end
]]--

function util.dist(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
end

function util.dist_obj(obj1, obj2)
	local x1, y1, z1 = obj1.x, obj1.y, obj1.z
	local x2, y2, z2 = obj2.x, obj2.y, obj2.z
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))
end

function util.clamp(minimum, num, maximum)
	return math.max(math.min(num, maximum), minimum)
end

return util