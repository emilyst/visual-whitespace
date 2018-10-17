scriptencoding utf-8

function! xray#list#ConfigureListOptionsForVisualMode()
  let b:original_list      = &l:list
  let b:original_listchars = split(&l:listchars, ',')

  execute 'silent setlocal list'

  " this setting is, tragically, only global, so setting this here will
  " affect all windows, but hopefully if we do the highlighting first,
  " we won't reveal the listchars in those windows; using 'setlocal'
  " anyways because it degrades to 'set' and because someday maybe it
  " will acquire a local ability
  execute 'silent setlocal listchars='

  if !empty(xray#settings#GetSpaceChar())
    execute 'silent setlocal listchars+=space:' . escape((xray#settings#GetSpaceChar()), ' ')
  endif

  if !empty(xray#settings#GetTabChars())
    execute 'silent setlocal listchars+=tab:' . escape((xray#settings#GetTabChars()), ' ')
  endif

  if !empty(xray#settings#GetEolChar())
    execute 'silent setlocal listchars+=eol:' . escape((xray#settings#GetEolChar()), ' ')
  endif

  if !empty(xray#settings#GetTrailChar())
    execute 'silent setlocal listchars+=trail:' . escape((xray#settings#GetTrailChar()), ' ')
  endif
endfunction

function! xray#list#RestoreOriginalListOptions()
  if get(b:, 'original_list', &l:list)
    execute 'silent setlocal list'
  else
    execute 'silent setlocal nolist'
  endif

  setlocal listchars=
  execute 'silent setlocal listchars=' .
        \ escape(join(get(b:, 'original_listchars', split(&l:listchars, ',')), ','), ' ')
endfunction
