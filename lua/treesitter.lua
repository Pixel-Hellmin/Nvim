require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = false,
  --ignore_install = { "javascript" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  matchup = { enable = true },
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
    smart_rename = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
      keymaps = {
        smart_rename = "<Leader>r",
      },
    },
    navigation = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
      keymaps = {
        goto_definition = "gd",
        list_definitions = "gL",
        list_definitions_toc = "gT",
        goto_next_usage = "gnd",
        goto_previous_usage = "gpd",
      },
    },
  },
}

require'treesitter-context'.setup{
  enable = false,
  max_lines = 8, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 25,
}
