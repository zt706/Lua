-- URL解码
function unescape(s)
	s = string.gsub(s, "+", " ")
	--s = string.gsub(s, "&", ";")
	s = string.gsub(s, "%%(%x%x)", function (h)
			return string.char(tonumber(h, 16))
		end)
	return s
end

print(unescape("name=al&query=a%2Bb+%3D+c&q=yes+or+no"))

cgi = {}
function decode (s)
	for name, value in string.gmatch(s, "([^&=]+)=([^&=]+)") do
		name = unescape(name)
		value = unescape(value)
		cgi[name] = value
	end
end

decode("name=al&query=a%2Bb+%3D+c&q=yes+or+no")
for k, v in pairs(cgi) do
	print(k, v)
end

-- URL编码
function escape(s)
	s = string.gsub(s, "[&=+%%%c]", function (c)		-- 将控制字符转化为16进制
			return string.format("%%%02X", string.byte(c))
		end)
	s = string.gsub(s, " ", "+")
	return s
end

function encode(t)
	local b = {}
	for k, v in pairs(t) do
		b[#b + 1] = (escape(k) .. "=" .. escape(v))
	end
	return table.concat(b, "&")
end

t = {name="al", query = "a + b = c", q = "yes or no"}
print(encode(t))
