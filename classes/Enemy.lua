local physics = require('physics')
physics.start()
local Player = require('classes.Player')

local Enemy = Player:new()

-- Swing animation
function swing ( )
	transition.to( racketSprite, {time = 100, rotation = 135} )
	transition.to( racketSprite, {time = 200, delay = 100, rotation = 180} )
end

-- Calculates if the ball will be hit or missed
function Enemy:isGoingToHit( )
	-- self.difficulty represents a % the ball will be hit
	rand = math.random(self.difficulty)

	return ( rand == self.difficulty ) 
end

-- Constructs a new enemy object
function Enemy:spawn( x, y, color, difficulty )
	color = color or 'Blue'
	difficulty = difficulty or 2

	-- Define sprites
	self.playerSprite = display.newImage( "kenney_sportspack/PNG/" .. color .. "/character" .. color .. " (1).png", x, y )
	self.racketSprite = display.newImage( "kenney_sportspack/PNG/Equipment/racket_metal.png", x - 30, y + 15 )

	-- Adjust body sprite
	self.playerSprite:scale( 1.5, 1.5 )
	self.playerSprite:rotate( 90 )
	self.playerSprite.tag = 'enemy'

	-- Adjust racket sprite
	self.racketSprite:rotate( 180 )
	self.racketSprite.tag = 'enemyRacket'

	-- Attach physics used for collision
	physics.addBody( self.racketSprite, "static", { isSensor=true } )
	self.racketSprite.op = self
end

return Enemy