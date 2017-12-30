" ============================================================================
" File: esperanto.vim
" Description: Vim plugin for typing in Esperanto language
" Author: Sergey Potapov <blake131313 AT gmail DOT com>
" Version: 0.1
" Homepage: http://github.com/greyblake/vim-esperanto
" License: LGPLv3 - look it up.
" Copyright: Copyright (C) 2013-2013 Sergey Potapov
" ============================================================================


" Variables used by script to track state of environment
let s:esperanto_is_on = 0
let s:prev_spelllang  = "en"
let s:prev_eo_map     = ""


" Apply a mappings. Backup existing mappings, so it can be restored by
" unmap function.
function! s:Mapper_map() dict
    let self.prev_mappings = []

    for mode in self.modes
        let map_cmd = mode . 'map'
        for pair in items(self.mappings)
            " Backup previous mappings
            let prev_map_value = maparg(pair[0], mode)
            if prev_map_value
                call add(self.prev_mappings, [mode, pair[0], prev_map_value])
            endif

            let cmd = map_cmd . ' ' . pair[0] . ' ' . pair[1]
            execute cmd
        endfor
    endfor
endfunction

" Inactivate mappings, restore previous mappings.
function! s:Mapper_unmap() dict
    " Remove set mappings
    for mode in self.modes
        let map_cmd = mode . 'unmap'
        for pair in items(self.mappings)
            let cmd = map_cmd . ' ' . pair[0]
            execute cmd
        endfor
    endfor

    " Set mappings which were used before applying the mapping
    for prev_map in self.prev_mappings
        let map_cmd = prev_map[0] . 'map'
        let cmd     = map_cmd . ' ' . prev_map[1] . ' ' . prev_map[2]
        execute cmd
    endfor
endfunction

" Basic object for mapping with map and unmap functions.
let s:Mapper = {
    \ 'modes':[],
    \ 'mappings':{},
    \ 'prev_mappings':[],
    \ 'map':function('s:Mapper_map'),
    \ 'unmap':function('s:Mapper_unmap')
    \ }




function! s:build_transliteration_mapping(xchar)
    " Mapping for x- and -h transliteration systems.
    let chars_mapping = {"h":"ĥ", "j":"ĵ", "u":"ŭ", "c":"ĉ", "s":"ŝ", "g":"ĝ"}

    let mapper = deepcopy(s:Mapper)
    let mapper.modes = ['i', 'c']

    if toupper(a:xchar) == tolower(a:xchar)
        let xchars = [a:xchar]
    else
        let xchars = [tolower(a:xchar), toupper(a:xchar)]
    end

    for xchar in xchars
        for maps in items(chars_mapping)
            let low_from = maps[0] . xchar
            let low_to   = maps[1]
            let mapper.mappings[low_from] = low_to

            let up_from = toupper(maps[0]) . xchar
            let up_to   = toupper(maps[1])
            let mapper.mappings[up_from] = up_to
        endfor
    endfor

    return mapper
endfunction

function! s:build_eo_keyboard_mapping()
    let eo_key_maps = {'q':'ŝ', 'w':'ĝ', 'y':'ŭ', '[':'ĵ', 'x':'ĉ', ']':'ĥ'}

    let mapper = deepcopy(s:Mapper)
    let mapper.modes = ['i', 'c']

    for mapping in items(eo_key_maps)
        let en_char  = mapping[0]
        let eo_char  = mapping[1]

        let mapper.mappings[en_char] = eo_char

        if en_char == "["
            let mapper.mappings['{'] = toupper(eo_char)
        elseif en_char == "]"
            let mapper.mappings['}'] = toupper(eo_char)
        else
            let mapper.mappings[toupper(en_char)] = toupper(eo_char)
        endif
    endfor

    return mapper
endfunction



let s:eo_maps = {
    \ 'x'        : s:build_transliteration_mapping("x"),
    \ 'h'        : s:build_transliteration_mapping("h"),
    \ 'caret'    : s:build_transliteration_mapping("^"),
    \ 'keyboard' : s:build_eo_keyboard_mapping()
    \ }



function! esperanto#on()
    if s:esperanto_is_on
        echo "Esperanto is already on"
        return
    endif

    if has_key(s:eo_maps, g:EoMap)
        let mapping = s:eo_maps[g:EoMap]
        call mapping.map()
    else
        echo "Unknown EoMap: " . g:EoMap .'. Please use "keyboard", "caret", "x" or "h"'
        return
    endif

    " Backup spelling language and set esperanto
    if g:EoSpell
        let s:prev_spelllang = &spelllang
        set spelllang=eo
    end


    " Back up EoMap to correctly unmap
    let s:prev_eo_map     = g:EoMap
    let s:esperanto_is_on = 1

    echo 'Esperanto on(' . g:EoMap . ')'
endfunction


function! esperanto#off()
    if !s:esperanto_is_on
        echo "Esperanto is already off"
        return
    endif

    if has_key(s:eo_maps, s:prev_eo_map)
        let mapping = s:eo_maps[s:prev_eo_map]
        call mapping.unmap()
    else
        echo "Unknown EoMap: " . s:prev_eo_map . '. Please use "keyboard", "caret", "x" or "h"'
        return
    endif

    " Return previous spelling language
    if g:EoSpell
        let &spelllang=s:prev_spelllang
    end

    let s:esperanto_is_on = 0
    echo "Esperanto off"
endfunction


function! esperanto#toggle()
    if s:esperanto_is_on
        call esperanto#off()
    else
        call esperanto#on()
    endif
endfunction
