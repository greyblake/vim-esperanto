" ============================================================================
" File: esperanto.vim
" Description: Vim plugin for typing in Esperanto language
" Author: Sergey Potapov <blake131313 AT gmail DOT com>
" Version: 0.1
" Homepage: http://github.com/greyblake/vim-esperanto
" License: LGPLv3 - look it up.
" Copyright: Copyright (C) 2013-2013 Sergey Potapov
" ============================================================================


" Default settings
if(!exists('g:EoMap'))
    let g:EoMap = "keyboard"
endif

if(!exists('g:EoSpell'))
    let g:EoSpell = 1
endif


" Commands
command! EoOn  call esperanto#on()
command! EoOff call esperanto#off()
command! Eo    call esperanto#toggle()
command! EO    call esperanto#toggle()
