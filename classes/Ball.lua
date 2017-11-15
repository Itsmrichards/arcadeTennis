local physics = require('physics')
physics.start()

-- Default parameter
local Ball = { x = display.contentCenterX, y = display.contentCenterY }

-- Default constructor
function Ball:new( obj )
	obj = obj or {}
	setmetatable( obj, self )
	self.__index = self
	return obj
end

-- Change the direction and apply a random speed 
function Ball:hit( )
	local dx, dy = self.sprite:getLinearVelocity( )

	local hitPower = math.random( 1, 4 ) * 100
	local hitDirection = math.random( 0, 1 )

	if hitDirection == 0 then
		hitDirection = -1
	end

	print('Ball Velocity: ' .. hitPower * hitDirection .. ', ' .. dy )
	self.sprite:setLinearVelocity( hitPower * hitDirection, dy * -1 )
end

-- Handle the collision
local function onCollision( event )
	local other = event.other

	local ball = event.target.op

	if ( event.phase == 'began' ) then

		if ( other.tag == 'enemyRacket' and ball.isHittable ) then
			-- other.op:swing()

			-- if ( other.op:tryToHit() ) then
				ball:hit()
			-- end
		
		elseif ( other.tag == 'hitBounds' ) then
			ball.isHittable = true
		end

	elseif (event.phase == 'ended' ) then
		
		if ( other.tag == 'hitBounds' ) then
			ball.isHittable = false
		
		elseif ( other.tag == 'ballGone' ) then
			-- GAME SCENE ROUND OVER
			ball.scene:roundOver()
			ball:remove()
		end
	end
end

-- Intialize properties
function Ball:spawn( scene, x, y )
	x = x or 0
	y = y or 0

	self.sprite = display.newImage( "kenney_sportspack/PNG/Equipment/ball_tennis1.png", x, y)

	self.sprite:scale( 1.5, 1.5 )
	self.isHittable = false

	self.scene = scene

	physics.addBody( self.sprite, 'dynamic' )
	self.sprite.isFixedRotation = true
	self.sprite.op = self

	self.sprite:addEventListener( 'collision', onCollision )

	if self.sprite ~= nil then
		self.sprite:applyForce( 1, .5 )
	end
end

-- Check if ball is still in play
function Ball:inBounds( )
	if self.sprite ~= nil then
		return self.sprite.x < 320 and self.sprite.x > 0
	end
end

-- Get the current location
function Ball:getLocation(  )
	return self.sprite.x
end

-- Destructor
function Ball:remove( )
	self.sprite:removeSelf( )
	self.sprite = nil
	self = nil
end

return Ball