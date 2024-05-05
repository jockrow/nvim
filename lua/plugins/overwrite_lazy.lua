local Util = require("lazyvim.util")

return {
  --File Tabs (Top)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<M-1>", ":BufferLineGoToBuffer 1<cr>", silent = true },
      { "<M-3>", ":BufferLineGoToBuffer 3<cr>", silent = true },
      { "<M-2>", ":BufferLineGoToBuffer 2<cr>", silent = true },
      { "<M-4>", ":BufferLineGoToBuffer 4<cr>", silent = true },
      { "<M-5>", ":BufferLineGoToBuffer 5<cr>", silent = true },
      { "<M-6>", ":BufferLineGoToBuffer 6<cr>", silent = true },
      { "<M-7>", ":BufferLineGoToBuffer 7<cr>", silent = true },
      { "<M-8>", ":BufferLineGoToBuffer 8<cr>", silent = true },
      { "<M-9>", ":BufferLineGoToBuffer 9<cr>", silent = true },
    },
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        middle_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        numbers = function(opts)
          return string.format("%s·%s", opts.id, opts.raise(opts.ordinal))
        end,
        custom_areas = {
          right = function()
            local result = {}
            local seve = vim.diagnostic.severity
            local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
            local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
            local info = #vim.diagnostic.get(0, { severity = seve.INFO })
            local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

            if error ~= 0 then
              table.insert(result, { text = "  " .. error, fg = "#EC5241" })
            end

            if warning ~= 0 then
              table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
            end

            if hint ~= 0 then
              table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
            end

            if info ~= 0 then
              table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
            end
            return result
          end,
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  { "echasnovski/mini.pairs", enabled = false },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
				--TODO:Poner icono en git
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  --Jump into text
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
	   -- stylua: ignore
	   keys = {
	     { "s", mode = { "n", "x", "o" }, nil},
	     { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	   },
  },
  { "ggandor/leap.nvim", enabled = false },
  { "ggandor/flit.nvim", enabled = false },

  -- TODO:ver si se puede resolver el error de treesitter de arriba (2)
  -- ponia mas bonito los colores del markdown de codigo
  -- comentaba bien el .tsx
  -- Parece que no muestra errores que no deben haber sido identificados
  -- { "nvim-treesitter/nvim-treesitter", enabled = false },
  -- { "nvim-treesitter/nvim-treesitter-context", enabled = false },
  --
  -- { "nvim-treesitter/nvim-treesitter" },
  -- { "nvim-treesitter/nvim-treesitter-textobjects" },

  --snippets
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  -- https://www.lazyvim.org/configuration/examples
  {
    "hrsh7th/nvim-cmp",
    -- dependencies = {
    --   "hrsh7th/cmp-emoji",
    -- },
    -- ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").load({ paths = "./snippets" })

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  -- --TODO:remapping with mini.surround
  -- {
  --   "tpope/vim-surround",
  -- },
  -- "echasnovski/mini.surround",
  --   keys = {
  --     -- { '""', mode = { "v" }, 'gsa"' },
  --     { '"', mode = { "v" }, '<Plug>VSurround"' },
  --     { "'", mode = { "v" }, "<Plug>VSurround'" },
  --     { "(", mode = { "v" }, "<Plug>VSurround)," },
  --     -- { "((", mode = { "v" }, "gsa)" },
  --     { "[", mode = { "v" }, "<Plug>VSurround]" },
  --     { "{", mode = { "v" }, "<Plug>VSurround}" },
  --     { "<>", mode = { "v" }, "<Plug>VSurround>" },
  --     { "f", mode = { "v" }, "<Plug>VSurroundf" },
  --     { "¡", mode = { "v" }, "<Plug>VSurround!r¡" },
  --     { "¿", mode = { "v" }, "<Plug>VSurround?r¿" },
  --     { "<space>", mode = { "v" }, "<Plug>VSurround<space>h" },
  --     { "+", mode = { "v" }, "<Plug>VSurround +" },
  --   },
  -- },

  {
    "echasnovski/mini.surround",
    -- keys = {
    --   { '"', mode = { "v" }, ":lua require('mini.surround').surround_visual('\\\"', '\\\"')<CR>" },
    --   { "'", mode = { "v" }, ":lua require('mini.surround').surround_visual('\\'\\'', '\\'\\'')<CR>" },
    --   { "(", mode = { "v" }, ":lua require('mini.surround').surround_visual('\\(', '\\)')<CR>" },
    --   { "[", mode = { "v" }, ":lua require('mini.surround').surround_visual('\\[', '\\]')<CR>" },
    --   { "{", mode = { "v" }, ":lua require('mini.surround').surround_visual('\\{', '\\}')<CR>" },
    --   { "<>", mode = { "v" }, ":lua require('mini.surround').surround_visual('\\<', '\\>')<CR>" },
    --   { "f", mode = { "v" }, ":lua require('mini.surround').surround_visual('\\f', '\\f')<CR>" },
    --   { "¡", mode = { "v" }, ":lua require('mini.surround').surround_visual('\\¡', '\\¡')<CR>" },
    --   { "¿", mode = { "v" }, ":lua require('mini.surround').surround_visual('\\¿', '\\¿')<CR>" },
    --   { "<space>", mode = { "v" }, ":lua require('mini.surround').surround_visual('\\ ', '\\ ')<CR>" },
    --   { "+", mode = { "v" }, ":lua require('mini.surround').surround_visual('\\+', '\\+')<CR>" },
    -- },

    -- keys = function(_, keys)
    --   -- Populate the keys based on the user's options
    --   local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
    --   local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    --   local mappings = {
    --     -- { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
    --     { opts.mappings.add, desc = "Add surrounding", mode = { "v" } },
    --     { opts.mappings.delete, desc = "Delete surrounding" },
    --     { opts.mappings.find, desc = "Find right surrounding" },
    --     { opts.mappings.find_left, desc = "Find left surrounding" },
    --     { opts.mappings.highlight, desc = "Highlight surrounding" },
    --     { opts.mappings.replace, desc = "Replace surrounding" },
    --     { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
    --   }
    --   mappings = vim.tbl_filter(function(m)
    --     return m[1] and #m[1] > 0
    --   end, mappings)
    --   return vim.list_extend(mappings, keys)
    -- end,

    opts = {
      mappings = {
        add = "gs",
      },
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gr"] = { name = "References" },
        ["gs"] = { name = "+surroundsito" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>D"] = { name = "+directory" },
        ["yd"] = { name = "+directory" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        -- ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>sn"] = { name = "+noice" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>W"] = { name = "+Workspace" },
        ["<leader>Wb"] = { name = "+Bookmarks" },
        ["<leader>Wg"] = { name = "+Git" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      })
    end,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },

      { "<s-Up>", mode = { "n" }, "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<s-Up>", mode = { "i" }, "<Esc><cmd>Telescope command_history<cr>", desc = "Command History" },
      -- TODO: cómo se puede quitar
      -- { "<leader>:", nil, desc = "" },

      { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
      { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
      {
        "<leader>ss",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<a-i>"] = function()
              Util.telescope("find_files", { no_ignore = true })()
            end,
            ["<a-h>"] = function()
              Util.telescope("find_files", { hidden = true })()
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(plugin)
      if plugin.override then
        require("lazyvim.util").deprecate("lualine.override", "lualine.opts")
      end

      local icons = require("lazyvim.config").icons

      local function fg(name)
        return function()
          ---@type {foreground?:number}?
          local hl = vim.api.nvim_get_hl_by_name(name, true)
          return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
        end
      end

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                local icon = {}
                icon["NORMAL"] = "󱚥"
                icon["INSERT"] = "󰏪"
                icon["V-BLOCK"] = "󰒉"
                icon["V-LINE"] = "󰘤"
                icon["VISUAL"] = "󱜚"
                return icon[str]
              end,
            },
          },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              function()
                return vim.fn.FileSize() .. " | " .. vim.fn.FileTime()
              end,
            },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
              end,
            },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = fg("Statement"),
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = fg("Constant"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            { "progress", separator = "|", padding = { left = 0, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            { "encoding", separator = " ", padding = { left = 1, right = 0 } },
            { "fileformat", padding = { left = 0, right = 1 } },
          },
        },
        winbar = {
          lualine_c = {
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            {
              "navic",
              color_correction = nil,
              navic_opts = nil,
            },
          },
        },
        extensions = { "nvim-tree" },
      }
    end,
  },
}
