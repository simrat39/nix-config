-- return {
--   "stevearc/oil.nvim",
--   config = function()
--     require("oil").setup()
--   end,
-- }
return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable",
  opts = {
    -- Replace netrw as default explorer
    default_explorer = true,
  }
}
