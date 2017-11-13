local Player = { color ='Green' }

function Player:new ( obj )
	obj = obj or {}
	setmetatable( obj, self )
	self.__index = self
	return obj
end

function Player:spawn( x, y )
	x = x or 0
	y = y or 0
	self.playerSprite = display.newImage( "kenney_sportspack/PNG/Green/characterGreen (1).png", x, y )
	self.racketSprite = display.newImage( "kenney_sportspack/PNG/Equipment/racket_metal.png", x + 30, y - 15 )

	self.playerSprite:scale( 1.5, 1.5 )
	self.playerSprite:rotate( 270 )
end

function Player:move( x )
	self.playerSprite = x - 30
	self.racketSprite = x
end

function Player:swing( )
	transition.to( self.racketSprite, {time = 100, rotation = -45} )
	transition.to( self.racketSprite, {time = 200, delay = 100, rotation = 0} )
end

function Player:remove( obj )
	obj = nil
end

return Player