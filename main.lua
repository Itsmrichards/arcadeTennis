display.setStatusBar(display.HiddenStatusBar)

timer = require('timer')

physics = require("physics")
physics.start( )
physics.setGravity( 0, 0 )



_CX = display.contentCenterX;
_CY = display.contentCenterY;
_H = display.contentHeight
_W = display.contentWidth

-- Background --
	local options =
	{
	    width = 50,
	    height = 50,
	    numFrames = 3
	}


-- Walls --
	local wallsGroup = display.newGroup( )
	local leftWall = display.newRect( wallsGroup, 0, _CY, 10, _H )
	local rightWall = display.newRect( wallsGroup, _W, _CY, 10, _H )
	local topWall = display.newRect( wallsGroup, _CX, -5, _W, 10 )

	wallsGroup.alpha = 0

	physics.addBody( topWall, "static" )
	physics.addBody( leftWall, "static" )
	physics.addBody( rightWall, "static" )

-- Net --
	local netGroup = display.newGroup( )
	local netHeadLeft = display.newImage( netGroup, "kenney_sportspack/PNG/Elements/element (48).png", 10, _CY )
	local netHeadRight = display.newImage( netGroup, "kenney_sportspack/PNG/Elements/element (49).png", _W - 10, _CY )
	local net = display.newImage( netGroup, "kenney_sportspack/PNG/Elements/element (2).png", _CX, _CY )
	net:scale( 4, 1 )

-- Players --
	local playerGroup = display.newGroup( )
	playerGroup.x, playerGroup.y = _CX, 480
	local player = display.newImage( playerGroup, "kenney_sportspack/PNG/Blue/characterBlue (1).png")
	player:scale( 1.5, 1.5 )
	player:rotate( 270 )

	-- Tennis Racket --
	local racket = display.newImage( playerGroup, "kenney_sportspack/PNG/Equipment/racket_metal.png", 40, -15)

	local function swing( )
		transition.to( racket, {time = 100, rotation = -45} )
		transition.to( racket, {time = 200, delay = 100, rotation = 0} )

		-- if ball.isTouching == true then
		--	ball:applyForce( swingForce, swingForce)
		-- end
	end

	physics.addBody( playerGroup, "static" )

	Runtime:addEventListener( "tap", swing )

-- Tennis Ball --
	local ball = display.newImage( "kenney_sportspack/PNG/Equipment/ball_tennis1.png", _CX, 300)
	ball:scale( 1.5, 1.5 )

	local function onCollision( self, event )
	    if ( event.phase == "began" ) then
	        ball.isTouching = true
	 
	    elseif ( event.phase == "ended" ) then
	        ball.isTouching = false
	    end

	    print(ball.isTouching)
	end
 

	physics.addBody( ball, "dynaimc", {bounce = 1} )
	ball:applyForce( .2, 1)

	ball.collision = onCollision
	ball:addEventListener( "collision" )

function updatePlayer(  )
	playerGroup.x = ball.x
end

timer.performWithDelay( 10, updatePlayer, -1 )


