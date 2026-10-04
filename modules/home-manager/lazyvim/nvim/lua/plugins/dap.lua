return {
  "mfussenegger/nvim-dap",
  optional = true,
  opts = function()
    local dap = require("dap")
    dap.adapters["codelldb"] = {
      type = "server",
      host = "127.0.0.1",
      port = "${port}",
      executable = {
        command = vim.env.CODELLDB_PATH,
        args = { "--port", "${port}", "--liblldb", vim.env.LIBLLDB_PATH },
      },
    }
  end,
}
