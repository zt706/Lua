Set = {}			-- 表示集合的Set
local mt = {}		-- 用于集合的元表

function Set.new(l)
	local set = {}
	setmetatable(set, mt)		-- Set创建的集合都有一个共同的元表mt
	-- 将传入的table的value作为新的set的key
	for _, v in ipairs(l) do set[v] = true end
	return set
end

function Set.union (a, b)
	if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
		error("attempt to 'add' a set with a non-set value", 2)
	end
	local res = Set.new{}
	for k in pairs(a) do res[k] = true end	-- a，b中有相同的元素在res在res中是
	for k in pairs(b) do res[k] = true end	-- 同一个key，所以最后res中没有重复元素
	return res
end

function Set.intersection(a, b)
	local res = Set.new{}
	for k in pairs(a) do
		res[k] = b[k]
	end
	return res
end

-- 打印集合的函数
function Set.tostring(set)
	local l = {}
	for e in pairs(set) do
		l[#l + 1] = e
	end
		return "{" .. table.concat(l, ", ") .. "}"
end

function Set.print(s)
	print(Set.tostring(s))
end

-- 添加描述加法的元方法到元表中
mt.__add = Set.union

mt.__le = function(a, b)		--集合包含
	for k in pairs(a) do
		if not b[k] then return false end
	end
	return true
end

mt.__lt = function (a, b)		-- 集合小于
	return a <= b and not (b <= a)
end

mt.__eq = function (a, b)
	return a<= b and b <= a
end

mt.__tostring = Set.tostring	-- 设置__tostrin字段，每次print一个table的时候都会调用

--mt.__metatable = "not your business"

s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 10}
print(getmetatable(s1))
print(getmetatable(s2))

s3 = s1 + s2
Set.print(s3)

s3 = Set.new{2, 4}
s4 = Set.new{4, 10, 2}
print(s3 > s4)
print(s3)




































































































































































































































































