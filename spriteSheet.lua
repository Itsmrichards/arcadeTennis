local dataSheet = {} -- HOLDS ALL OF OUR ANIMATIONS AND OPTIONS

-------------------------------BACKGROUND DEFINITION---------------------------
dataSheet.backgroundOptions =
{
    frames = 
    {
         { x = 0, y = 0, width = 64, height = 64}, --bg1
  	}         

}

------------RETURNS BACKGROUND OPTIONS----------------------------
function dataSheet:getBgOptions()
    return self.backgroundOptions;
end

return dataSheet