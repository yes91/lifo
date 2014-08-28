local c_game = require "cls.game"

local game
function love.load()
	math.randomseed(os.time())
	game = c_game:new()
end

function love.update(dt)
	game:update(dt)
end

function love.draw(dt)
	game:draw()
end
