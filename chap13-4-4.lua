-- 跟踪所有元表
local index = {}		-- 创建私有索引

local mt = {			-- 创建元表
	__index = function (t, k)
		print("*access to element " .. tostring(k))
		return t[index][k]		--访问原来的table
	end,
	__newindex = function(t, k, v)
		print("*update of element " .. tostring(k) ..
					" to ".. tostring(v))
		t[index][k] = v			-- 更新原来的table
	end,
	__pairs = function (t)
					return function(t, k)
						return next(t[index], k)
					end, t
			  end
}

function track(t)
	local proxy = {}			-- 代理（子类）中什么都没有，会去访问原型表（父类）
	proxy[index] = t			-- 将每个代理与原table关联起来
	setmetatable(proxy, mt)		-- 所有的代理共享一个公共的元表
	return proxy
end

t = {}
t = track(t)					-- 返回的t现在是个代理了
t[2] = "hello"					-- 代理中没有的key会去原来的父类中操作
print(t[2])

