" From: https://github.com/Lokaltog/neoranger
" 
"# Neoranger

"## Introduction

"**Neoranger is a simple ranger wrapper script for neovim. It's inspired by Drew 
"Neil's [thoughs on project 
"drawers](http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/). 
"It's like [vinegar](https://github.com/tpope/vim-vinegar) or 
"[filebeagle](https://github.com/jeetsukumaran/vim-filebeagle), but with ranger 
"as the interface.**

"Neoranger opens a terminal with ranger in the current window. It sets ranger's 
"viewmode to `multipane`, making it easy to use in narrow windows. You can 
"select and open multiple files.

"The wrapper script ensures that split windows don't break when the terminal 
"window is closed, by restoring the previous buffer in the current window.

"Note that neoranger replaces netrw.

"## Usage

"Neoranger provides two commands, `:Ranger` and `:RangerCurrentFile`.

"`:Ranger` accepts an optional directory and file argument. If no arguments are 
"provided it opens ranger in the current working directory.

"`:RangerCurrentFile` opens ranger and selects the currently open file.

"## Mappings

"Neoranger doesn't add any mappings by default. The following mappings makes 
"neoranger behave like vinegar or filebeagle:

"```vim
"" Open ranger at current file with "-"
"nnoremap <silent> - :RangerCurrentFile<CR>

"" Open ranger in current working directory
"nnoremap <silent> <Leader>r :Ranger<CR>
"```


function! s:RangerOpenDir(...)
	let path = a:0 ? a:1 : getcwd()

	if !isdirectory(path)
		echom 'Not a directory: ' . path
		return
	endif

	let s:ranger_tempfile = tempname()
	let opts = ' --cmd="set viewmode miller"'
	let opts .= ' --choosefiles=' . shellescape(s:ranger_tempfile)
	if a:0 > 1
		let opts .= ' --selectfile='. shellescape(a:2)
	else
		let opts .= ' ' . shellescape(path)
	endif
	let rangerCallback = {}

	function! rangerCallback.on_exit(id, code, _event)
		" Open previous buffer or new buffer *before* deleting the terminal 
		" buffer. This ensures that splits don't break if ranger is opened in 
		" a split window.
		if w:_ranger_del_buf != w:_ranger_prev_buf
			" Restore previous buffer
			exec 'silent! buffer! '. w:_ranger_prev_buf
		else
			" Previous buffer was empty
			enew
		endif

		" Delete terminal buffer
		exec 'silent! bdelete! ' . w:_ranger_del_buf

		unlet! w:_ranger_prev_buf w:_ranger_del_buf

		let names = ''
		if filereadable(s:ranger_tempfile)
			let names = readfile(s:ranger_tempfile)
		endif
		if empty(names)
			return
		endif
		for name in names
			exec 'edit ' . fnameescape(name)
			doautocmd BufRead
		endfor
	endfunction

	" Store previous buffer number and the terminal buffer number
	let w:_ranger_prev_buf = bufnr('%')
	enew
	let w:_ranger_del_buf = bufnr('%')

	" Open ranger in nvim terminal
	call termopen('command ranger ' . opts, rangerCallback)
	setlocal filetype=ranger
	startinsert
endfunction

" Override netrw
let g:loaded_netrwPlugin = 'disable'
augroup ReplaceNetrwWithRanger
	autocmd StdinReadPre * let s:std_in = 1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | call s:RangerOpenDir(argv()[0]) | endif
augroup END

command! -complete=dir -nargs=* Ranger :call <SID>RangerOpenDir(<f-args>)
command! -complete=dir -nargs=* RangerCurrentFile :call <SID>RangerOpenDir(expand('%:p:h'), @%)
