local composer = require( "composer" )
local spriteData = require("spriteSheets")
local timer = require('timer')
local physics = require('physics')

local player = require('classes.player')
local enemy = require('classes.enemy')
local ball = require('classes.ball')

physics.start()
physics.setGravity( 0, 0 )

local scene = composer.newScene()
 
function scene:create( event )
	local sceneGroup = self.view
	
	-- Commonly used coordinates
   		local _W, _H, _CX, _CY = display.contentWidth, display.contentHeight, display.contentCenterX, display.contentCenterY

   	-- Table of court images --
		local courts = { 'blue-white', 'green-white', 'red-white', 'tan-blue', 'tan-white' }
		local background = display.newImage( sceneGroup, 'kenney_sportspack/Courts/' .. courts[1] .. '.png', _CX, _CY)
		background:scale( .85, .85 )

	-- Walls --
		local leftWall = display.newRect( sceneGroup, 0, _CY, 10, _H )
		local rightWall = display.newRect( sceneGroup, _W, _CY, 10, _H )
		leftWall.alpha, rightWall.alpha = 0, 0
		physics.addBody( leftWall, "static", { bounce = 1 } )
		physics.addBody( rightWall, "static", { bounce = 1 } )

	-- Sensor where the player can hit the ball
		local hitBounds = display.newRect( display.contentCenterX, 475, display.contentWidth, 90 )
		hitBounds.isVisible = false
		hitBounds.name = 'hitBounds'
		physics.addBody( hitBounds, "static", { isSensor=true } )

	-- Sensor where the enemy can hit the ball
		local enemyHitBounds = display.newRect( display.contentCenterX, 15, display.contentWidth, 90 )
		enemyHitBounds.isVisible = false
		enemyHitBounds.name = 'hitBounds'
		physics.addBody( enemyHitBounds, "static", { isSensor=true } )

	-- Sensor behind the player
		local ballGone = display.newRect( _CX, 550, _W * 2 , 30 )
		ballGone.name = 'ballGone'
		physics.addBody( ballGone, "static", { isSensor=true } )

	-- Players --
		-- Define the player objects here
		player.new( sceneGroup, _CX, _H, 'green')
		enemy.new( self, sceneGroup, _CX, 5, 'green', 5)

	-- Tennis Ball --
		scene:startRound()

	local function swing( )
		print( ball.getHittable() )
		if (ball.inBounds() and ball.getHittable() ) then
			ball.hit()
		end
		enemy.swing()
		player.swing()
	end

	Runtime:addEventListener( "tap", swing )
end

local function updatePlayers( )
		if (ball.inBounds()) then
		player.move( ball.getLocation() )
		enemy.move( ball.getLocation() )
		end
end

function scene:startRound( )
	print('here')
	ball.new( display.contentCenterX, display.contentCenterY )
	ball.start()
end

function scene:Loser ( )
	local text = display.newText( "You suck", display.contentCenterX, display.contentCenterY - 30, native.systemFontBold, 30 )
	text.alpha = 0
	transition.to( text, {time = 1000, alpha = 1, onComplete = function ( )
		transition.to( text, {time = 1000, alpha = 0} )
	end} )
	-- Problem lies here!!!!
	scene:startRound()
end

 
function scene:show( event )
 
	local sceneGroup = self.view
	local phase = event.phase
 
	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
 		-- Update the character positions indefinitely
		timer.performWithDelay( 10, updatePlayers, -1 )
	elseif ( phase == "did" ) then

	end
end
 
 
function scene:hide( event )
 
	local sceneGroup = self.view
	local phase = event.phase
 
	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
 
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
 
	end
end
 
 
-- destroy()
function scene:destroy( event )
 
	local sceneGroup = self.view

	player.remove()
	enemy.remove()
	ball.remove()
	-- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene