return {
  {
    "folke/sidekick.nvim",
    opts = {
      keymaps = {
        accept = "<Tab>",
        next = "<M-]>",
        prev = "<M-[>",
      },
      nes = { enabled = false },
      cli = {
        tools = {
          antigravity = {
            cmd = { "agy" },
          },
        },
      },
    },
  },
}
