function! viadi#insert_lines(bufnr, lines)
  call deletebufline(a:bufnr, 1, '$')
  call appendbufline(a:bufnr, 0, a:lines)
endfunction

function! viadi#insert_at_cursor(bufnr, lines)
  let row = getcurpos()[1]
  call appendbufline(a:bufnr, row - 1, a:lines)
  call cursor(row + len(a:lines), 0)
endfunction

function! viadi#adi_field(name, value)
  let uppercase_value = toupper(a:value)
  return printf('<%s:%d>%s', a:name, len(uppercase_value), uppercase_value)
endfunction

function! viadi#add_adi_header()
  let bufnr = bufnr()

  let header = [
    \ '<ADIF_VER:5>3.1.6',
    \ '<PROGRAMID:5>viadi',
    \ '<PROGRAMVERSION:5>0.1.0',
    \ '<CREATED_TIMESTAMP:20>' . viadi#time_stamp(),
    \ '<EOH>',
    \ '',
    \ ]

  call viadi#insert_at_cursor(bufnr, header)
endfunction

function! viadi#time_stamp()
  return system('date -u +%Y-%m-%dT%H:%M:%S')
endfunction

function! viadi#date_time_now()
  let date = trim(system('date -u +%Y%m%d'))
  let time = trim(system('date -u +%H%M'))
  return date, time


function! viadi#start_qso_entry()
  let call = input('Callsign: ')
  if call == ''
    return
  endif

  let band = input('Band (e.g. 2m, 20m): ')
  if band == ''
    return
  endif

  let mode = input('Mode (e.g. FM, SSB): ')
  if mode == ''
    return
  endif

  let rst_sent = input('RST Sent: ')
  if rst_sent == ''
    return
  endif

  let rst_rcvd = input('RST Rcvd: ')
  if rst_rcvd == ''
    return
  endif

  let comment = input('Comment: ')
  if comment == ''
    return
  endif
  
  let qso_date, time_on = viadi#date_time_now()

  let line1 = join([
    \ viadi#adi_field('QSO_DATE', qso_date),
    \ viadi#adi_field('TIME_ON', time_on),
    \ viadi#adi_field('CALL', call),
    \ ], ' ')

  let line2 = join([
    \ viadi#adi_field('BAND', band),
    \ viadi#adi_field('MODE', mode),
    \ viadi#adi_field('RST_SENT', rst_sent),
    \ viadi#adi_field('RST_RCVD', rst_rcvd),
    \ ], ' ')

  let line3 = join([
    \ viadi#adi_field('COMMENT', comment),
    \ '<EOR>',
    \ ], ' ')

  let bufnr = bufnr()
  call viadi#insert_at_cursor(bufnr, [line1, line2, line3])
endfunction

function! viadi#setup()
  nnoremap <leader>adi :call viadi#add_adi_header()<CR>
  nnoremap <leader>qso :call viadi#start_qso_entry()<CR>
endfunction
