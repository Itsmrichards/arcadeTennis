Enemy = {x=0, y=0, HP=100, lvl=1};
-- Enemy.prototype = {x=0, y=0, HP=100, lvl=1}; 
Enemy.mt = {};
Enemy.mt.__index = Enemy

function Enemy.new (obj)
	obj = obj or {}
	setmetatable(obj, Enemy.mt);
	return obj;
end

function Enemy.speak( obj )
	print(obj.HP)
end

function Enemy.remove( obj )
	obj = nil
end

return Enemy