-- display.setStatusBar(display.HiddenStatusBar)

-- composer = require('composer')
-- composer.gotoScene( 'scenes.gameBox', {time = 500, effect = 'fade'} )

Player = require('classes.Player')
Enemy = require('classes.Enemy')
Ball = require('classes.Ball')

a = Player:new()
a:spawn(display.contentCenterX, display.contentCenterY)

b = Enemy:new()
b:spawn(display.contentCenterX, 30)

c = Ball:new()
c = Ball:spawn()