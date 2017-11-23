display.setStatusBar(display.HiddenStatusBar)

composer = require('composer')

-- Define initial game settings as globals --
composer.setVariable( 'playerName', 'Player' )
composer.setVariable( 'enemyDifficulty', 5 )
audio.setVolume( 1 )

-- Start the game
composer.gotoScene( 'scenes.menu', {time = 500, effect = 'fade', params = { currentLevel = 1 }} )