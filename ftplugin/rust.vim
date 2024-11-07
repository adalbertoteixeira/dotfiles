let b:ale_linters = ['analyzer', 'cargo']
let b:ale_rust_rustfmt_options = '--edition 2024'
" let b:ale_rust_cargo_use_clippy = 1
" let b:ale_rust_cargo_check_tests = 1 
" let b:ale_rust_cargo_check_examples = 1
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace', 'rustfmt']
set foldmethod=syntax  
set foldlevel=99
