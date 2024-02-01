" clear cache so this reloads changes.
" useful for development
" lua package.loaded['lotus'] = nil
" lua package.loaded['lotus.theme'] = nil
" lua package.loaded['lotus.colors'] = nil
" lua package.loaded['lotus.util'] = nil
lua package.loaded['lotus.config'] = nil

lua require('lotus').colorscheme()
