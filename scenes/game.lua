local composer = require( "composer" )
local spriteData = require("spriteSheets")
local timer = require('timer')
local physics = require('physics')
physics.start()
physics.setGravity( 0, 0 )

local Player = require('classes.Player')
local Enemy = require('classes.Enemy')
local Ball = require('classes.Ball')

-- Commonly used coordinates
local _W, _H, _CX, _CY = display.contentWidth, display.contentHeight, display.contentCenterX, display.contentCenterY

local scene = composer.newScene( )

-- Restart the scene
function scene:startRound( )
	ball = Ball:new()
	ball:spawn( self, _CX, _CY )
end

function scene:create( event )
	local sceneGroup = self.view

   	-- Table of court images --
   		local players = { 'Blue','Red', 'White' }
		local courts = { 'blue-white', 'green-white', 'red-white', 'tan-blue', 'tan-white' }
		local background = display.newImage( sceneGroup, 'kenney_sportspack/Courts/' .. courts[ event.params.currentLevel ] .. '.png', _CX, _CY)
		background:scale( .85, .85 )
		
	-- Walls --
		local leftWall = display.newRect( sceneGroup, 0, _CY, 10, _H )
		local rightWall = display.newRect( sceneGroup, _W, _CY, 10, _H )
		leftWall.tag, rightWall.tag = 'left', 'right'

		leftWall.alpha, rightWall.alpha = 0, 0
		physics.addBody( leftWall, "static", { bounce = 1 } )
		physics.addBody( rightWall, "static", { bounce = 1 } )

	-- Sensor where the player can hit the ball
		local hitBounds = display.newRect( display.contentCenterX, 475, display.contentWidth, 90 )
		hitBounds.isVisible = false
		hitBounds.tag = 'hitBounds'
		physics.addBody( hitBounds, "static", { isSensor=true } )

	-- Sensor where the enemy can hit the ball
		local enemyHitBounds = display.newRect( display.contentCenterX, 15, display.contentWidth, 90 )
		enemyHitBounds.isVisible = false
		enemyHitBounds.tag = 'hitBounds'
		physics.addBody( enemyHitBounds, "static", { isSensor=true } )

	-- Sensor behind the player
		local ballGone = display.newRect( _CX, 550, _W * 2 , 30 )
		ballGone.tag = 'ballGone'
		physics.addBody( ballGone, "static", { isSensor=true } )

	-- Players -- 
		player = Player:new()
		player:spawn( _CX, _H - 20 )
		player:move(0)

		enemy = Enemy:new()
		enemy:spawn( _CX, 20, players[ event.params.currentLevel ], 2)

	-- Start Round
		scene:startRound()

	local function updatePlayers( )
		if (ball.sprite ~= nil) then
			ballLocation = ball:getLocation()

			player:move( ballLocation )
			enemy:move( ballLocation )
		end
	end

	timer.performWithDelay( 10, updatePlayers, -1 )

end

local function swing( )
	if ( ball:inBounds() and ball.isHittable ) then
		ball:hit()
	end

	player:swing()
end

Runtime:addEventListener( 'tap', swing )

function scene:roundOver( )
	local text = display.newText( "You suck", display.contentCenterX, display.contentCenterY - 30, native.systemFontBold, 30 )
	text.alpha = 0
	transition.to( text, {time = 1000, alpha = 1, onComplete = function ( )
		transition.to( text, {time = 1000, alpha = 0} )
	end} )
	-- Problem lies here!!!!
	-- scene:startRound()
end

function scene:show( event )
 
	local sceneGroup = self.view
	local phase = event.phase
 
	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
 		-- Update the character positions indefinitely
		-- timer.performWithDelay( 10, updatePlayers, -1 )
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