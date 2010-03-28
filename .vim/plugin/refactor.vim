" :Refactor oldname newname
"   - project-wide substitution, with confirmation

function! Refactor(old, new)
  let files = system('ack -li ' . a:old)
  let substitution = '%s/' . a:old . '/' . a:new . '/ce'

  " reset the args list to all files in the app directory that contain <old> (case insensitive)
  execute 'args' substitute(files, "\n", " ", "g")

  " replace <old> with <new> in each arg file, with confirmation, suppress 'no match' errors, and save each file
  " (argdo will add Syntax to eventignore, but we want syntax highlighting)
  execute 'argdo set eventignore-=Syntax | ' . substitution . ' | update'
endfunction

command! -nargs=+ -complete=file Refactor call Refactor(<f-args>)

