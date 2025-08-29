-- Plugin: folke/snacks.nvim
-- Installed via store.nvim

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {
      enabled = true,
    },
    dashboard = {
      enabled = true,
      sections = {
        { section = 'header' },
        {
          pane = 2,
          section = 'terminal',
          cmd = 'echo $(pwd) , $(which python)',
          height = 5,
          padding = 0,
        },
        { section = 'keys', gap = 1, padding = 1 },
        { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        { pane = 1, icon = ' ', key = 's', desc = 'Store', action = ':Store', padding = 1 },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = 'git status --short --branch --renames',
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = 'startup' },
      },
    },
    explorer = {
      enabled = false,
    },
    indent = {
      enabled = true,
    },
    input = {
      enabled = true,
    },
    picker = {
      enabled = true,
    },
    notifier = {
      enabled = true,
    },
    quickfile = {
      enabled = true,
    },
    scope = {
      enabled = true,
    },
    scroll = {
      enabled = true,
    },
    statuscolumn = {
      enabled = true,
    },
    words = {
      enabled = true,
    },
  },
  keys = {
    {
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>g',
      function()
        Snacks.lazygit()
      end,
      desc = 'LazyGit',
    },
    {
      '<leader>d',
      function()
        Snacks.dashboard()
      end,
      desc = 'Snacks Dashboard',
    },
  },
}
