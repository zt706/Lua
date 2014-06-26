-- tab扩展
print(string.match("hello", "()ll()"))

function expandTabs(s, tab)
	tab = tab or 8
	local corr = 0
	s = string.gsub(s, "()\t", function (p)
		local sp  = tab - (p - 1 + corr) % tab
		corr = cor - 1 + sp
		return string.rep(" ", sp)
	end)
	return s
end

function unexpandTabs (s, tab)
	tab = tab or 8
	s = expandTabs(s)
	local pat = string.rep (".", tap)
	s = string.gsub(s, pat, "%0\1")
	s = string.gsub(s, " +\1", "\t")
	s = string.gsub(s, "\1", "")
	return s
end

s1 = "%$$hello"
s2 = "$$===%"
s3 = "fkjeifjskfjeijlslesl%$$hello00000000hello999999"
s1 = string.gsub(s1, "(%W)", "%%%1")
print(s1)
s2 = string.gsub(s2, "%%", "%%%%")
print(s2)
print(string.gsub(s3, s1, s2))


s = [["This is \"great\"!".]]
function code(s)
	return (string.gsub(s, "\\(.)", function (x)
		return string.format("\\%03d", string.byte(x))

	end))
end

function decode(xxxx)
	return (string.gsub( xxxx, "\\(%d%d%d)", function (d)
		return "\\" .. string.char(d)
	end))
end

s = code(s) print(s)
s = string.gsub(s, '".-"', string.upper)
print(s)
s = decode(s)
print(s)

