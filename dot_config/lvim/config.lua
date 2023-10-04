-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.log.level = "info"
lvim.format_on_save.enabled = false
lvim.colorscheme = "zenbones"

vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Let's enable spellchecks
vim.opt.spell = true
vim.cmd[[autocmd FileType markdown setlocal spell]]
vim.cmd[[autocmd FileType gitcommit setlocal spell]]
vim.cmd[[autocmd FileType tex setlocal spell]]
-- Set the leader
lvim.leader = "space"

-- Set the colorcolumn
vim.opt.colorcolumn = "120"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )


-- Adding custom keymaps

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
  t = { "<cmd>UndotreeToggle<cr>", "UndoTree" },
  a = { ":exec &bg=='light'? 'set bg=dark' : 'set bg=light'<CR>", "Theme toggle"},
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.plugins = {
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
    },
    {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup()
      local function copy()
        if vim.v.event.operator == "y" and vim.v.event.regname == "" then
          require("osc52").copy_register '"'
        end
      end

      vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
    end,
    },
    {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
    },
    {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
    ft = {"fugitive"}
  },
  { "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
            plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
        }
      end, 100)
    end,
  },
  { "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
  },
  {
    "mbbill/undotree",
  },
  {
    "Silipwn/vim-header",
    config = function()
            vim.keymap.set('n','<Leader>yh',vim.cmd.AddHeader)
    end,
  },
  {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependecies = "rktjmp/lush.nvim"
},
  "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
  end,
}

vim.api.nvim_exec([[
function! Timestamp()
  let pat = '\(\(Last\)\?\s*\([Cc]hanged\?\|[Mm]odified\|[Uu]pdated\?\)\s*:\s*\).*'
  let rep = '\1' . strftime("%FT%T%z")
  call Subst(1, 20, pat, rep)
endfunction

function! Subst(start, end, pat, rep)
  let lineno = a:start
  while lineno <= a:end
    let curline = getline(lineno)
    if match(curline, a:pat) != -1
      let newline = substitute(curline, a:pat, a:rep, '')
      if newline != curline
        keepjumps call setline(lineno, newline)
      endif
    endif
    let lineno = lineno + 1
  endwhile
endfunction

augroup Timestamp
  autocmd!
  autocmd BufWritePre * call Timestamp()
augroup END
]], false)

-- Insert header correctly
vim.g.header_field_author = 'silipwn'
vim.g.header_field_author_email = 'contact at as-hw.in'
vim.g.header_field_copyright = 'Finis coronat opus; Run at this code at your own peril ~ silipwn;'
vim.g.header_auto_add_header = 0
vim.g.header_field_license_id = 'BSD-3-Clause or GPL-3.0-or-later'
vim.g.header_field_timestamp_format = '%FT%T%z'
vim.g.header_spdx_text = "silipwn (Ashwin)"

vim.g.zenbones_compat = 1

-- Comments 
-- 2023-04-15T18:14:07-0400: silipwn: Now can add fancy comments
vim.cmd [[iab cmtime <c-r>=strftime("%FT%T%z: silipwn:")<cr>]]
vim.cmd [[iab isotime <c-r>=strftime("%FT%T%z")<cr>]]
vim.cmd [[iab notetime <c-r>=strftime("%d-%m-%Y %H:%M:%S:")<cr>]]
-- Can not be placed into the config method of the plugins.
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

-- Theme
vim.o.termguicolors = true


-- vim-fugitive bindings
lvim.builtin.which_key.mappings["g"] = {
  name = "+Git",
  g = { "<cmd>:tab G<cr>", "Fugitive Window" },
  p = { "<cmd>:Git push<cr>", "Git push"}
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer"})
pcall(function()
    require("rust-tools").setup {
        tools = {
            executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
            reload_workspace_from_cargo_toml = true,
            runnables = {
                use_telescope = true,
            },
            inlay_hints = {
                auto = true,
                only_current_line = false,
                show_parameter_hints = false,
                parameter_hints_prefix = "<-",
                other_hints_prefix = "=>",
                max_len_align = false,
                max_len_align_padding = 1,
                right_align = false,
                right_align_padding = 7,
                highlight = "Comment",
            },
            hover_actions = {
                border = "rounded",
            },
            on_initialized = function()
                vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                    pattern = { "*.rs" },
                    callback = function()
                        local _, _ = pcall(vim.lsp.codelens.refresh)
                    end,
                })
            end,
        },
        server = {
            on_attach = function(client, bufnr)
                require("lvim.lsp").common_on_attach(client, bufnr)
                local rt = require "rust-tools"
                vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
            end,
            capabilities = require("lvim.lsp").common_capabilities(),
            settings = {
                ["rust-analyzer"] = {
                    lens = {
                        enable = true,
                    },
                    check = {
                        enable = true,
                        command = "clippy",
                    },
                },
            },
        },
    }
end)
-- session settings
lvim.builtin.which_key.mappings["S"]= {
    name = "Session",
    c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
  }
