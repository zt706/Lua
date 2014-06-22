--/cygdrive/D/cocos2d-2.1beta3-x-2.1.0/cocos2d-2.1beta3-x-2.1.0/cocos2dx_lua_shop

---------------
--16.1
---------------
--[=[Account = {balance = 0}

function Account.withdraw(v)
	Account.balance = Account.balance - v
	end

--Account.withdraw(100.00)
--print(Account.balance)

--setmetatable(a, {__index = b})

function Account:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

a = Account:new{balance = 0}
--a:deposit(100.00)

--b = Account.new(Account, Account.withdraw(100.00))
--b = Account.new(Account)
b = Account:new()
print(b.balance)

function Account.withdraw(self, v)
	self.balance = self.balance - v
end

a1 = Account; --Account = nil
a1.withdraw(a1, 100)
print(a1.balance)

a2 = {balance = 0, withdraw = Account.withdraw]
a2.withdraw(a2, 260.00)
print(a2.balance)
]=]


---------------
--16.2
---------------
--[[Account = {balance = 0}

function Account:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Account:deposit(v)
	self.balance = self.balance + v
end

function Account:withdraw(v)
	if v > self.balance then error "insufficient funds" end
	self.balance = self.balance - v
end

SpecialAccount = Account:new()
s = SpecialAccount:new({limit = 1000.00})

s:deposit(100.00)
print (s.balance)

function SpecialAccount:withdraw(v)
	if v - self.balance >= self.getLimit(self) then
		error "insufficient funds"
	end
	self.balance = self.balance - v
end

function SpecialAccount:getLimit()
	return self.limit or 0
end

function s:getLimit()
	return self.balance * 0.1
end

s:withdraw(10.00)
print(s.balance)
--]]

---------------
--16.3
---------------
--[[local function search(k, plist)
	for i = 1, #plist do
		local v = plist[i][k]
		if v then return v end
	end
end

function createClass(...)
	local c = {}
	local parents = {...}

	setmetatable(c, {__index = function(t, k)
								return search(k, parents)
								end})

	c.__index = c
	function c:new(o)
		o = o or {}
		setmetatable(o, c)
		return o
	end

	return c		--return new class
end

Account = {balance = 0}
Named = {}

function Named:getname()
	return self.name
end

function Named:setname(n)
	self.name = n
end

NamedAccount = createClass(Account, Named)
account = NamedAccount:new({name = "Paul"})
print (account:getname())
--]]

---------------
--16.4
---------------
--[[function newAccount(initialBalance)
	local self = {
			balance = initialBalance,
			LIM = 1000.00,}

	local extra = function()
					if self.balance > self.LIM then
						return self.balance * 0.10
					else
						return 0
					end
				  end

	local getBalance = function()
						return self.balance + extra()
					   end

	local withdraw = function(v)
						self.balance = self.balance - v
					 end

	local deposit = function(v)
						self.balance = self.balance + v
					end

	return {
		withdraw = withdraw,
		deposit = deposit,
		getBalance = getBalance
	}
end

acc1 = newAccount(1100.00)
acc1.withdraw(40.00)
print (acc1.getBalance())


function newObject(value)
	return function (action, v)
				if action == "get" then return value
				elseif action == "set" then value = v
				else error("invalid action")
				end
			end
end

d = newObject(0)
print(d("get"))
d("set", 10)
print (d("get"))
--]]

---------------
--16.4
---------------
--[[local results = {}
setmetatable(results, {__mode = "kv"})
function mem_loadsting(s)

function mem_loadsting(s)
	local res = results[s]
	if res == nil then
		res = assert(loadstring(s))
		results[s] = res
	end
    return res
end--]]

--[[local results = {}
setmetatable(results, {__mode = "v"})
function createRGB(r, g, b)
	local key = r.."-"..g.."-"..b
	local color = results[key]
	if color == nil then
		color = {red = r, green = g, blue = b}
		results[key] = color
	end
	return color
end--]]


---------------
--20.4
---------------
s = 'the \quote{task} is to \em{change} that.'
s = string.gsub(s, "\\(%a+){(.-)}", "<%1>%2</%1>")
print(s)

---------------
--21.2
---------------
local f = assert(io.open(--[[arg[1]--]]"qqqqq.txt", "rb"))
local block = 16
while true do
	local bytes = f:read(block)
	if not bytes then break end
	for _, b in ipairs{string.byte(bytes, 1, -1)} do
		io.write(string.format("%02X ", b))
	end
	io.write(string.rep("   ", block - string.len(bytes)))
	io.write("  ", string.gsub(bytes, "%c", "."), "\n");
end

print(os.time{year=1970, month=1, day=1})

local x = os.clock()
local s = 0
for i = 1, 10000000 do s = s + i end
print(string.format("elapsed time: %.2f\n", os.clock() - x))

--打印当前栈的追溯
function traceback()
	for level = 1, math.huge do
		local info = debug.getinfo(level, "Sl")
		if not info then break end
		if info.what == "C" then
			print(level, "C function")
		else
			print(string.format("[%s]:%d", info.short_src, info.currentline))
		end
	end
end
print(traceback())

function foo(a,b)
	local x
	do local c = a - b end
	local a = 1
	while true do
		local name, value = debug.getlocal(1, a)
		if not name then break end
		print(name, value)
		a = a + 1
	end
end
print(foo(10, 20))

-- 3.6
-- 从标准输入读入每行，然后按相反顺序输出
--[=[list = nil
for line in io.lines() do
	list = {next = list, value = line}
end

local l = list
while l do
	print(l.value)
	l = l.next
end]=]

-- 从文件读入每行，然后按相反顺序输出
local ff = assert(io.open("qqqqq.txt", 'r'))
for line1 in ff:lines() do
	list1 =  {next1 = list1, value = line1}
end

local ll = list1
while ll do
	print(ll.value)
	ll = ll.next1
end

-- 返回所有参数的总和
local function add(...)
	local s = 0
	for i, v in ipairs({...}) do
		s = s + v
	end
	return s
end
print(add(3, 4, 10, 25, 12))

--[=[function f(a, b)
	print (a, b)
end
function g(a, b, ...) end
function r() return 1, 2, 3 end

f((r()))
print((r()))]=]

-- 9.2
--[=[function producer()
	while true do
		local x = io.read()
		send(x)
	end
end

function consumer()
	while true do
		local x = receive()
		io.write(x, "\n")
	end
end]=]

producer = coroutine.create(
	function()
		while true do
			local x = io.read()
			print("read data is", x)
			send(x)
		end
	end)
function receive()
	local status, value = coroutine.resume(producer, 3333)
	return status, value
end
function send(x)
	print("send data is", x)
	local cor = coroutine.yield(x)
	print("after return from yield", x)
	print("return data from yield is\n", cor)
end

while true do
	local status, r2 = coroutine.resume(producer, 2222)
	print("return from resume-222", status, r2)
	print("return from resume-333", receive())

end



























































































































