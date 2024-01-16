vim.g.coq_settings = {
  auto_start = 'shut-up'
}
return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  lazy = false,
  dependencies = {
    { "ms-jpq/coq.artifacts",  branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" },
  },
}
