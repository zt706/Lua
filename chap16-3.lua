--

Account = {balance = 0}

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
	if v > self.balance then error "insufficient funds " end
end

local function search(k, plist)
	for i = 1, #plist do
		local v = plist[i][k]
		if v then return v end
	end
end

function createClass(...)
	local c = {}
	local parent = {...}
	setmetatable(c, {__index = function (t, k)
		return search(k, parent)
	end})
	c.__index = c
	function c:new(o)
		o = o or {}
		setmetatable(o, c)
		return o
	end

	return c
end

Named = {}
function Named:getname()
	return self.name
end

function Named:setname(n)
	self.name = n
end

NamedAccount = createClass(Account, Named)

account = NamedAccount:new{name = "Palu"}
print(account:getname())


local xxx = 111
yyy = 222
print(_G["xxx"], _G["yyy"])

a = {}
b = {__mode = "k"}
setmetatable(a, b)
key = {}
print(key)
a[key] = 1
key = {}
print(key)
a[key] = 2
collectgarbage()
for k, v in pairs(a) do print (k, v) end

