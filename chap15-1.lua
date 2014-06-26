function require (name)
	if not package.loaded[name] then
		local loader = findloader(name)
		if loader == nil then
			error("unable to load module " .. name)
		end
		package.loaded[name] = true
		local res = loader(name)
		if res ~= nil then
			package.loaded[name] = res
		end
	end
	return package.loaded[name]
end

--
complex = {}
function complex.new (r, i) return {r = r, i = i} end
complex.i = complex.new(0, 1)

function complex.add(c1, c2)
	return complex.new(c1.r + c2.r, c1.i + c2.i)
end

function complex.asub(c1, c2)
	return complex.new(c1.r - c2.r, c1.i - c2.i)
end

function complex.mul(c1, c2)
	return complex.new(c1.r * c2.r - c1.i * c2.i,
						c1.r * c2.i + c1.i * c2.r)
end

function complex.inv (c)
	local n = c.r^2 + c.i^2
	return complex.new(c.r / n, -c.i / n)
end

return complex
