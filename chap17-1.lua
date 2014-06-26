-- 备忘录函数

local results = {}
setmetatable(results, {__mode = "kv"})
function mem_loadstring(s)
	local res  = results[s]
	if res == nil then
		res = assert(loadstring(s))
		results[s] = res
	end
	return res
end

resultRGB = {}
setmetatable(resultRGB, {__mode = "v"})

function createRGB(r, g, b)
	local key = r .. "-" .. g .. "-" .. "b"
	local color = resultRGB[key]
	if color == nil then
		color = {red = r, green = g, blue = b}
		resultRGB[key] = color
	end
	return color
end

-- 每个table与其默认值保存在一个弱引用的table中
local defaults = {}
setmetatable(defaults, {__mode = "k"})
local mt = {__index = function (t) return defaults[t] end}
function setDefault(t, d)
	defaults[t] = d
	setmetatable(t, mt)
end

-- 不同的默认值使用不同的元表
local metas = {}
setmetatable(metas, {__mode = "v"})
function setDefault(t, d)
	local mt = metas[d]
	if mt == nil then
		mt = {__index = function () return d end}
		metas[d] = mt
	end
	setmetatable(t, mt)
end

