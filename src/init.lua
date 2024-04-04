--!nocheck
--!optimize 2
--!native

local find = string.find

return function(value)
	if typeof(value) ~= "string" then
		return false
	end

	local i, len = 1, #value

	while i <= len do
		if i == find(value, "[%z\1-\127]", i) then
			i += 1
		elseif i == find(value, "[\194-\223][\128-\191]", i) then
			i += 2
		elseif
			i == find(value, "\224[\160-\191][\128-\191]", i)
			or i == find(value, "[\225-\236][\128-\191][\128-\191]", i)
			or i == find(value, "\237[\128-\159][\128-\191]", i)
			or i == find(value, "[\238-\239][\128-\191][\128-\191]", i)
		then
			i += 3
		elseif
			i == find(value, "\240[\144-\191][\128-\191][\128-\191]", i)
			or i == find(value, "[\241-\243][\128-\191][\128-\191][\128-\191]", i)
			or i == find(value, "\244[\128-\143][\128-\191][\128-\191]", i)
		then
			i += 4
		else
			return false, i
		end
	end

	return true
end
