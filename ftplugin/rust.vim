let b:ale_linters = ['cargo']

function! FormatClippy(buffer) abort
return {
         'command': 'cargo clippy --fix'
    }
  endfunction
    execute ale#fix#registry#Add('clippy', 'FormatClippy', ['rust'], 'clippy for rust')
  

let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace', 'rustfmt']
