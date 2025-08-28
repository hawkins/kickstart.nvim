return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons', -- optional, but recommended
  },
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  lazy = false, -- neo-tree will lazily load itself
  config = function()
    require('neo-tree').setup {
      filesystem = {
        commands = {
          add_to_avante_request = function(state)
            local node = state.tree:get_node()
            if node and node.type == 'file' then
              local file_path = node:get_id()
              require('avante.api').add_selected_file(file_path)
              -- Optional: print a confirmation message
              vim.notify('Added ' .. vim.fn.fnamemodify(file_path, ':t') .. ' to Avante request', vim.log.levels.INFO)
            else
              vim.notify('Not a file', vim.log.levels.WARN)
            end
          end,
          remove_from_avante_request = function(state)
            local node = state.tree:get_node()
            if node and node.type == 'file' then
              local file_path = node:get_id()
              require('avante.api').remove_selected_file(file_path)
              -- Optional: print a confirmation message
              vim.notify('Removed ' .. vim.fn.fnamemodify(file_path, ':t') .. ' from Avante request', vim.log.levels.INFO)
            else
              vim.notify('Not a file', vim.log.levels.WARN)
            end
          end,
          clear_avante_request = function(state)
            sidebar = require('avante').get()
            if not sidebar:is_open() then
              sidebar:open {}
            end
            sidebar.file_selector:reset()
            require('avante.api'):focus()
            vim.notify('Cleared all files from Avante request', vim.log.levels.INFO)
          end,
        },
      },
      window = {
        mappings = {
          ['<leader>a+'] = 'add_to_avante_request',
          ['<leader>a-'] = 'remove_from_avante_request',
          ['<leader>ax'] = 'clear_avante_request',
          ['\\'] = 'close_window',
        },
      },
      -- ... any other settings ...
    }
  end,
}
