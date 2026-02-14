if exists("g:loaded_viadi")
  finish
endif
let g:loaded_viadi = 1

echom 'viadi.vim loading...'
call viadi#setup()
echom 'viadi#setup() called successfully!'

