-- 打印_G表的字段

function getfield (f)
	local v = _G		-- 从全局的_G开始
	for w in string.gmatch(f, "([%w_]+)(%.?)") do
		v = v[w]		-- 逐个字段的深入求值
	end
	return v
end

print(getfield("io.read"))

function setfield(f, v)
	local t = _G
	for  w, d in string.gmatch(f, "([%w_]+)(%.?)") do
		if d == "." then
			t[w] = t[w] or {}
			t = t[w]
		else
			t[w] = v
		end
	end
end

setfield("t.x.y", 10)
print(t.x.y)






















