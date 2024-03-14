local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
	error("jirascope requires nvim-telescope/telescope.nvim")
end

local jira = require("jira")

return telescope.register_extension({
	setup = jira.setup,
	exports = {
		jira = require("jira").issues,
	},
})
