--[[local count = 0
function Entry()
	count = count + 1
end
dofile("data.lua")
print("number of entries: " .. count)
]]


local authors = {}
function Entry (b)
	--authors[b[1]] = true
	table.insert(authors, b[1])
end
dofile("data.lua")
for _,v in pairs(authors) do
	print(_,v)
end

function serialize (o)
	if type(o) == "number" then
		io.write(o)
	elseif type(o) == "string" then
		io.write(string.format("%q", o))
	else

	end
end
--serialize('a "problematic" \\string')

function quote(s)
	-- 查找最长等号序列
	local n = -1
	local ww = 1
	for w in string.gmatch(s, "]=*") do
		n = math.max(n, #w - 1)
	end
	local eq = string.rep("=", n + 1)
	--print(s)
	return string.format(" [%s[\n%s]%s] ", eq, s, eq)
end

function basicSerialize (o)
	if type(o) == "number" then
		--print("key is ", o)
		return tostring(o)
	else
		--print("key is ", o)
		return string.format("%q", o)
	end
end

function save (name, value, saved)
	saved = saved or {}
	--print(value)
	io.write (name, " = ")
	if type(value) == "number" or type(value) == "string" then
		io.write(basicSerialize(value), "\n")
	elseif type (value) == "table" then
		if saved[value] then					--该value之前保存过
			io.write(saved[value], "\n")		-- 使用先前的名字
		else
			saved[value] = name					-- 为下次使用保持名字
			--print(saved[value])
			io.write("{}\n")					-- 创建一个新的table
			for k, v in pairs(value) do			-- 保存其字段
				k = basicSerialize(k)
				local fname = string.format("%s[%s]", name, k)
				save(fname, v, saved)
			end
		end
	else
		error("cannot save a " .. type(value))
	end
end
local t = {}
a = {x = 1, y = 2; {3, 4, 5}}
a[2] = a
a.z = a[1]
save("a", a, t)

--[==[
a = {{"one", "two"}, 3}
b = {k = a[1]}
b[1] = a[2]
local t = {}

save("a", a, t)
save("b", b, t)]==]
for k, v in pairs(t) do
	print("in table t ", k, v)
end

for n in pairs(_G) do
	print(n)
end









































































































