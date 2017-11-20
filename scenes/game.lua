local composer = require('composer')
local spriteData = require('spriteSheets')
local timer = require('timer')
local physics = require('physics')

local Player = require('classes.Player')
local Enemy = require('classes.Enemy')
local Ball = require('classes.Ball')

-- Current instance of singleton objects
local player
local enemy
local ball

local scene = composer.newScene( )

function scene:create( event )
	local sceneGroup = self.view

	-- Commonly used coordinates
	local _W, _H, _CX, _CY = display.contentWidth, display.contentHeight, display.contentCenterX, display.contentCenterY

	-- ENVIROMENT --
		-- Background --
		local background = display.newImage( 'kenney_sportspack/Courts/' .. spriteData.getCourt( event.params.currentLevel ) .. '.png', _CX, _CY )
		background:scale( .85, .85 )
		sceneGroup:insert( background )

		-- Walls --
		local leftWall = display.newRect( sceneGroup, -5, _CY, 10, _H )
		local rightWall = display.newRect( sceneGroup, _W + 5, _CY, 10, _H )

		physics.addBody( leftWall, 'static', { bounce = 1 } )
		physics.addBody( rightWall, 'static', { bounce = 1 } )

		-- Hit Sensors --
		local hitBounds = display.newRect( display.contentCenterX, 475, display.contentWidth, 90 )
		hitBounds.isVisible = false
		hitBounds.tag = 'hitBounds'
		physics.addBody( hitBounds, "static", { isSensor=true } )

		local enemyHitBounds = display.newRect( display.contentCenterX, 15, display.contentWidth, 90 )
		enemyHitBounds.isVisible = false
		enemyHitBounds.tag = 'hitBounds'
		physics.addBody( enemyHitBounds, "static", { isSensor=true } ) 

		local ballBounds = display.newRect( _CX, 550, _W * 2 , 30 )
		ballBounds.tag = 'ballBounds'
		physics.addBody( ballBounds, "static", { isSensor=true } )

	-- PLAYERS --
		-- Human --
		player = Player:new()
		player:spawn( _CX, _H - 20 )

		-- Computer --
		enemy = Enemy:new( { difficulty = 0 } )
		-- spawn( x, y, color )
		enemy:spawn( _CX, 20, event.params.currentLevel )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	local function updatePlayers(  )
		if ball then
			ballLocation = ball:getLocation( )

			player:move( ballLocation )
			enemy:move( ballLocation )
		end
	end

	local function swing(  )
		if ball then
			dx, dy = ball.shape:getLinearVelocity( )

			-- Ball is in play and in right direction
			if ( ball and ball:inBounds() and ball.isHittable and dy > 0 ) then
				ball:hit()
			end
		end

		player:swing( )
	end

	-- Possibly add countdown to resume.
 
	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then

		if ball then
			ball:play( )
		else
			scene:startRound( )
		end

		player:setAlpha( 1 )
		enemy:setAlpha( 1 )

		timer.performWithDelay( 10, updatePlayers, -1 )
		Runtime:addEventListener( 'tap', swing )
		Runtime:addEventListener( "accelerometer", function (  )
			
			-- if ball then
			-- 	ball:pause()
			-- end

			-- player:setAlpha( 0.5 )
			-- enemy:setAlpha( 0.5 )

			composer.gotoScene( 'scenes.pauseOverlay', { time = 500, effect = 'fade' } )
		end )
	end
end

function scene:startRound( )
	print('STARTING A NEW ROUND')

	local roundTextBackground = display.newRoundedRect( self.view, display.contentCenterX, display.contentCenterY - 30, 40, 40, 15)
	roundTextBackground:setFillColor( .5 )
	roundTextBackground.alpha = 0

	local counter = display.newText( self.view, '3', display.contentCenterX + 5, display.contentCenterY - 30, 'kenvector_future_thin.ttf', 40 )
	counter.alpha = 0

	local currentIteration = 3
	timer.performWithDelay( 1000, function (  )


		-- While the count is valid
		if currentIteration > 0 then
			counter.text = currentIteration

			-- Ease the transition
			transition.fadeIn( counter, { time = 200} )
			transition.fadeIn( roundTextBackground, { time = 200 } )
			currentIteration = currentIteration - 1
			counter.alpha = 0
			roundTextBackground.alpha = 0
		else
			-- Once 0, set invisible
			counter.alpha = 0
			roundTextBackground.alpha = 0
		end

	end, 4 )

	timer.performWithDelay( 4000, function (  )
		ball = Ball:new( )
		ball:spawn( self, display.contentCenterX, display.contentCenterY )
	end )
	
end

function scene:roundOver( win )
	ball = nil

	if win then
		local string = "You don't suck"
	else
		local string = 'You suck'
	end

	local roundText = display.newText( string, display.contentCenterX, display.contentCenterY - 30, native.systemFontBold, 30 )
	roundText.alpha = 0

	transition.to( roundText, {time = 1000, alpha = 1, onComplete = function ( )
		transition.to( roundText, {time = 1000, alpha = 0} )
	end } ) 

	self:startRound()
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
 
	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

		if ball then
			ball:pause()
		end

		-- Manualy hide player objects to reuse upon re-entry
		player:setAlpha( 0.5  )
		enemy:setAlpha( 0.5  )
 
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
 
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

	player:remove()
	enemy:remove()

	if ball then
		ball:remove()
	end
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