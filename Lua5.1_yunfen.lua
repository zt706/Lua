--2.8
function add_event(op1, op2)
	local o1, o2 = tonumber(op1), tonumber(op2)
	if o1 and o2 then
		return o1 + o2
	else
		local h = getbinhandler(op1, op2, "__add")
		if h then
			return h(op1, op2)
		else
			error ("...")
		end
	end
end

function unm_event(op)
	local o = tonumber(op)
	if o then
		return -o
	else
		local h = metatable(op).__unm
		if h then
			return h(op)
		else
			error("...")
		end
	end
end

function concat_event(op1, op2)
	if (type(op1) == "string" or type(op1) == "number") and
	   (type(op2) == "string" or type(op2) == "number") then
		return op1 .. op2
	else
		local h = getbinhandler(op1, op2, "__concat")
		if h then
			return h(op1, op2)
		else
			error ("...")
		end
	end
end

function len_event(op)
	if type(op) == "string" then
		return strlen(op)
	elseif type(op) == "table" then
		return #op
	else
		local h = metatable(op).__len
		if h then
			return h(op)
		else
			error ("...")
		end
	end
end

function getcomphandler(op1, op2, event)
	if type(op1) ~= type(oop2) then return nil end
	local mm1 = metatable(op1)[event]
	local mm2 = metatable(op2)[event]
	if mm1 == mm2 then return mm1 else return nil end
end

function eq_event(op1, op2)
	if type(op1) ~= type(op2) then
		return false
	end
	if op1 == op2 then
		return true
	end
	--尝试使用元方法
	local h = getcomphandler(op1, op2, "__eq")
	if h then
		return h(op1, op2)
	else
		return false
	end
end

function lt_event(op1, op2)
	if type(op1) == "number" and type(op2) == "number" then
		return op1 < op2
	elseif type(op1) == "string" and type(op2) == "string" then
		return op1 < op2
	else
		local h = getcomphandler(op1, op2, "__lt")
		if h then
			return h(op1, opo2)
		else
			error ("...")
		end
	end
end

function le_event(op1, op2)
	if type(op1) == "number" and type(op2) == "number" then
		return op1 <= op2
	elseif type(op1) == "string" and type(op2) == "sting" then
		return op1 <= op2
	else
		local h = getcomphandler(op1, op2, "__le")
		if h then
			return h(op1, op2)
		else
			h = getcomphandler(op1, op2, "__lt")
			if h then
				return not h(op1, op2)
			else
				error ("...")
			end
		end
	end
end

function gettable_event(table, key)
	local h
	if type(tabel) == "tabel" then
		local v = rawget(table, key)
		if v ~= nil then return v end
		h = metatable(table).__index
		if h == nil then return nil end
	else
		h = metatable(tabel).__index
		if h == nil then
			error("...")
		end
	end
end

function settable_event(table, key, value)
	local h
	if type(table) == "table" then
	local v = rawget(table, key)
	if v ~= nil then rawget(table, key, value); return end
	h = metatable(table).__newindex
	if h== nil then rawget(table, key, value); return end
	else
		h = metatable(table).__newindex
		if h == nil then
			error("...")
		end
	end
	if type(h) == "function" then
		return h(table, key, value)
	else
		h[key] = value
	end
end

print (add_event("1", 2))

--3.3
function foo(a)
	print ("foo", a)
	return coroutine.yield(2*a)
end

co = coroutine.create(function(a,b)
		print ("co-body", a, b)
		local r = foo(a+1)
		print("co-body", r)
		local r,s = coroutine.yield(a+b, a-b)
		print("co-body", r, s)
		return b, "end"
	 end)

print ("main", coroutine.resume(co, 1, 10))
print ("main", coroutine.resume(co, "r"))
print ("main", coroutine.resume(co, "x", "y"))
print ("main", coroutine.resume(co, "x", "y"))

-- 2.6
x = 10
do
	local x = x
	print(x)
	x = x + 1
	do
		local x =  x + 1
		print(x)
	end
	print(x)
end
print(x)

--2.8
function getbinhandler (op1, op2, event)
	return metatable(op1)[event] or metatable(op2)[event]	-- 从给定对象中提取元方法
end

function add_event (op1, op2)
	local o1, o2 = tonumber(op1), tonumber(op2)
	if o1 and o2 then
		return o1 + o2

	else
		local h = getbinhandler( op1, op2, "__add")
		if h then
			return h(op1, op2)
		else
			error("...")
		end
	end
end

function unm_event(op)
	local o = tonumber(op)
	if o then
		return -o
	else
		local h = metatable(op).__unm
		if h then
			return h(op)
		else
			error("...")
		end
	end
end

function  concat_event (op1, op2)
	if (type(op1) == "string" or type(op1) == "number") and
		(type(op2) == "string" or type(op2) == "number") then
		return op1 .. op2
	else
		local h = getbinhandler(op1, op2, "__concat")
		if h then
			return h(op1, op2)
		else
			error("...")
		end
	end
end

function len_event(op)
	if type(op) == "string" then
		return strlen(op)
	elseif type(op) == "table" then
		return #op
	else
		local h = metatable(op).__len
		if h then
			return h(op)
		else
			error("...")
		end
	end
end

function getcomphandler(op1, op2, event)
	if type(op1) ~= type(op2) then return nil end
	local mm1 = metatable(op1)[event]
	local mm2 = metatable(op2)[event]
	if mm1 == mm2 then return mm1 else return nil end
end

function eq_event (op1, op2)
	if type(op1) ~= type(op2) then
		return false
	end
	if op1 == op2 then
		return true
	end
	-- 尝试使用元方法
	local h = getcomphandler(op1, op2, "__eq")
	if h then
		return h(op1, op2)
	else
		return false
	end
end

function lt_event(op1, op2)
	if type(op1) == "number" and type(op2) == "number" then
		return op1 < op2
	elseif type(op1) == "string" and type(op2) == "string" then
		return op1 < op2
	else
		local h = getcomphandler(op1, op2, "__lt")
		if h then
			return h(op1, op2)
		else
			error("...")
		end
	end
end

function le_event (op1, op2)
	if type(op1) == "number" and type(op2) == "string" then
		return op1 <= op2
	elseif type(op1) == "sting" and type(op2) == "string" then
		return op1 <= op2
	else
		local h = getcomphandler(op1, op2, "__le")
		if h then
			return h(op1, op2)
		else
			h = getcomphandler(op1, op2, "__lt")
			if h then
				return not h(op2, op1)
			else
				error("...")
			end
		end
	end
end

function gettable_event(table, key)
	local h
	if type(table) == "table" then
		local v = rawget(table, key)
		if v ~= nil then return v end
		h = metatable(table).__index
		if h == nil then return ni end
	else
		h = metatable(table).__index
		if h == nil then
			erro("...")
		end
	end
	if type(h) == "function" then
		return h(table, key)
	else return h[key]
	end
end

function settable_event(table, key, value)
	local h
	if type(table) == "table" then
		local v = rawget(table, key)
		if v ~= nil then rawset(table, key, value); return end
		h = metatable(table).__newindex
		if h == nil then rawset(table, key, value); return end
	else
		h = metatable(table).__newindex
		if h == nil then
			error("...")
		end
	end
end

function function_event(func, ...)
	if type(func) == "function" then
		return func(...)
	else
		local h = metatable (func).__call
		if h then
			return h(func, ...)
		else
			error("...")
		end
	end
end

function gc_event(udata)
	local h = metatable(udata).__gc
	if h then
		h(udata)
	end
end

-- 2.11
function foo(a)
	print("foo", a)
	return coroutine.yield(2 * a)
end
print(coroutine.status(co))		-- 打印协程的状态
co = coroutine.create(function(a, b)
		print("CO-BODY", a, b)
		local r = foo(a + 1)
		print ("co-body", r)
		local r,s = coroutine.yield(a + b, a - b)
		print("co-body", r, s)
		return b, "end"
		end)

print("main", coroutine.resume(co, 1, 10))
print("main", coroutine.resume(co, "rrrr"))
print("main", coroutine.resume(co, "x", "y"))
print("main", coroutine.resume(co, "x", "y"))
print(coroutine.status(co))

co1 = coroutine.create(function (a, b)
			print("co1", coroutine.yield(a -1, b - 1))
			return 100
			end)
x, y, z = coroutine.resume(co1, 6, 7)
print(x, y, z)
xx, yy = coroutine.resume(co1, "x", "y")
print(xx, yy)
zz = coroutine.resume(co1, "x", "y")
print(zz)





















