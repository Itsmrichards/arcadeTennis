local composer = require('composer')
local scene = composer.newScene()
local widget = require('widget')

-- Display group used to clear text upon removal of scene
local textGroup
 
function scene:create( event )
	local sceneGroup = self.view

	-- Commonly used coordinates
	local _W, _H, _CX, _CY = display.contentWidth, display.contentHeight, display.contentCenterX, display.contentCenterY



	-- BACGROUND --
	local background = display.newRect(sceneGroup, 0, 0, 570, 600)
	background.fill = {
		type = 'gradient',
		color1 = { 8/255, 158/255, 0/255 },
		color2 = { 104/255, 183/255, 95/255 } }

	background.x = _W / 2
	background.y = _H / 2

	-----------MENU BACKGROUND --------------------------

	local menuBackground = display.newRoundedRect(sceneGroup, 0, 0, 250, 350, 12)
	menuBackground.x = _W / 2
	menuBackground.y = _H / 2 +20

	-- TITLE --
	local titleGroup = display.newGroup()
	titleGroup.x, titleGroup.y = _CX, 50
	sceneGroup:insert( titleGroup )

	local title = display.newText( { 
		parent = titleGroup, 
		text = "Options", 
		font = "kenvector_future_thin.ttf", 
		fontSize = 30,
		align = 'center'} )

	---------NAME BOX------------

	local nameBox = native.newTextField( 90, 100, 100, 30 )
		titleGroup:insert(nameBox)
		nameBox.align = "center"
		nameBox.width = 170
		nameBox.x = 30
		nameBox.y = 70
		nameBox:setTextColor( 0, .5, 0 )
		nameBox.text = " "

	-- Handle press events for the checkbox

	---------SOUND ON AND OFF--------------
	local function onSwitchPress( event )

    	local switch = event.target

    	print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )

	end
 
	-- Create the widget
	local musicOnOff = widget.newSwitch(
	    {

	        left = -70,
	        top = 140,
	        style = "onOff",
	        id = "musicOnOff",
	        initialSwitchState = true,
	        onRelease = onSwitchPress
	      
		} )

	titleGroup:insert(musicOnOff)

	--------DIFFCULTY TEXT ------

  local difficultyLabel = display.newText( { 
		parent = titleGroup, 
		text = "Difficulty", 
		font = "kenvector_future_thin.ttf", 
		fontSize = 15,
		x=-70,
		y = 210,
		align = 'center'} )

-----------SLIDER TEXT------------

  	local difficultyLow = display.newText( { 
		parent = titleGroup, 
		text = "0", 
		font = "kenvector_future_thin.ttf", 
		fontSize = 15,
		x=-95,
		y = 280,
		align = 'center'} )

  -----------SLIDER TEXT------------


    local difficultyHigh = display.newText( { 
		parent = titleGroup, 
		text = "10", 
		font = "kenvector_future_thin.ttf", 
		fontSize = 15,
		x=100,
		y = 280,
		align = 'center'} )

    -----------NAME TEXT------------

     local nameLabel = display.newText( { 
		parent = titleGroup, 
		text = "Name:", 
		font = "kenvector_future_thin.ttf", 
		fontSize = 15,
		x=-95,
		y = 70,
		align = 'center'} )


     -----------SOUND TEXT------------

      local soundLabel = display.newText( { 
		parent = titleGroup, 
		text = "Sound:", 
		font = "kenvector_future_thin.ttf", 
		fontSize = 15,
		x=-90,
		y = 120,
		align = 'center'} )

      -----------ON TEXT------------

      local soundOnLabel = display.newText( { 
		parent = titleGroup, 
		text = "ON", 
		font = "kenvector_future_thin.ttf", 
		fontSize = 10,
		x=1,
		y = 155,
		align = 'center'} )

      ----------- OFF------------

      local soundOffLabel = display.newText( { 
		parent = titleGroup, 
		text = "OFF", 
		font = "kenvector_future_thin.ttf", 
		fontSize = 10,
		x=-85,
		y = 155,
		align = 'center'} )

      ----------- GIVING COLOR TO ALL THE TEXT------------

	  difficultyLabel:setFillColor(.5, .5, .5)
	  difficultyLow:setFillColor(.5, .5, .5)
	  difficultyHigh:setFillColor(.5, .5, .5)
	  nameLabel:setFillColor(.5, .5, .5)
	  soundLabel:setFillColor(.5, .5, .5)
	  soundOnLabel:setFillColor(.5, .5, .5)
	  soundOffLabel:setFillColor(.5, .5, .5)


	----------- ADDING SLIDER WIDGET------------

	local sliderValue = display.newText( sceneGroup, '5', display.contentCenterX + 2, display.contentCenterY + 90, 'kenvector_future_thin.ttf', 20 )
  	sliderValue:setFillColor(.5, .5, .5)



	self.slider = widget.newSlider(
	    {
	        x = display.contentCenterX,
	        y = display.contentCenterY +60,
	        orientation = "horizontal",
	        height = 200,
	        value = 50,  -- Start slider at 10% (optional)
	        listener = function (  )
	        	if self.slider.value <= 10 then
	        		self.slider.value = 10
	        	end

	        	sliderValue.text = math.floor( self.slider.value / 10 )
	        end
	    }
	)
	sceneGroup:insert( self.slider )


	self.acceptButton = widget.newButton( {
		defaultFile = 'uipack_fixed/PNG/green_button01.png',
		overFile = 'uipack_fixed/PNG/green_button02.png',
		label = '  Accept', labelColor = { default = {1, 1, 1}, over = { 1, 1, 1 } },
		font = 'kenvector_future_thin.ttf',
		width = 150, height = 40,
		x = 200, y = _H -90,
		onRelease = function ( )
			composer.setVariable( playerName, nameBox.text )
			audio.setVolume( musicOnOff.isOn and 1 or 0 )
			composer.setVariable( enemyDifficulty, math.floor (self.slider.value / 10))

			if event.params.sceneFrom then
				composer.gotoScene( 'scenes.game', { time = 200, effect = 'slideRight' } )
			else
				composer.gotoScene( 'scenes.menu', { time = 200, effect = 'slideRight' } )
			end
		end } )


	sceneGroup:insert( self.acceptButton )


	-- BACK BUTTON --
	self.backButton = widget.newButton( {
		defaultFile = 'uipack_fixed/PNG/green_boxCross.png',
		--overFile = 'uipack_fixed/PNG/blue_button02.png',
		width = 50, height = 50,
		x = 70, y = _H -90,
		onRelease = function ( )
			if event.params.sceneFrom then
				composer.gotoScene( 'scenes.game', { time = 200, effect = 'slideRight' } )
			else
				composer.gotoScene( 'scenes.menu', { time = 200, effect = 'slideRight' } )
			end		end } )

	sceneGroup:insert( self.backButton )

end

function scene:show( event )
 
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
	
	end
end
 
function scene:hide( event )
 
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	titleGroup:removeSelf()
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene