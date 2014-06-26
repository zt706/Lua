local 	BUFSIZE = 2^13

local f = io.input(arg[1])
local cc, lc, wc = 0, 0, 0
while true do
	local lines, rest = f:read(BUFSIZE, "*lines")
	if not lines then break end
	if rest then lines = lines .. rest .. "\n" end
	cc = cc + #lines
	-- 统计块中的单词数
	local _, t = string.gsub(lines, "%S+", "")		-- 看替换了多少次非空白
	wc = wc + t
	_, t = string.gsub(lines, "\n", "\n")
	lc = lc + t
end
print(lc, wc, cc)

local function dos2unix()
	local inp = assert(io.open(arg[1], "rb"))
	local out = assert(io.open(arg[2], "rb"))

	local data = inp:read("*all")
	data = string.gsub(data, "\r\n", "\n")
	out:write(data)

	assert(out:close())
end

local function findstrInBinaryfile()
	local f = assert(io.open(arg[1], "rb"))
	local data = f:read("*all")
	local validchars = "[%w%p%s]"
	local pattern = string.rep(validchars, 6) .. "+%z"
	for w in string.gmatch(data, pattern) do
		print (w)
	end
end

-- 打印二进制文件的内容
local function printBinaryfile()
	local f = assert(io.open(arg[1], "rb"))
	local block = 16
	while true do
		local bytes = f:read(block)
		if not bytes then break end
		for _, b in ipairs{string.byte(bytes, -1, 1)} do
			io.write(string.format("%02X ", b))
		end
		io.write(string.rep("  ", block - string.len(bytes)))
		io.write(" ", string.gsub(bytes, "%c", "."), "\n")
	end
end
