return {
  'alex-popov-tech/store.nvim',
  dependencies = {
    'OXY2DEV/markview.nvim', -- optional, for pretty readme preview / help window
  },
  cmd = 'Store',
  keys = {
    { '<leader>S', '<cmd>Store<cr>', desc = 'Open Plugin Store' },
  },
  opts = {
    -- optional configuration here
  },
}, {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = { search = { enabled = true } },
  },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}
