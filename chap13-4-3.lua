Window = {}
Window.prototype = {x = 0, y = 0, width = 100, height = 100}
Window.mt = {}		--  创建元表

function Window.new(o)
	setmetatable(o, Window.mt)
	return o
end

-- 这种写法与将__index赋值为一个table效果一样
-- Window.mt.__index = Window.prototype
Window.mt.__index = function (table, key)
	return Window.prototype[key]	-- 元方法会用这个不存在的key来索引原型（父类）
end

w = Window.new{x = 10, y = 20}
print(w.width)
print(rawget(w,width))		-- 仅仅访问子类的width字段，子类没有，输出nil

Window.mt.__newindex = Window.prototype
w.xxx=1000			-- 由于设置了__newinde为一个table，会在父类中添加xxx=1000
print(Window.prototype.xxx)
print(w.xxx)		-- 由于设置了__index元方法，没有的字段会去父类（prototype）中查询

rawset(w, "yyy", 999)		-- 只在子类添加yyy字段
print(Window.prototype.yyy)
print(w.yyy)				-- 子类中有的字段不会去调用__index元方法

