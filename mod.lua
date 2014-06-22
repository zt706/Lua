local function foo()
	local x = 1
	if x then
		y = 2
		x = x + 10
	end
	print(y)
end
foo()
print(x)
print(y)
