lua require("utils")
if exists('g:vscode')
  lua require("config.lazy-vscode")
else
  lua require("config.lazy")
endif
