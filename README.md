# Jirascope

Search Jira issues and create compliant git branch names.

## Installation

Requires [dgira](https://github.com/olidacombe/dgira) and [refalizer](https://github.com/olidacombe/refalizer):

```bash
cargo install dgira refalizer
```

or for [homebrew](https://brew.sh/) users these are available in the [productivity-tools tap](https://github.com/olidacombe/homebrew-productivity-tools):

```bash
brew tap olidacombe/productivity-tools
brew install dgira refalizer
```

### Lazy.nvim

```lua
{
    "olidacombe/jirascope",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
}
```

Although not required, installing something like [dressing.nvim](https://github.com/stevearc/dressing.nvim) is highly desirable.

## Setup

This is optional, you can skip this if you're happy to search all issues in Jira all the time.

```lua
telescope = require("telescope")

telescope.setup({
    ...
    extensions = {
        ...
        jira = {
            limit = 1000, -- max results to fetch
            projects = { -- limit to a restricted set of projects within your org
                "ABCD",
                "EFGH"
            }
        }
    }
})

telescope.load_extension("jira")
```

## Usage

```lua
-- keymap for default options
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope jira<cr>", {desc = "Find Jira"})
-- some mappings for other options
vim.keymap.set("n", "<leader>fz", function() require("telescope").extensions.jira.jira({projects={"FRNT"}}) end, {delc = "Find Frontend Jira"})
vim.keymap.set("n", "<leader>fr", function() require("telescope").extensions.jira.jira({projects={"BACK","INFR"}}) end, {desc = "Find Backend Jira"})
```
