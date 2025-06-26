return {
  'zaldih/themery.nvim',
  lazy = false,
  config = function()
    require('themery').setup {
      -- add the config here
      themes = { 'gruvbox', 'catppuccin-mocha', 'catppuccin-macchiato', 'retrobox', 'tokyonight-night', 'tokyonight-storm', 'vim' }, -- Your list of installed colorschemes.
      livePreview = true, -- Apply theme while picking. Default to true.
    }
  end,
}
