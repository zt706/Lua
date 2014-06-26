-- 在table中按索引排序
lines = {
	luaH_set = 10,
	luaH_get = 24,
	luaH_present = 48,
}

function pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do
		a[#a + 1] = n
	end
	table.sort(a)
	local i = 0
	return function ()
		i = i + 1
		return a[i], t[a[i]]
	end
end

for name, line in pairsByKeys(lines) do
	print(name, line)
end

function rconcat (l)
	if type(l) ~= "table" then return l end
	local res = {}
	for i = 1, #l do
		res[i] = rconcat(l[i])
	end
	return table.concat (res, ",")
end

print(rconcat{{"a", {" nice"}}, " and", {{" long"}, {" list"}}})


-- require寻找模块时的搜索策略
function search (modename, path)
	modename = string.gsub(modename, "%.", "/")
	for c in string.gmatch(path, "[^;]+") do
		local fname = string.gsub(c, "?", modename)
		local f = io.open(fname)
		if f then
			f:close()
			return fname
		end
	end
	return nil
end

s = [[then he said: "it's all right"!]]
q, quotedPart = string.match(s, "([\"'])(.-)%1")
print(q, quotedPart)

-- 将$后[]内的表达式计算出来
s = "sin(3) = $[math.sin(3)]; 2^5 = $[2^5]"
print ((string.gsub(s, "$(%b[])", function (x)
		x = "return " .. string.sub(x, 2, -2)
		local f = loadstring(x)
		return f()
end)))

-- 收集一个字符串的所有单词然后插入一个文本
words = {}
string.gsub(s, "(%a+)", function (w)
	table.insert(words, w)
end)

-- 变量展开
function expand(s)
	return (string.gsub(s, "$(%w+)", function (n) print(_G[n])
		return tostring(_G[n])
	end))
end
print(expand("print = $print; a = $a"))

-- 嵌套的变为XML风格
function tomxl (s)
	s = string.gsub(s, "\\(%a+)(%b{})", function(tag, body)
		body = string.sub(body, 2, -2)
		body = tomxl(body)
		return string.format("<%s>%s</%s>",tag, body, tag)
		end)
	return s
end

print(tomxl("\\title{The \\blod{big} example}"))
