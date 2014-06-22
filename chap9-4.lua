require "socket"
host = "www.w3.org"
--file = "/TR/REC-html32.html"

function receive(connection)
	connection:settimeout(0)
	local s, status, partial = connection:receive(2^10)
	print(status)
	if status == "timeout" then
		coroutine.yield(connection)
	end
	return s or partial, status
end

function download(host, file)
	local c = assert(socket.connect(host, 80))
	local count = 0
	c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
	--print("downloading"..file)
	--print("connecting is ", c)
	while true do
		local s, status = receive(c)
		io.write(s)					-- 将读取到的内容输出到控制台
		count = count + #s
		if status == "closed" then break end
	end
	c:close()
	print(file, count)
end

threads = {}

function get (host, file)
	print(host, file)
	local co = coroutine.create(function ()
		download(host, file)
	end)
	table.insert(threads, co)
end

function dispatch()
	local i = 4					-- 从最后一个url开始
	while true do
		if threads[i] == nil then
			if threads[4] == nil then break end
			i = 4
		end
		local status, res = coroutine.resume(threads[i])
		print("return from yield's data is ", res)
		if not res then
			table.remove(threads, i)
		else
			i = i - 1
		end
	end
	print(threads[i])
end

get(host, "/TR/html401/html40.txt")
get(host, "/TR/2002/REC-xhtml1-20020801/xhtml1.pdf")
get(host, "/TR/REC-html32.html")
get(host, "/TR/2000/REC-DOM-Level-2-Core-20001113/DOM2-Core.txt")

dispatch()





































