---------------
--16.1
---------------
--[[Account = {balance = 0}

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
--]]


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
s = string.gsub("the\quote{task} is to \em{change} that", "\\(%a+){(.-)}", "<%1>%2</%1>")
print(s)

---------------
--20.6
---------------
function nocase (s)
	s = string.gsub(s, "%a", function(c)
		return "["..string.lower(c) .. string.upper(c) .."]"
		end)
	return s
end

print(nocase("Hi there!"))
