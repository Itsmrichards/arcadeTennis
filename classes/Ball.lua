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
	local dx, dy = self.ballSprite:getLinearVelocity( )

	if dy > 0 then
		self.ballSprite:applyForce( 1, -2 )
	else
		self.ballSprite:applyForce( 1, 2 )
	end
end

function onCollision( event )
	local collider = event.other.tag

	local ball = require('scenes.game'):getBall()

	if ( event.phase == 'began' ) then

		-- print(collider)
		-- --print(event.target.isHittable)
		-- print(event.target.isHittable)

		-- The call for this function isn't passing my instance
		-- self.isHittable is set to true in spawn

		if ( collider == 'enemyRacket' and self.isHittable ) then
			ball.hit()
		
		elseif ( collider == 'hitBounds' ) then
			ball.isHittable = true
		end

	elseif (event.phase == 'ended' ) then
		
		if ( collider == 'hitBounds' ) then
			ball.isHittable = false
		
		elseif ( collider == 'ballGone' ) then
			ball:remove()
			-- GAME SCENE ROUND OVER
		end
	end
end

function Ball:spawn( x, y )
	x = x or 0
	y = y or 0

	self.ballSprite = display.newImage( "kenney_sportspack/PNG/Equipment/ball_tennis1.png", x, y)
	self.ballSprite:scale( 1.5, 1.5 )
	self.isHittable = false

	physics.addBody( self.ballSprite, 'dynamic' )
	self.ballSprite.isFixedRotation = true

	self.ballSprite.collision = onCollision
	self.ballSprite:addEventListener( 'collision', onCollision )

	-- self.ballSprite:applyForce( -.08, -.5)
	self.ballSprite:applyForce( 1, .5 )
end

function Ball:inBounds( )
	return self.ballSprite.x < 320 and self.ballSprite.x > 0
end

function Ball:getLocation(  )
	return self.ballSprite.x
end

function Ball:remove( )
	self = nil
end

return Ball