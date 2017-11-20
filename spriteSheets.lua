local dataSheet = {} -- HOLDS ALL OF OUR ANIMATIONS AND OPTIONS

-------------------------------BACKGROUND DEFINITION---------------------------
dataSheet.backgroundOptions =
{
	'blue-white', 'green-white', 'red-white', 'tan-blue',       
}

dataSheet.menuOptions = 
{
	frames = 
	{
		{ x = 190, y = 98, width = 100, height = 100 }
	}
}

dataSheet.playerOptions =
{
	'Blue', 'Red', 'White'
}

------------RETURNS BACKGROUND OPTIONS----------------------------
function dataSheet:getBgOptions()
	return self.backgroundOptions;
end

function dataSheet:getUIOptions( )
	return self.menuOptions;
end

function dataSheet:getCourt( level )
	level = level or 1

	return dataSheet.backgroundOptions[level]
end

return dataSheet