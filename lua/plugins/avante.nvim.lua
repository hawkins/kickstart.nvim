return {
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
    system_prompt = 'You are a helpful and concise coding assistant. Your answers should be brief, direct, and to the point. Avoid verbosity, filler, and unnecessary explanations. Respond only with the requested information or code.',
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
    { '<leader>aC', '<cmd>AvanteClear<cr>', desc = 'avante: clear' },
    { '<leader>ag', '<cmd>AvanteGenerateTest<cr>', desc = 'avante: generate test' },
    { '<leader>af', '<cmd>AvanteRefactor<cr>', desc = 'avante: refactor' },
    { '<leader>ap', '<cmd>AvanteSend<cr>', desc = 'avante: send' },
    { '<leader>ad', '<cmd>AvanteRemoveFile<cr>', desc = 'avante: remove file' },
    { '<leader>av', '<cmd>AvanteShowFiles<cr>', desc = 'avante: show files' },
    { '<leader>ax', '<cmd>AvanteClear<cr>', desc = 'avante: clear all files from selection' },
  },
}
