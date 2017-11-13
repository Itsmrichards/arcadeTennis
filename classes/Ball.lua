local physics = require('physics')
physics.start()

local Ball = { x = display.contentCenterX, y = display.contentCenterY }

function Ball:new( obj )
	obj = obj or {}
	setmetatable( obj, self )
	self.__index = self
	return obj
end

function Ball:hit( )
	local dx, dy = self.ballSprte:getLinearVelocity( )

	if dy > 0 then
		self.ballSprite:applyForce( 1, -2 )
	else
		self.ballSprite:applyForce( 1, 2 )
	end
end

function Ball:onCollision( event )
	local collider = event.other.tag

	if ( event.phase == 'began' ) then

		print(collider)
		print(event.target.isHittable)

		-- The call for this function isn't passing my instance
		-- self.isHittable is set to true in spawn

		if ( collider == 'enemyRacket' and self.isHittable ) then
			self.hit()
			print('hit')
		
		elseif ( collider == 'hitBounds' ) then
			self.isHittable = true
		end

	elseif (event.phase == 'ended' ) then
		
		if ( collider == 'hitBounds' ) then
			self.isHittable = false
		
		elseif ( collider == 'ballGone' ) then
			self.remove()
			-- GAME SCENE ROUND OVER
		end
	end
end

function Ball:spawn( )
	self.ballSprite = display.newImage( "kenney_sportspack/PNG/Equipment/ball_tennis1.png" )
	self.ballSprite:scale( 1.5, 1.5 )
	self.isHittable = true

	physics.addBody( self.ballSprite, 'dynamic' )
	self.ballSprite.isFixedRotation = true
	self.ballSprite:addEventListener( 'collision', onCollision )

	self.ballSprite:applyForce( 1, .2 )
end

function Ball:inBounds( )
	return self.ballSprite.x < 320 and self.ballSprite.x > 0
end

return Ball