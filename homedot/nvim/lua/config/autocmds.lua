-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- ~/.config/nvim/lua/plugins/dashboard.lua
return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      -- ... 你原本的 dashboard 配置 ...
    },
  },
  -- 使用 config 函数，在插件加载后执行额外的设置代码
  config = function(_, opts)
    -- 首先，用传入的 opts 参数正常启动 snacks 的 dashboard
    require("snacks").setup(opts)

    -- 然后，创建我们需要的自动命令
    vim.api.nvim_create_autocmd("VimResized", {
      group = vim.api.nvim_create_augroup("lazyvim_dashboard_resize", { clear = true }),
      callback = function()
        -- 同样地，检查并刷新 dashboard
        if vim.bo.filetype == "snacks_dashboard" then
          require("snacks").dashboard.update()
        end
      end,
    })
  end,
}
