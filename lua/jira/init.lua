local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local json = require("jira.json")
local git = require("jira.git")

local issue_summary = function(issue)
	return issue["key"] .. ": " .. issue["fields"]["summary"]
end

local config = {}

local M = {}

M.issues = function(opts)
	opts = opts or {}

	local projects = opts.projects or config.projects

	opts.entry_maker = opts.entry_maker
		or function(entry)
			local issue = json.decode(entry)
			local display = issue_summary(issue)
			return {
				value = issue,
				display = display,
				ordinal = display,
			}
		end
	local args = {}
	if projects then
		table.insert(args, "-p")
		table.insert(args, table.concat(projects, ","))
	end
	P(args)
	pickers
		.new(opts, {
			prompt_title = "issues",
			finder = finders.new_oneshot_job({
				"dgira",
				table.unpack(args),
			}, opts),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local issue = action_state.get_selected_entry()
					vim.schedule(function()
						git.git_checkout_new_branch(issue.display)
					end)
				end)
				return true
			end,
		})
		:find()
end

M.setup = function(ext_config, global_config)
	if ext_config.projects then
		config.projects = ext_config.projects
	end
end

return M
