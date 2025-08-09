-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
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
  },
  {
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
  },
  {
    'yetone/avante.nvim',
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'gemini',
      web_search_engine = 'google',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    keys = {
      { '<leader>aC', '<cmd>AvanteClear<cr>', desc = 'Avante[C]lear' },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons', -- optional, but recommended
    },
    keys = {
      { '<leader>t', '<cmd>Neotree<cr>', desc = 'Open Neo[t]ree' },
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
          },
        },
        window = {
          mappings = {
            ['+'] = 'add_to_avante_request',
            ['-'] = 'remove_from_avante_request',
          },
        },
        -- ... any other settings ...
      }
    end,
  },
}
