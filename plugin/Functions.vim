let g:terminal_code = 0

" function! CountVisibleBuffers()
"     let num_bufs = 0
"     let idx = 1
"     while idx <= bufnr("$")
"         if bufwinnr(idx) >= 0
"             let num_bufs += 1
"         endif
"         let idx += 1
"     endwhile
"     return num_bufs
" endfunction

func! FileSize()
	let bytes = getfsize(expand("%:p"))

	if bytes < 0
		return ""
	elseif bytes < 1024
		return bytes . " bytes"
	elseif (bytes >= 1024) && (bytes < 1048576)
		return printf('%.2f Kb', bytes / 1000.0)
	elseif (bytes >= 1048576)
		return printf('%.2f Mb', bytes / 1000000.0)
	endif
endfunc

func! FileTime()
	if &buftype != ""
		return ""
	endif
	 return strftime("󰢧 %y/%m/%d %H:%M:%S", getftime(expand("%:p")))
endfunc

func ClearQuickfixList()
  call setqflist([])
endfunc
command! ClearQuickfixList call ClearQuickfixList()

"TODO: Poner en lua telescope
func! SessionSave()
	let sessName = input("Please Enter Session Name:")
	if trim(sessName) != ""
		exe 'mksession! ' . g:sessions_path . sessName . '.vim'
		exe "call feedkeys(':', 'nx')"
		echohl ModeMsg | echomsg sessName . " Session Saved!" | echohl None
	else
		exe "call feedkeys(':', 'nx')"
	endif
endfunc

func ExeCodeNew()
	let fileType = expand('%:e')
	exe "w"
	"TODO: Se podría poner en un array
	if fileType == "bat" || match(fileType, ".*htm") >= 0
		let s:cmd = ""
	elseif fileType == "bsh" || fileType == ""
		let s:cmd = "java -jar %CLASSPATH%"
	elseif fileType == "js" || fileType == "ts"
		let s:cmd = "node"
	elseif fileType == "cs"
		let s:cmd = "csc /nologo"
	elseif fileType == "py"
		let s:cmd = "python3"
	elseif &filetype == "markdown"
		exe "CocCommand markdown-preview-enhanced.openPreview"
		return
	else
		let s:cmd = fileType
	endif
	TermExec cmd='node %:t'  dir=%:p:h fdirection=vertical size=10'
	" TermExec cmd=vim.cmd[[ s:cmd ]]. 'node %:t'  fdir=%:p:h direction=horizontal size=10'
	
endfunc

func! Is_Item_Array(array, key)
	let result = ""

	for i in a:array
		if match(i[0], a:key) >= 0
			let result = i[1]
			break
		endif
	endfor

	return result
endfun

func ExeCode()
	let num_term = 0
	let fileName = expand('%')
	let fileType = expand('%:e')

	" let arrType = [
	" 	\ ["bat|.html", ""],
	" 	\ ["bsh", "java -jar %CLASSPATH%"],
	" 	\ ["javascript|typescript", "node"],
	" 	\ ["cs", "csc /nologo"],
	" 	\ ["python", "python3"],
	" 	\ ["markdown", "CocCommand markdown-preview-enhanced.openPreview"]
	" 	\ ]
	" let cmd = Is_Item_Array(arrType, &filetype)
	" let arrType = [
	" 	\ {lang:"bat|.html", command:""},
	" 	\ {lang:"bsh", command:"java -jar %CLASSPATH%"},
	" 	\ {lang:"javascript|typescript", command:"node"},
	" 	\ {lang:"cs", command:"csc /nologo"},
	" 	\ {lang:"python", command:"python3"},
	" 	\ {lang:"markdown", command:"CocCommand markdown-preview-enhanced.openPreview"}
	" 	\ ]

	" let arrType = { ['bat'] = '', ['javascript'] = 'node' }
	" echo "cmd:" . cmd

	" return
	" if &filetype == "markdown"
	" 	exe "CocCommand markdown-preview-enhanced.openPreview"
	" 	return
	" else

	" 	let cmd = fileType

	"TODO:check file is save
	exe "w"
	" echo "cd " . expand("#:p:h")
	" exe "cd " . expand("#:p:h")

		" "TODO:contenido buffer
		" let content = join(getline(1, '$'), "\n")
		" if trim(content) != ""
		" 	"Note:CLASSPATH = <path>/bsh-core-2.0b4.jar
		" 	exe 'BeanShell'
		" endif

	
	"TODO: Se podría poner en un array
	if fileType == "bat" || match(fileType, ".*htm") >= 0
		let cmd = ""
	elseif fileType == "bsh" || fileType == ""
		let cmd = "java -jar %CLASSPATH%"
	elseif fileType == "js" || fileType == "ts"
		let cmd = "node"
	elseif fileType == "cs"
		" let cmd = "csc /nologo"
		let cmd = "dotnet-script"
	elseif fileType == "py"
		let cmd = "python3"
	elseif &filetype == "markdown"
		exe "CocCommand markdown-preview-enhanced.openPreview"
		return
	else
		let cmd = fileType
	endif

	try
		let bufmap = map(range(1, winnr('$')), '[bufname(winbufnr(v:val)), v:val]')
		let num_term = filter(bufmap, 'v:val[0] =~ "term"')[0][1]
	catch
	endtry

	if num_term == 0
	 	" exe ":vertical botright 50sp|term"
	 	" exe ":vnew|term"
		exe "bo 15sp|term"
		let bufnr = bufnr('%')
		let g:terminal_code = b:terminal_job_id
		norm G
		wincmd p
	endif

	" if fileType == "cs"
	" 	exe "silent !" . cmd " " . fileName
	" 	sleep 500m
	" 	call chansend(g:terminal_code, substitute(fileName, "cs", "exe", "") . "\r")
	" 	exe "silent !del " . substitute(fileName, "cs", "exe", "")
	" else
		" echo cmd . " " . fileName
		" call chansend(g:terminal_code, cmd . " " . fileName . "\r")
		call chansend(g:terminal_code, "\r" . cmd . " " . fileName . "\r")
	" endif

	" if num_term == 0
	" 	wincmd p
	" endif
endfunc

func Terminal()
	exe "bo 15sp|term"
	exe "set nornu"
	exe "set nonu"

	let bufnr = bufnr('%')
	call setbufvar(bufnr, '&buflisted', 0)

	silent au BufWinEnter,WinEnter <buffer> startinsert!
	startinsert!
endfunc
command! Terminal call Terminal()

func TerminalVertical()
	exe "vert bo 49sp|term"
	exe "set nornu"
	exe "set nonu"

	let bufnr = bufnr('%')
	call setbufvar(bufnr, '&buflisted', 0)

	silent au BufWinEnter,WinEnter <buffer> startinsert!
	startinsert!
endfunc
command! TerminalVertical call TerminalVertical()

func CopyOutputCommand()
	let command = input("Enter Command to copy:")

	if command == ''
		exe "norm! \<Esc>"
		return
	endif

	try
		call GuiClipboard()
	catch
	endtry
	exe "redir @* | " . command . " | redir END"
	echohl WarningMsg | echomsg "Output Copied" | echohl None
endfunc

func TruncateLines()
	let column = input("Column from Truncate:")

	if column == '' || column == '0'
		exe "norm! \<Esc>"
		return
	endif

	exe '%s/.\{' . column . '}\zs.*//'
endfunc

func! GoToRepositoryPlugin()
	let repo = getline('.')

	if empty(matchstr(repo, ".*\".*/.*\""))
		echohl WarningMsg | echomsg "Is Not valid Plug 'repository'" | echohl None
		return
	endif

	let repo = "https://github.com/" . substitute(repo, "\\(.*\"\\)\\(.*\\)\\(\".*\\)", "\\2", "")
	exe OpenBrowser(repo)
	" exe "norm! \<C-o>\<C-o>"
	" exe "norm! \<C-o>"
	" norm! <c-o><c-o>
	" norm! <c-o>
endfunc

"TODO:2 or 3 digits must be lower
func FirstUpperCase()
	exe "silent %s/.*/\\L&/g"
	exe "silent %s/\\<./\\u&/g"
	exe "silent %s/\\v(_.)/\\U&/g"
endfunc

func Format()
	if &filetype == "php"
		%! prettier --parser=php
	elseif &filetype == "lua"
		%! prettier --parser=lua
		"%! prettier --stdin --parser=lua
	elseif &filetype == "python"
		exe "Black"
	else
		exe "CocCommand prettier.formatFile"
	endif
endfunc

func Differences()
	if &diff == 1
		exe "diffoff"
	else
		exe "windo diffthis"
	endif
endfunc

func SearchClipboard()
	let search = substitute(@+, "\n", "", "g")
	let search = substitute(search, "\\", "\\\\\\", "g")
	let @/ = '\c\V' . search

	exe "norm n"
endfunc

nmap <C-p> :call PasteFormat()<CR>
func PasteFormat()
	"TODO:no mostrar errores ni mensajes de reemplazos
	" let nomore_save = &nomore
	" set nomore
  " redir @a

	norm vibp

	"Trim up and down
	exe "%s/\\(^[ ]*\\n\\)*//g"
	exe "%s/\\n\$//"

	"delete custom
	exe "%s/•//"
	exe ":%s/.*la respuesta.*\\n//"

	exe "norm VG\<Esc>"
	call _ListLetter()

	"delete final custom
	exe "%s/ \\{2,}/ /g"

	norm yib

	" let &nomore = nomore_save
  " redir END
endfunc

command! ListLetter call _ListLetter()
func! _ListLetter()
	exe ":'<,'>s/^/\\=nr2char(char2nr('a') + line('.') - line(\"'<\")) . '. '/"
endfunc
