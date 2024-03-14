# Jirascope

Search Jira issues and create compliant git branch names.

## Installation

Requires [dgira](https://github.com/olidacombe/dgira) and [refalizer](https://github.com/olidacombe/refalizer):

```bash
cargo install dgira refalizer
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

## Setup

This is optional, you can skip this if you're happy to search all issues in Jira all the time.

```lua
telescope = require("telescope")

telescope.setup({
    ...
    extensions = {
        ...
        jira = {
            projects = { -- limit to a restricted set of projects within your org
                "ABCD",
                "EFGH"
            }
        }
    }
})
```

## Usage

```lua
vim.keymap.set("n", "<leader>fj", "<cmd>Telescope jira<cr>", "Find Jira")
vim.keymap.set("n", "<leader>fz", function() require("telescope").extensions.jira.jira({projects={"FRNT"}}) end, "Find Frontend Jira")
vim.keymap.set("n", "<leader>fz", function() require("telescope").extensions.jira.jira({projects={"BACK","INFR"}}) end, "Find Backend Jira")
```
