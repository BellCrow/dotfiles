 vim.pack.add ({"https://github.com/nvim-orgmode/orgmode"})

require('orgmode').setup({
  org_agenda_files = '~/orgfiles/**/*',
  org_default_notes_file = '~/orgfiles/refile.org',
  org_todo_keywords = {'TODO','IN_PROGRESS','WAITING', '|', 'DONE'}
})

vim.lsp.enable('org')
