let b:ale_linters = ['analyzer', 'cargo']

" function! FormatClippy(buffer) abort
" return {
"          'command': 'cargo clippy --fix'
"     }
"   endfunction
"     execute ale#fix#registry#Add('clippy', 'FormatClippy', ['rust'], 'clippy for rust')
  

" let b:ale_rust_rustfmt_options = '--edition 2018'
" let b:ale_rust_cargo_use_clippy = 1
" let b:ale_rust_cargo_check_tests = 1 
" let b:ale_rust_cargo_check_examples = 1

let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace', 'rustfmt']
