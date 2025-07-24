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

_G.replace_termcodes = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
