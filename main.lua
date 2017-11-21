display.setStatusBar(display.HiddenStatusBar)

composer = require('composer')

composer.setVariable( 'playerName', 'Player' )
composer.setVariable( 'enemyDifficulty', 5 )
audio.setVolume( 1 )

composer.gotoScene( 'scenes.options', {time = 500, effect = 'fade', params = { currentLevel = 1 }} )