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
       color1 = {22/255, 110/255, 252/255},
       color2 = {135/255, 181/255, 255/255}
   }

   background.x = _W / 2
   background.y = _H / 2

   -- TITLE --
   local titleGroup = display.newGroup()
   titleGroup.x, titleGroup.y = _CX, 50

   sceneGroup:insert( titleGroup )

   local title1 = display.newText( { 
      parent = titleGroup, 
      text = "The Great Tap!", 
      font = "kenvector_future_thin.ttf", 
      fontSize = 30,
      align = 'center'} )

   -- Animate the title into place
   transition.from( title1, {time = 500, delay = 1, y = 400, transition = easing.outExpo} )

   -- CREDITS --
   -- List students' names
   local creditText = display.newText( {
      parent = sceneGroup,  
      text = "Jake Clough\nMartin Richards\nChandler Davidson",
      x = 95, y = _H + 10, 
      font = "kenvector_future_thin.ttf", 
      fontSize = 15 } )

   -- Animate the credits into place
   transition.from( creditText, {time = 800, delay = 800, y = -200, transition = easing.outExpo} )

   -- PLAY BUTTON --
   -- Start the game, using a smooth transition
   local playGroup = display.newGroup( )
      sceneGroup:insert(playGroup)
      playGroup.x, playGroup.y = _CX, _CY

      self.playButton = widget.newButton( {
         defaultFile = 'uipack_fixed/PNG/blue_button04.png',
         overFile = 'uipack_fixed/PNG/blue_button02.png',
         width = 120, height = 60,
         x = - 5, y = 0,
         onRelease = function ( )
            composer.gotoScene( 'scenes.game', {time = 200, effect = 'slideRight', params = {currentLevel = 1}} )
         end
         } )
      playGroup:insert( self.playButton )
         
      local playText = display.newText( {
         parent = playGroup,
         text = "Play!",
         x = 0, y = 0,
         font = "kenvector_future_thin.ttf", 
         fontSize = 20 } )

   -- OPTIONS BUTTON
   -- Change settings, using a smooth transition
   local optionsGroup = display.newGroup( )
      sceneGroup:insert(optionsGroup)
      optionsGroup.x, optionsGroup.y = _CX, _CY + 100

      self.optionsButton = widget.newButton( {
         defaultFile = 'uipack_fixed/PNG/blue_button04.png',
         overFile = 'uipack_fixed/PNG/blue_button02.png',
         width = 130, height = 60,
         x = -5, y = 0,
         onRelease = function ( )
            composer.gotoScene( 'scenes.options', {time = 500, effect = 'slideUp'})
         end
      } )
      optionsGroup:insert(self.optionsButton)

      local playText = display.newText( {
         parent = optionsGroup,
         text = "Options",
         x = 0, y = 0,
         font = "kenvector_future_thin.ttf", 
         fontSize = 20 } )

end

function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
   end
end
 
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

function scene:destroy( event )
   local sceneGroup = self.view
   titleGroup:removeSelf()
   optionsGroup:removeSelf( )
   playGroup:removeSelf( )
   creditText = nil
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene