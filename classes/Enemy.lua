local physics = require('physics')
physics.start()
local Player = require('classes.Player')

local Enemy = Player:new()

function swing ( )
	transition.to( racketSprite, {time = 100, rotation = 135} )
	transition.to( racketSprite, {time = 200, delay = 100, rotation = 180} )
end

function onCollision( )
	--local isGoingToHit = math.random( difficulty )
	local isGoingToHit = 1 -- For testing, always hit

	-- Basic AI
	if isGoingToHit == 1 then
		--ball.hit()
		swing()
	end
end

function Enemy:spawn( x, y, color )
	color = color or 'Blue'
	self.playerSprite = display.newImage( "kenney_sportspack/PNG/" .. color .. "/character" .. color .. " (1).png", x, y )
	self.racketSprite = display.newImage( "kenney_sportspack/PNG/Equipment/racket_metal.png", x - 30, y + 15 )

	self.playerSprite:scale( 1.5, 1.5 )
	self.playerSprite:rotate( 90 )
	self.playerSprite.tag = 'enemy'

	self.racketSprite:rotate( 180 )
	self.racketSprite.tag = 'enemyRacket'

	physics.addBody( self.racketSprite, "static", { isSensor=true } )
	self.racketSprite.collision = onCollision
	self.racketSprite:addEventListener( "collision" )
end

return Enemy