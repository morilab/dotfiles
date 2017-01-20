filetype off " ファイルタイプ系を一旦OFF

if has('vim_starting')
  set nocompatible " 挙動をvi互換でなくvimデフォルト動作に変更

  " neobundleがない場合にインストールを試みる
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
      echo "install neobundle..."
      :call system("git clone http://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
      echo "再度vimを起動してください。"
      :cquit
  endif
  if isdirectory(expand("~/.vim/bundle/vimproc/"))
      if !filereadable("~/.vim/bundle/vimproc/autoload/vimproc_linux64.so")
          :call system("cd ~/.vim/bundle/vimproc/; make -f make_unix.mak;")
      endif
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/ " bundleで管理するディレクトリの指定
endif

call neobundle#begin(expand('~/.vim/bundle/'))
"call neobundle#load_cache() "キャッシュの読み込み(起動高速化用)
NeoBundleFetch 'Shougo/neobundle.vim' "自身もneobundleで管理

NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimproc'
if v:version > 702
  NeoBundle 'Shougo/vimshell'
  NeoBundle 'Shougo/vimfiler'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'tyru/caw.vim.git'
  NeoBundle 'tpope/vim-endwise.git'
endif

" NeoSnippet設定
  " 補完プラグイン(lua有効かどうかで切り替え)
  NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
  if neobundle#is_installed('neocomplete')
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*' " 日本語を補完候補から外す
  elseif neobundle#is_installed('neocomplcache')
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    if !exists('g:neocomplcache_keyword_patterns')
      let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
  endif
  inoremap <expr><C-g>   neocomplcache#undo_completion()
  inoremap <expr><C-l>   neocomplcache#complete_common_string()
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
        return neocomplcache#smart_close_popup() . "\<CR>"
  endfunction
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

  " スニペット補完プラグイン
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'  " 各種スニペット
  if ! empty(neobundle#get("neosnippet"))
    " キーマッピング
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
    "snippetの置き場所
      let g:neosnippet#snippets_directory = '~/.vim/mysnip/'
  endif

  " 多言語対応コメントアウトプラグイン
  nmap <Leader>c <Plug>(caw:i:toggle)
  vmap <Leader>c <Plug>(caw:i:toggle)


" カラースキーム

" solarized カラースキーム
  NeoBundle 'altercation/vim-colors-solarized'
" mustang カラースキーム
  NeoBundle 'croaker/mustang-vim'
" wombat カラースキーム
  NeoBundle 'jeffreyiacono/vim-colors-wombat'
" jellybeans カラースキーム
  NeoBundle 'nanotech/jellybeans.vim'
" lucius カラースキーム
  NeoBundle 'vim-scripts/Lucius'
" zenburn カラースキーム
  NeoBundle 'vim-scripts/Zenburn'
" mrkn256 カラースキーム
  NeoBundle 'mrkn/mrkn256.vim'
" railscasts カラースキーム
  NeoBundle 'jpo/vim-railscasts-theme'
" pyte カラースキーム
  NeoBundle 'therubymug/vim-pyte'
" molokai カラースキーム
  NeoBundle 'tomasr/molokai'
" badwolf カラースキーム
  NeoBundle 'sjl/badwolf'

" カラースキーム一覧表示に Unite.vim を使う
  NeoBundle 'ujihisa/unite-colorscheme'

  " インデント可視化プラグイン
  NeoBundle 'nathanaelkane/vim-indent-guides'
  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=52
  "set ts=1 sw=1 noet
  "let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_guide_size = 1
  let g:gitgutter_max_signs      = 5000

  " AnsiEsc ANSIカラー埋め込みファイル反映プラグイン
  NeoBundle 'vim-scripts/AnsiEsc.vim'

NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
"NeoBundle 'https://bitbucket.org/kovisoft/slimv'
"NeoBundleSaveCache " キャッシュの書き込み(起動高速化用)
call neobundle#end()
filetype plugin indent on
filetype indent on
NeoBundleCheck


syntax on
set t_Co=256 " 256色有効化
set number " 行番号の表示
set mouse=a " マウスの挙動。ドラッグ選択時に行番号を除く。
set incsearch " インクリメントサーチ有効
set wildmenu wildmode=list:full " 補完メニューの種類
set list listchars=tab:\|\< " タブの表示

set expandtab    "インデントはスペース
set shiftwidth=4 "インデント数
set autoindent   " 前の行のインデントを継続する
set smartindent  " 行末に従って次の行のインデントを制御する
set clipboard=exclude:.* "クリップボード連携

colorscheme badwolf
