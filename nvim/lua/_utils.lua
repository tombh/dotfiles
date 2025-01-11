_G.startswith = function(self, str)
	return self:find("^" .. str) ~= nil
end

_G.removeByKey = function(table, value)
	for i, v in pairs(table) do
		if (v == value) then
			table[i] = nil
		end
	end
end
