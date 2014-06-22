local function getnext(list, node)
	if not node then
		return list
	else
		return node.next
	end
end
function traverse(list)
	return getnext, list, nil
end

list = nil
local ff = assert(io.open("qqqqq.txt", 'r'))
for line in ff:lines() do
	print(line)z
	list = {val = line, next = list}
end
for node in traverse(list) do
	print(node.val)
end
