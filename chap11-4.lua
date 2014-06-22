List = {}
function List.new()
	return {first = 0, last = -1}
end

function List.pushfirst(list, value)
	local first = list.first + 1
	list.first = first
	list[first] = value
end

a = List.new()
List.pushfirst(a, 100)
List.pushfirst(a, 200)
for k in pairs(a) do
	print(k)
end
