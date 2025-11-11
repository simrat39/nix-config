return {
  "saghen/blink.cmp",
  version = "v1.*",
  config = function()
    require('blink.cmp').setup({
      keymap = { preset = 'super-tab' },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    })
  end,
}
