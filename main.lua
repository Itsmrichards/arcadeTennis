display.setStatusBar(display.HiddenStatusBar)

composer = require('composer')
composer.gotoScene( 'scenes.game', {time = 500, effect = 'fade', params = { currentLevel = 1 }} )