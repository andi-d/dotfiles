return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, _)
    -- Ensure spell is enabled
    vim.opt.spell = true
    vim.opt.spelllang = "de,en" -- German first, then English
  end,
}
