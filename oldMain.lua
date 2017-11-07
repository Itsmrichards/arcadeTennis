display.setStatusBar(display.HiddenStatusBar)

timer = require('timer')

physics = require("physics")
physics.start( )
physics.setGravity( 0, 0 )



_CX = display.contentCenterX
_CY = display.contentCenterY
_H = display.contentHeight
_W = display.contentWidth


local spriteData = require("spriteSheets")
local backgroundSheet = graphics.newImageSheet( "kenney_sportspack/Tilesheet/groundGravel.png",  spriteData:getBgOptions());
local background = display.newImage( backgroundSheet, 1 )

	background.x = display.contentWidth / 2;
	background.y = display.contentHeight / 2;

  	background.xScale = 5
	background.yScale = 9

	local bg3 = display.newImage( backgroundSheet, 3 )
	bg3.x = 160
	bg3.y = -40;
	bg3:rotate( 90 )
	bg3.yScale = 5

	local bg7 = display.newImage( backgroundSheet, 3 )
	bg7.x = 4
	bg7.y = 230;
	bg7.yScale = 10

	local bg8 = display.newImage( backgroundSheet, 3 )
	bg8.x = 270
	bg8.y = 230;
	bg8.yScale = 10

	local bg2 = display.newImage( backgroundSheet, 2 )
	bg2.x = 50
	bg2.y = 6;

	local bg4 = display.newImage( backgroundSheet, 2 )
	bg4.x = 270
	bg4.y = 6;
	bg4:rotate( 180 )
	bg4.yScale = -1

	local bg4 = display.newImage( backgroundSheet, 3 )
	bg4.x = 160
	bg4.y = 480;
	bg4:rotate( 90 )
	bg4.yScale = 5

	local bg5 = display.newImage( backgroundSheet, 2 )
	bg5.x = 270
	bg5.y = 480;
	bg5:rotate( 180 )

	local bg6 = display.newImage( backgroundSheet, 2 )
	bg6.x = 50
	bg6.y = 480;
	bg6:rotate( 0 )
	bg6.yScale = -1

local hitBounds = display.newRect( display.contentCenterX, 475, display.contentWidth, 90 )
hitBounds.isVisible = false
physics.addBody( hitBounds, "static", { isSensor=true } )


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
	--local playerGroup = display.newGroup( )
	--playerGroup.x, playerGroup.y = _CX, 480
	local player = display.newImage( "kenney_sportspack/PNG/Green/characterGreen (1).png")
	player.x, player.y = _CX, 480
	player:scale( 1.5, 1.5 )
	player:rotate( 270 )

	-- Tennis Racket --
	local racket = display.newImage( "kenney_sportspack/PNG/Equipment/racket_metal.png")
	racket.x, racket.y = _CX + 30, 465

	local enemy = display.newImage( "kenney_sportspack/PNG/Blue/characterBlue (1).png")
	enemy.x, enemy.y = _CX, 20
	enemy:scale( 1.5, 1.5 )
	enemy:rotate( 90 )

	local enemyRacket = display.newImage( "kenney_sportspack/PNG/Equipment/racket_metal.png")
	enemyRacket.x, enemyRacket.y = _CX - 40, 15
	enemyRacket:rotate(180)

	local function swing( )

		if ball.isTouching == true then
			ball:applyForce( 0, -3)
			print('great shot!')
		 end
		 
		transition.to( racket, {time = 100, rotation = -45} )
		transition.to( racket, {time = 200, delay = 100, rotation = 0} )
	end

	Runtime:addEventListener( "tap", swing )

-- Tennis Ball --
	ball = display.newImage( "kenney_sportspack/PNG/Equipment/ball_tennis1.png", _CX, 300)
	ball:scale( 1.5, 1.5 )

local ballGone = display.newRect( _CX, 550, _W * 2 , 30 )
physics.addBody( ballGone, "static", { isSensor=true } )

	function loser (  )
		local text = display.newText( "You suck", _CX, _CY - 30, native.systemFontBold, 30 )
		text.alpha = 0
		transition.to( text, {time = 1000, alpha = 1, onComplete = function ( )
			transition.to( text, {time = 1000, alpha = 0} )
		end} )
	end

	local function onCollision( self, event )
		if (event.other == ballGone) then
			loser()
		end


		if (event.other == hitBounds) then
		    if ( event.phase == "began" ) then
		        ball.isTouching = true
		 
		    elseif ( event.phase == "ended" ) then
		        ball.isTouching = false
		    end
		end
	end
 

	physics.addBody( ball, "dynaimc", {bounce = 1} )
	ball:applyForce( .2, 1)

	ball.collision = onCollision
	ball:addEventListener( "collision" )

function updatePlayer(  )
	if (ball.x < 320 and ball.x > 0) then
		player.x = ball.x - 40
		racket.x = ball.x 

		enemy.x = ball.x + 40
		enemyRacket.x = ball.x
	end
end

timer.performWithDelay( 10, updatePlayer, -1 )


