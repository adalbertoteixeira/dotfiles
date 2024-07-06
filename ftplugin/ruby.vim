let b:ale_linters = ['rubocop', 'ruby']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace', 'rubyfmt', 'rubocop']
set foldmethod=syntax  
set foldlevel=99



   "  2 Available Linters: ['brakeman', 'cspell', 'debride', 'packwerk', 'rails_best_practices', 'reek', 'rubocop', 'ruby', 'solargraph', 'sorbet', 'standardrb']
   "  3   ¦Linter Aliases:
   "  4 'sorbet' -> ['srb']
   "  5   Enabled Linters: []
   "  6   Ignored Linters: []
   "  7  Suggested Fixers:
   "  8   'prettier' - Apply prettier to a file.
   "  9   'remove_trailing_lines' - Remove all blank lines at the end of a file.
   " 10   'rubocop' - Fix ruby files with rubocop --auto-correct.
   " 11   'rufo' - Fix ruby files with rufo
   " 12   'sorbet' - Fix ruby files with srb tc --autocorrect.
   " 13   'standardrb' - Fix ruby files with standardrb --fix
   " 14   'syntax_tree' - Fix ruby files with stree write
   " 15   'trim_whitespace' - Remove all trailing whitespace characters at the end of every line.s
