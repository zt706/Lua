--[[function receive (prod)
	local status, value = coroutine.resume(prod)
	return vlaue
end

function send(x)
	coroutine.yield(x)
end
function producer()
	return coroutine.create(function ()
		while true do
			local x = io.read()
			send(x)
		end
	end)
end
function filter(prod)
	return coroutine.create(function ()
		for line = 1, math.huge do
			local x = receive(prod)
			x = string.format("%5d %s", line, x)
			send(x)
		end
	end)
end
function consumer (prod)
	while true do
		local x = receive(prod)
		print(x)
		io.write(x, "\n")
	end
end

p = producer()
f = filter(p)
consumer(f)]]


function receive(prod)
	print("receive is called")
	local status,value = coroutine.resume(prod)
	return value
end

function send(x,prod)					-->这里是send(x, prod) 并且返回yield
	print("send is called")
	return coroutine.yield(x)
end

function producer()
	print( "begin producer..." )
	return coroutine.create(function ()
		print("producer is called")
		while true do
		print("producer run again")
			local x = io.read()
			send(x)
		end
	end)
end

function filter(prod)
	print("begin filter...")
	return coroutine.create(function ()
		for line = 1,1000 do
			print("enter fliter "..line)
			local x = receive(prod)
			print("receive in filter finished")
			x= string.format("%5d %s",line,x)
			send(x,prod)
		end
	end)
end

function consumer(prod)
	print("consumer is called")
	while true do
		print("consumer run again")
		local x = receive(prod)
		print("retrun customer")
		io.write(x,"\n")
	end
end

p = producer()
f=filter(p)
consumer(f)

--[[function printResult(a)
	for i = 1,  #a do
		io.write(a[i], " ")
	end
	io.write("\n")
end
function permgen(a, n)
	n = n or #a
	if n <= 1 then
		printResult(a)
	else
		for i = 1, n do
			a[n], a[i] = a[i], a[n]
			permgen(a, n - 1)
			a[n], a[i] = a[i], a[n]
		end
	end
end
permgen({1, 2, 3, 4})

-- 6.1
names = {}
-- 6.2
do
	local oldOpen = io.open
	local access_OK = function (filename, mode)
	--<检查访问权限>
	end
	io.open = function (filename, mode)
		if access_OK(filename, mode) then
			return oldOpen(filename, mode)
		else
			return nil, "access denied"
		end
	end
end

Lib = {}
Lib.foo = function (x, y) return x + y end
Lib.goo = function (x, y) return x - y end

Lib = {
foo = function (x, y) return x + y end,
goo = function (x, y) return x - y end
}]]

