--NOTE:Instuctions
-- https://alpha2phi.medium.com/modern-neovim-init-lua-ab1220e3ecc1

--NOTE: User that have the escencial plugins like IA git and IDE
-- https://github.com/ldelossa/dotfiles/tree/master/config/nvim/lua/plugins

-- NOTE:Sites for installing plugins
-- https://vimawesome.com/
-- https://github.com/neovim/neovim/wiki/Related-projects
-- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
-- https://www.lazyvim.org/configuration/plugins
-- https://www.lunarvim.org/docs/plugins/extra-plugins
-- https://astronvim.com/Configuration/plugin_defaults
-- https://dev.to/craftzdog/my-neovim-setup-for-react-typescript-tailwind-css-etc-58fb
-- https://www.barbarianmeetscoding.com/notes/neovim-plugins/

return {
  -- {
  --   "abeldekat/lazyflex.nvim",
  --   import = "lazyflex.hook",
  --   opts = {
  --     opts = { enable_match = false, kw = { "matchup" } },
  --
  --     -- filter_modules = { enabled = false, kw = { "vim" } },
  --     -- filter_modules = { enabled = false },
  --     -- lazyvim = { presets = { "vim-matchup" } },
  --     -- kw = { "toky", "test", "plen" },
  --     -- filter_modules = { enabled = true, kw = { "py", "test" } },
  --     -- lazyvim = { presets = { "treesitter" } },
  --     -- kw = { "toky", "test", "plen" },
  --   },
  -- },

  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },

  --TODO: buscar una barra de navegación de símbolos
  -- {
  --   "Bekaboo/dropbar.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope-fzf-native.nvim",
  --     init = function() end,
  --   },
  -- },

  -- Replaced by coc-explorer
  -- https://yeripratama.com/blog/customizing-coc-explorer/ --Config Doc
  -- CocInstall coc-docker
  -- CocInstall coc-explorer
  -- CocInstall coc-marketplace
  -- CocInstall coc-webview
  -- CocInstall coc-tsserver
  --
  -- CocInstall coc-webview
  -- CocInstall coc-markdown-preview-enhanced

  { "neoclide/coc.nvim" },
  --preview code results
  {
    "metakirby5/codi.vim",
    init = function()
      vim.g["codi#interpreters"] = {
        cs = {
          bin = "dotnet-script",
          prompt = "^\\(>>>\\|\\.\\.\\.\\) ",
        },
        javascript = {
          bin = "node",
          prompt = "^\\(>\\|\\.\\.\\.\\+\\) ",
          virtual_text = 1,
        },
        python = {
          bin = "python3",
          prompt = "^\\(>>>\\|\\.\\.\\.\\) ",
        },
      }
    end,
  },

  -- Highlight hex colors
  {
    "chrisbra/colorizer",
    init = function()
      vim.g.colorizer_auto_filetype = "css,html,json"
      vim.g.colorizer_disable_bufleave = 1
    end,
  },

  --highlight regular expressions
  { "finbarrocallaghan/highlights.vim" },

  --csv color
  { "mechatroner/rainbow_csv" },

  {
    "simrat39/symbols-outline.nvim",
    -- TODO:Quitar todos los innecesarios que tengan init
    -- init = function()
    -- require("symbols-outline").setup()
    -- end,
    opts = {
      position = "right",
    },
  },

  --Align tabs
  { "godlygeek/tabular" },

  -- mini.map
  {
    "echasnovski/mini.map",
    branch = "stable",
    config = function()
      require("mini.map").setup()
      local map = require("mini.map")
      map.setup({
        integrations = {
          map.gen_integration.builtin_search(),
          -- map.gen_integration.gitsigns(),
          map.gen_integration.diagnostic({
            error = "DiagnosticFloatingError",
            warn = "DiagnosticFloatingWarn",
            info = "DiagnosticFloatingInfo",
            hint = "DiasnosticFloatingHint",
          }),
        },
        symbols = {
          encode = map.gen_encode_symbols.dot("4x2"),
        },
        window = {
          winblend = 100,
          -- side = "left", --a la izquierda da conflicto con gutter
        },
      })
    end,
  },

  -- {
  --TODO: Seleccionar una ventana
  -- /home/richard/.config/coc/extensions/node_modules/coc-explorer/autoload/coc_explorer/select_wins.vim
  --   "s1n7ax/nvim-window-picker",
  --   config = function()
  --     require("window-picker").setup({
  --       vim.keymap.set("n", "<C-w>g", function()
  --         -- vim.keymap.set("n", "<leader>t", function()
  --         -- local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
  --         local picked_window_id = require("window-picker").pick_window()
  --         -- local picked_window_id = vim.api.nvim_get_current_win()
  --         print("pic:" .. require("window-picker").pick_window())
  --         -- lua print(require('window-picker').pick.window())
  --         vim.api.nvim_set_current_win(picked_window_id)
  --       end, { desc = "Pick a window" }),
  --     })
  --   end,
  -- },

  -- --Diff
  --  { "rickhowe/spotdiff.vim" },
  --  { "rickhowe/diffchar.vim" },

  -- {
  --   "mrjones2014/smart-splits.nvim",
  --   config = function()
  --     require("smart-splits").setup({
  --       resize_mode = {
  --         silent = true,
  --         hooks = {
  --           on_enter = function()
  --             vim.notify("Entering resize mode")
  --           end,
  --           on_leave = function()
  --             vim.notify("Exiting resize mode, bye")
  --           end,
  --         },
  --       },
  --     })
  --   end,
  -- },

  --TODO:INSTALAR AI
  -- Plug 'madox2/vim-ai', { 'do': './install.sh' }

  --TODO: verificar si se puede highlight buffer
  -- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
  -- { "blueyed/vim-diminactive" },
  -- { "TaDaa/vimade" },
  -- https://www.reddit.com/r/vim/comments/irboc7/making_the_active_buffer_more_obvious/
  -- 	augroup activesyntax
  --     autocmd!
  --     autocmd WinEnter * ownsyntax on
  --     autocmd WinLeave * ownsyntax off
  --	augroup END

  -- --HTML
  -- { "alvan/vim-closetag" },

  -- {
  --   "monkoose/matchparen.nvim",
  --   init = function()
  --     require("matchparen").setup()
  --   end,
  -- },

  -- -- BUG: Conflicto con este plugin   -- { "nvim-treesitter/nvim-treesitter", enabled = false },
  -- {
  --   --Whatch Match Object
  --   "andymass/vim-matchup",
  --   config = function()
  --     vim.g.matchup_matchparen_offscreen = { method = "popup" }
  --   end,
  --   -- opts = {
  --   --   filter_modules = { enabled = false, ft = { "js", "ts" } },
  --   --   -- filter_modules = { enabled = true, kw = { "py", "test" } },
  --   -- },
  -- },

  -- {
  --   --Whatch Match Object
  --   "andymass/vim-matchup",
  --   enabled = false,
  --   ft = { "javascript", "typescript", "lua" },
  -- },
  --

  -- C# for razor files
  { "jlcrochet/vim-razor" },

  -- -- Preview images

  -- { "nvim-lua/popup.nvim" },
  -- Plug 'nvim-lua/plenary.nvim'
  { "nvim-telescope/telescope.nvim" },
  -- { "nvim-telescope/telescope-media-files.nvim" },
  {
    "nvim-telescope/telescope-media-files.nvim",
    init = function()
      -- require("telescope").load_extension("media_files")

      require("telescope").setup({
        extensions = {
          media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg" },
            -- find command (defaults to `fd`)
            find_cmd = "rg",
          },
        },
      })
    end,
  },

  -- {
  --   "edluffy/hologram.nvim",
  --   enabled = false,
  --   -- require("hologram").setup({
  --   --   auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
  --   -- }),
  -- },

  --TODO:Qué hace scratch de lazyVim?

  -- { "jparise/vim-graphql" },

  -- Toggle maximize one buffer (default key F3)
  -- BUG: ya no funciona la recuperacion del tamanio
  { "szw/vim-maximizer" },

  -- Multiple cursors: almost refactor select with <c-n> and substitute cuando se usa por primera vez
  -- BUG:conflicto con resize cuando se usa por primera vez
  { "mg979/vim-visual-multi" },
  -- { "terryma/vim-multiple-cursors" },
  -- debug cuando se usa por primera vez
  --TODO:REMAPEAR COMO DEBE SER cuando se usa por primera vez
  -- { "puremourning/vimspector" }, cuando se usa por primera vez
  -- NOTE:if fails must install `pip install pynvim`

  -- {
  --   "anuvyklack/windows.nvim",
  --   requires = {
  --     "anuvyklack/middleclass",
  --     "anuvyklack/animation.nvim",
  --   },
  --   config = function()
  --     vim.o.winwidth = 10
  --     vim.o.winminwidth = 10
  --     vim.o.equalalways = false
  --     require("windows").setup()
  --   end,
  -- },

  --TEST
  --  {
  --     "telescope.nvim",
  --     dependencies = {
  --       "nvim-telescope/telescope-fzf-native.nvim",
  --       build = "make",
  --       config = function()
  --         require("telescope").load_extension("fzf")
  --       end,
  --     },
  --   },

  -- https://github.com/flutterfocus/development_nvim/blob/main/plugins/init.lua
  -- " https://github.com/CRAG666/code_runner.nvim
  -- { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }
  --TODO:Hacerlo funcionar
  { "CRAG666/betterTerm.nvim" },
  --TODO: mejorar para que sea para un terminal abierto
  -- keyset("n", "<leader>cc", function()
  --   require("betterTerm").send(require("code_runner.commands").get_filetype_command(), 1, false)
  -- end, { desc = "Run Code" })

  --NOTE:Hacerlo de manera manual: https://www.youtube.com/watch?v=9gUatBHuXE0
  {
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("code_runner").setup({
        focus = false,
        filetype = {
          -- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
          python = "python3 -u $fileName",
          javascript = "node",
          cs = "dotnet-script",
          -- typescript = "deno run",
          -- rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
          dart = "dart $dir/$fileName",
          excluded_buftypes = { "message" },
        },
      })
    end,
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        click = true,
        icons = require("lazyvim.config").icons.kinds,
        lazy_update_context = true,
      }
    end,
  },

  --Fix ERROR: E5108: Error executing lua ...im/0.9.2/share/nvim/runtime/lua/vim/treesitter/query.lua:259: query: invalid structure at position 1023 for language tsx
  -- { "nvim-ts-autotag", enabled = false },
  -- { "nvim-treesitter/nvim-treesitter", enabled = true },
  -- { "nvim-treesitter/nvim-treesitter-textobjects", enabled = true },
  --BUG:Conflicto con Codi
  -- {
  --   "mrjones2014/nvim-ts-rainbow",
  --   require("nvim-treesitter.configs").setup({
  --     rainbow = {
  --       enable = true,
  --       -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  --       extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --       max_file_lines = nil, -- Do not enable for files with more than n lines, int
  --     },
  --   }),
  -- },

  --TODO:Reemplazar por el vimspector
  {
    "rcarriga/nvim-dap",
    vim.keymap.set("v", "<leader>dw", 'y<Esc>:echo @"<CR>', { desc = "Watch Selection" }),
  },
  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
  --     vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "", linehl = "", numhl = "" })
  --   end,
  -- },
  -- {
  --   "luukvbaal/statuscol.nvim",
  --   config = function()
  --     require("statuscol").setup({
  --       --- The click actions have the following signature:
  --       ---@param args (table): {
  --       ---   minwid = minwid,            -- 1st argument to 'statuscolumn' %@ callback
  --       ---   clicks = clicks,            -- 2nd argument to 'statuscolumn' %@ callback
  --       ---   button = button,            -- 3rd argument to 'statuscolumn' %@ callback
  --       ---   mods = mods,                -- 4th argument to 'statuscolumn' %@ callback
  --       ---   mousepos = f.getmousepos()  -- getmousepos() table, containing clicked line number/window id etc.
  --       --- }
  --       clickhandlers = {
  --         Lnum = function(args)
  --           -- if args.button == "l" and args.mods:find("c") then
  --           -- local a = args.mods:find("a")
  --           -- if args.button == "l" and args.mods:find("a") then
  --           --   require("dap").toggle_breakpoint(true)
  --           if args.button == "l" and args.mods:find("c") then
  --             -- a = a .. "222"
  --             require("gitsigns").preview_hunk()
  --             -- elseif args.button == "l" then
  --             --   -- a = a .. "111"
  --             --   require("dap").toggle_breakpoint()
  --             --   -- end
  --           end
  --           -- print(a)
  --         end,
  --       },
  --     })
  --   end,
  -- },

  -- --NOTE:Execute ./dl_binaries.sh from dir tabnine
  -- -- Use Artificial intelligence
  -- {
  --   "codota/tabnine-nvim",
  --   config = function()
  --     require("tabnine").setup({
  --       disable_auto_comment = true,
  --       accept_keymap = "<Tab>",
  --       dismiss_keymap = "<C-]>",
  --       debounce_ms = 800,
  --       suggestion_color = { gui = "#808080", cterm = 244 },
  --       exclude_filetypes = { "TelescopePrompt" },
  --     })
  --   end,
  -- },

  { "hdiniz/vim-gradle" },
  -- { "tfnico/vim-gradle" }, --Use pathogen obsolete

  --SQL
  -- { 'kristijanhusak/vim-packager' },
  -- { "tpope/vim-dadbod" },

  { "tpope/vim-dadbod" },
  -- -- {
  -- --   "kristijanhusak/vim-dadbod",
  -- --   requires = {
  {
    "kristijanhusak/vim-dadbod-ui",
    init = function()
      vim.g.DirDiffExcludes = ".git,node_modules"
      --ignore spaces
      vim.g.DirDiffAddArgs = "-w"
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.dbs = {
        bdMysql = "mysql://root:admin@localhost:3306/mysql?protocol=tcp",
        mongo = "mongodb://nico:password@localhost:27017/miapp?authSource=admrin",
        bdPostgress = "postgresql://richard:@localhost/mydb",
        -- h2 = "jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE",
        -- h2 = "jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE;MODE=MySQL",
      }

      vim.g.db_ui_table_helpers = {
        sqlserver = {
          Count = "select count(*) from {table}",
        },
        postgresql = {
          List = 'select * from "{table}" order by id asc',
        },
      }
    end,
  },

  --
  -- { "mfussenegger/nvim-jdtls" },

  --NOTE:NI instalarlo porque no muestra
  -- {
  --   "t9md/vim-choosewin",
  --   init = function()
  --     -- require("vim-choosewin").setup({
  --     -- vim.keymap.set("n", "<C-w>g", "<Plug>(choosewin)", { desc = "Pick a window" }),
  --     -- })
  --     -- nmap  -  <Plug>(choosewin)
  --   end,
  -- },
  -- {
  --   "gbrlsnchs/winpick.nvim",
  --   config = function()
  --     require("winpick").setup({
  --       border = "double",
  --       filter = function(winid, bufnr, default_filter)
  --         if vim.api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
  --           return false
  --         end
  --         return default_filter(winid, bufnr)
  --       end,
  --       prompt = "Pick a window: ",
  --       format_label = require("winpick").defaults.format_label, -- formatted as "<label>: <buffer name>"
  --       chars = nil,
  --       vim.keymap.set("n", "<C-w>g", function()
  --         local winid = require("winpick").select()
  --
  --         if winid then
  --           vim.api.nvim_set_current_win(winid)
  --         end
  --       end),
  --     })
  --   end,
  -- },

  -- {
  --   "luukvbaal/statuscol.nvim",
  --   config = function()
  --     require("statuscol").setup({
  --       setopt = true,
  --       reeval = true,
  --       lnumfunc = function()
  --         return ((vim.v.lnum % 2 > 0) and "%#DiffDelete#%=" or "%#DiffAdd#%=") .. vim.v.lnum
  --       end,
  --     })
  --   end,
  -- },

  -- { "akinsho/toggleterm.nvim" },
  --NOTE: config shell init

  { "will133/vim-dirdiff" },

  {
    "tyru/open-browser.vim",
    keys = {
      { "gl", mode = { "n", "v" }, "<Plug>(openbrowser-smart-search)", desc = "Go to Link" },
      { "gR", mode = { "n", "v" }, ":call GoToRepositoryPlugin()<CR>", desc = "Go to Git repository" },
      -- { "gR", mode = { "n", "v" }, ":call GoToRepositoryPlugin()<CR><c-o><c-o>", desc = "Go to Git repository" },
    },
  },

  --TEST
  -- ""PYTHON
  -- "Plug 'davidhalter/jedi-vim', { 'for': 'python' }
  -- "Plug 'vim-scripts/AutoComplPop', { 'for': 'python' }
  -- "Plug 'psf/black'
  --
  -- "Templates SQL
  -- "Plug 'vim-scripts/SQLUtilities'
  -- "
  -- "CAPSLOCK
  -- "Plug 'suxpert/vimcaps'
  -- "Plug 'tpope/vim-capslock'
  --
  -- "ACTIVATE PLUGINS GROUP
  -- "Plug 'MarcWeber/vim-addon-manager'
  --
  -- "GDRIVE
  -- "Plug 'ckana/vim-metar'
  -- "Plug 'mattn/webapi-vim'
  -- "Plug 'mattn/vim-metarw-gdrive'
  --
  -- "ENCRYPT
  -- "Plug 'vim-scripts/gnupg'
  -- "Plug 'jamessan/vim-gnupg'
}
