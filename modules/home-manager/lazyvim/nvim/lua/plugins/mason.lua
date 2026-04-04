return {
  -- Deaktiviert das Haupt-Plugin
  { "mason-org/mason.nvim", enabled = false },
  
  -- Deaktiviert die automatische Installation von LSP-Servern
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  
  -- Deaktiviert Mason-Integration für Formatter und Linter (null-ls / conform)
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
}
