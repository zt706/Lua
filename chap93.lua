-- 以协同程序实现迭代器
function printTable(a)
	for i = 1, #a do
		io.write(a[i])
	end
	io.write('\n')
end

function printResult(a)
	for i = 1, #a do
		io.write(a[i], " ")
	end
	io.write('\n')
end

--[[function permagen (a, n)
	n = n or #a
	if n <= 1 then
		printResult(a)
	else
		for i = 1, n do
			a[n], a[i] = a[i], a[n]
			--printTable(a)
			permagen(a, n-1)
			a[n], a[i] = a[i], a[n]
			printTable(a)
		end
	end
end

permagen({1, 2})]]

function permagen(a, n)
	n = n or #a
	if n <= 1 then
		coroutine.yield(a)
	else
		for i = 1, n do
			a[n], a[i] = a[i], a[n]
			permagen(a, n-1)
			a[n], a[i] = a[i], a[n]
		end
	end
end
function permutations (a)
	local co = coroutine.create(function () permagen(a) end)
	return function ()		-- 迭代器
		local code, res = coroutine.resume(co)
		return res
	end
end
for p in permutations({'a', 'b', 'c'}) do
	printResult(p)
end
