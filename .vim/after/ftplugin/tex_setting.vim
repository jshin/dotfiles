"quickrun setting for latex
let g:quickrun_config['tex'] = {
			\ 'runnner' : 'job',
			\ 'command' : 'latexmk',
			\ 'outputter' : 'error',
			\ 'cmdopt' : '-pv',
			\ 'outputter/error/success' : 'null',
			\ 'outputter/error/error' : 'quickfix',
			\ 'srcfile' : expand("%s"),
			\ 'exec' : '%c %s %a %o',
			\}
let g:tex_conceal=''

function! s:replacedot()
	let cursor = getpos(".")
	%s/。/./ge
	%s/、/, /ge
	call setpos(".", cursor)
	unlet cursor
endfunction
autocmd BufWritePre *.tex call <SID>replacedot()
setl spelllang=en_us,cjk
setl spell
