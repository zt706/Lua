Account = {balance = 0}

--[[function Account.withdraw(self, v)
	self.balance = self.balance - v
end]]

function Account.withdraw(v)
	Account.balance = Account.balance - v
end

function Account:deposit (v)
	self.balance = self.balance + v
end

function Account:new(o)
	o = o or {}
	setmetatable(o, self)
	print(getmetatable(o))
	return o
end

a = Account:new{balance = 0}
a = Account;
--print("Account balance is", Account.balance)
print("a::::", a)
Account = nil
print("a is ", a, "Account is ", Account)
--a.withdraw(100)
print("a balance is ", a.balance)
--print(getmetatable(a))
--a:deposit(100.00)

xxx = {1,2, 3}
yyy = xxx
yyy[1] = 100
for k,v in ipairs(xxx) do print(k, v) end
for k,v in ipairs(yyy) do print(k, v) end
