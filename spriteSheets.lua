local dataSheet = {} -- HOLDS ALL OF OUR ANIMATIONS AND OPTIONS

-------------------------------BACKGROUND DEFINITION---------------------------
dataSheet.backgroundOptions =
{
    frames = 
    {
     	{ x = 0, y = 0, width = 64, height = 64 }, --bg1
      	{ x = 64, y = 0, width = 64, height = 64 }, --bg1
      	{ x = 64, y = 896, width = 64, height = 64 },
      	{ x = 640, y = 64, width = 64, height = 64 }
  	}         

}

dataSheet.menuOptions = 
{
	frames = 
	{
		{ x = 190, y = 98, width = 100, height = 100 }
	}
}

------------RETURNS BACKGROUND OPTIONS----------------------------
function dataSheet:getBgOptions()
    return self.backgroundOptions;
end

function dataSheet:getUIOptions( )
	return self.menuOptions;
end

return dataSheet