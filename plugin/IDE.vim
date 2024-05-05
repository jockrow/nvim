func! DebugAddWatch()
	let watch	= expand('<cword>')
	echo watch
	" _DebugAddWatch()
	" let bufmap = map(range(1, winnr('$')), '[bufname(winbufnr(v:val)), v:val]')
	" let w_watch = filter(bufmap, 'v:val[0] =~ "DAP Watches"')[0][1]
	" exe w_watch . "wincmd w"
	" exe "normal! A" . watch . "\<CR>"
	" exe "wincmd p"
endfunc

func! DebugAddWatchVisual()
	exe "y"
	" exe "normal! y"
	" exe "visual! y"
	" let watch	= @"
	" echo watch
	" echo substitute(getreg(v:register, 1, 1), '\%V', '', '')
	" _DebugAddWatch()
endfunc

func! _DebugAddWatch()
	let bufmap = map(range(1, winnr('$')), '[bufname(winbufnr(v:val)), v:val]')
	let w_watch = filter(bufmap, 'v:val[0] =~ "DAP Watches"')[0][1]
	exe w_watch . "wincmd w"
	exe "normal! A" . watch . "\<CR>"
	exe "wincmd p"
endfunc
