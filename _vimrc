" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Mouse behavior (the Windows way)
behave mswin
set t_Co=256


set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set number
set relativenumber
"set cursorline
"set cursorcolumn
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set background=dark

" Dosya adı, değişiklik durumu ve okuma durumu
set statusline=
set statusline+=\ %F\               " Tam dosya yolu
set statusline+=\ %M\               " Değişiklik durumu (+ ekli ise değiştirilmiş)
set statusline+=\ %Y\               " Dosya tipi (örneğin, python, txt, vb.)
set statusline+=\ %R\               " Dosya okuma/yazma durumu (readonly vs.)
" Orta alanda durum bilgisi
set statusline+=%=                 " Orta hizalamayı başlat
" Satır ve sütun bilgisi
set statusline+=\ Row:\ %l\        " Satır numarası
set statusline+=\ Col:\ %c\        " Sütun numarası
set statusline+=\ Line:\ %p%%\     " Dosya içindeki yüzde pozisyonu
" Dosya boyutu (insan dostu formatta)
set statusline+=\ FileSize:\ %{GetFileSize(expand('%'))}\   " Dosya boyutunu uygun formatta al
" Mod bilgisi (insert, normal, vb.)
set statusline+=\ [%{mode()}]\    " Mod durumu (örneğin, [INSERT], [NORMAL])
" Hata sayısı (ALE gibi hata eklentisi varsa)
set statusline+=\ Errors:\ %{len(getloclist(0))}\ " Hata sayısı (ALE veya başka bir hata listesi kullanıyorsa)
" Satır numarasına göre kalan satır sayısı
set statusline+=\ \ [%l/%L]\       " Satır numarası / Toplam satır sayısı
" Zaman bilgisi
set statusline+=\ %{strftime('%H:%M:%S')}\ " Zaman bilgisi (saat:dakika:saniye)
set laststatus=2  " Her zaman durum çubuğunu göster

" Dosya boyutunu insan dostu şekilde döndüren fonksiyon
function! GetFileSize(file)
    let size = getfsize(a:file)
    if size < 1024
        return size . 'B'
    elseif size < 1048576
        return printf('%.2fKB', size / 1024)
    elseif size < 1073741824
        return printf('%.2fMB', size / 1048576)
    else
        return printf('%.2fGB', size / 1073741824)
    endif
endfunction


set completeopt=menuone,longest
set shortmess+=c

" == PLUGIN ==
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'w0rp/ale'
Plug 'vim-scripts/AutoComplPop'

Plug 'jsit/toast.vim'
Plug 'gregsexton/Muon'
Plug 'svjunic/RadicalGoodSpeed.vim'
Plug 'vim-scripts/icansee.vim'
Plug 'Mofiqul/vscode.nvim'
Plug 'morhetz/gruvbox'
Plug 'letorbi/vim-colors-modern-borland'
Plug 'rebelot/kanagawa.nvim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'comfysage/evergarden'
Plug 'pineapplegiant/spaceduck'

call plug#end()
colorscheme radicalgoodspeed

"
" run :source % .and. :PlugInstall

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-r> :NERDTreeRefreshRoot<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>



