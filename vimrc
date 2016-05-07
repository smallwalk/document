"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn off nice effect on status bar title
let performance_mode=0
let use_plugins_i_donot_use=0
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"我们对Vim的描述都假设它是在增强模式下, 所以并不能完全与Vi兼容
"所以首先确保关闭了 "compatible" 选项
set nocompatible
 
"定义当前的操作系统, 使用不同的系统时, 需要手动修改返回值
"返回值可以为 "win32" / "unix"/ "mac"
function! MySys()
    return "win32"
endfunction
 
"在Vim中执行一些过滤操作需要知道一些shell的有关情况
"如果在使用过滤程序时遇到问题, 可以考虑检查下面一些选项的设置:
"   "shell"         指定Vim用于运行过滤程序的shell
"   "shellcmdflag"  该shell的参数
"   "shellquote"    用于分隔shell与过滤程序时成对包围起过滤程序
"                   的字符
"   "shellxquote"   用于分隔shell与过滤程序和重定向符号时成对包
"                   围起过滤程序和重定向符号的字符
"   "shelltype"     shell的类型(只对Amiga有用
"   "shellslash"    在命令中使用反斜杠(只对MS-Windows)这样的
"                   系统有用
"   "shellredir"    用于将命令输出重定向到文件的字符串
"
"在Unix上使用过滤程序很少会碰到问题, 因为有两种shell: 'sh'派和
"'csh'派. Vim会检查 "shell" 选项看是否包含了'csh'并自动设置相关的
"选项.
"但在windows上,有很多不同的shell,所以你要手工调整这些选项来让过滤
"功能正常动作.请查看上面这些相关选项的帮助以了解更多信息
if MySys() == "unix" || MySys() == "mac"
    "在Unix和类Unix操作系统中使用 "bash" 作为 "shell"
    set shell=bash
else
    "如果是在windows下使用cygwin, 则修改为cynwin的路径
    "set shell=E:cygwininsh
endif
 
"设置冒号命令和搜索命令的命令历史列表的长度
"历史记录的基本思想是可以用上下箭头键来找回用过的命令.
"
"实际上有四个历史记录, 这里将要提到的是冒号命令历史记录和 "/"
"及 "?" 的搜索命令历史记录, "/" 和 "?"都是搜索命令,所以它们共享
"同一个历史记录, 另外的两类历史记录分别是关于表达式和input()
"函数的输入内容的
"
"假设你用过一次 ":set" 命令, 接着用过10次其他的冒号命令之后又
"想要重复这个 ":set" 命令,你可以按下 ':' 然后按10次上箭头键<Up>,
"更快的办法是: 
"   ":set<Up>"
"Vim会回到上一次你以'se'开头的命令去,这样你离':set'命令就更
"近了一些,至少一不用按10次上箭头<Up>了(除非这中间的10个冒号
"也都是':set'命令).
"
"上箭头键<Up>会根据目前的键入的命令部分去跟历史记录进行比较,
"只有符合的才会被列出来.如果没有找到,你还可以用下箭头<Down>
"回到刚才输入的部分命令进行修改,或者用Ctrl-U命令全部删除后
"重来.
"
"要查看所有的历史记录,用命令:
"   ":history"
"列出的是冒号的历史记录,要查看搜索命令的历史记录,用:
"   ":history /"
"
"Ctrl-P效果如同<Up>,唯一的不同是它不会根据你已经键入的部分区
"遍历历史,类似地,<Down>对应物事Ctrl-N"和下箭头键.Ctrl-P代表
"previous,Ctrl-N代表Next
set history=400
 
"这段命令开启了Vim的三种职能:
"
"1. 自动识别文件类型
"你开始编辑一个文件时,Vim就会自动识别它是何种类型的文件,比
"如说你打开了'main.c',Vim就会根据它的'.c'扩展名知道它是一个
"类型为 "c" 的C语言源程序文件,当你编辑一个文件其第一行是
"'#!bin/sh'时,Vim又可以据此判断它是一个类型为 "sh" 的shell脚
"本文件
"
"2. 用文件类型plugin脚本
"不同的文件类型需要搭配适合它的编辑选项.比如说你在编辑一个
" "c" 文件,那么打开 "cindent" 新非常有用,这些对某种文件类型来
"说最常用的选项可以放在一个Vim中交文件类型plugin的脚本里.
"你还可以加上你自己写的,请参考 "write-filetype-plain".
"
"3. 使用缩进定义文件
"编辑程序的时候,语句的缩进可以让它自动完成.Vim为众多不同的
"文件类型提供了相应的缩进方案.请参考 "filetype-indent-on" 和
" "indentexpr" 选项
filetype on
if has("eval") && v:version>=600
    filetype plugin on
    filetype indent on
endif
 
"设置当正在编辑的文件被外部的其它程序所修改后自动在Vim加载
if exists("&autoread")
    set autoread
endif
 
"可以为不同模式分别打开鼠标:
"   "n" 普通模式
"   "v" 可视模式
"   "i" 插入模式
"   "c" 命令行模式
"   "h" 编辑帮助文件时,所有前面的模式
"   "a" 所有前面的模式
"   "r" hit-enter 和 more-prompt 提示时
if exists("&mouse")
    set mouse=a
endif
 
"定义 "mapleader"变量
"要定义一个使用 "mapleader" 变量的映射,可以使用特殊字串
" "<Leader>".它会被 "mapleader" 的字符串所替代.如果
" "mapleader" 未设置或为空,则用反斜杠代替,例如:
"   ":map <Leader>A oanother line<Esc>"
"和下面一样:
"   :map \A oanother line<Esc>
"但是当:
"   :let mapleader = ","
"时,又相当于:
"   :map ,A oanother line<Esc>
"
"注意: "mapleader" 的值仅当定义映射时被使用.后来改变的
" "mapleader" 不会影响到已定义的映射
let mapleader = ","
let g:mapleader = ","
 
"设置快速保存
"
" "nmap"表示普通模式下的映射定义,
" ":map" 和 ":map!" 命令为多个模式定义和回显映射.在 Vim 中你可
"以使用 ":nmap", ":vmap", ":omap", ":cmap" 和 ":imap" 命令来对每
"个不同的模式分别定义映射.
"当列出映射时,前面两栏的字符表示 (可有多个):
"   字 符       模 式
"   "<Space>"   普通、可视、选择和操作符等待
"	"n"         普通
"	"v"         可视和选择
"	"s"         选择
"	"x"         可视
"	"o"         操作符等待
"	"!"         插入和命令行
"	"i"         插入
"   "l"         插入、命令行和 Lang-Arg 模式的 ":lmap" 映射
"	"c"         命令行
"
" ":xa!" 保存所有修改过的缓冲区,甚至包括只读的,但后退出Vim.不过,
"如果有无名或者其它元婴写入失败的缓冲区,Vim仍然不会退出.
"
" ":w!" 和 ":w" 类似,但即使 "readonly" 已置位或者有其他原因写入被拒
"绝,还是强制写入.
"注意:这可能会改变文件的权限和所有者,或者破坏(符号)连接.但在
" "cpoptions" 里加上 "W" 标志位可以避免这一点.
nmap <leader>x :xa!<cr>
nmap <leader>w :w!<cr>
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"打开语法高亮:
"   ":syntax enable"
"实际上,它只是执行如下命令:
"   ":source $VIMRUNTIME/syntax/syntax.vim"
"
" ":syntax enable" 命令会保持你当前的色彩设置.这样,不管在使用此
"命令的前后,你都可以用 ":highlight" 命令设置你喜欢的颜色.如果你
"希望Vim用缺省值覆盖你自己的,只要用:
"   ":syntax on"
if MySys()=="unix"
    if v:version<600
        if filereadable(expand("$VIM/syntax/syntax.vim"))
            syntax on
        endif
    else
        syntax on
    endif
else
    syntax on
endif
 
"国际化设置
" "multi_byte" 指韩国语和其他多字节语言支持
if has("multi_byte")
    " "fileencodings" 缺省为 "ucs-bom",这是一个字符编码的列表,开始
    "编辑已存在的文件时,参考此选项.如果文件被读入,Vim尝试使用本
    "列表第一个字符编码.如果检测到错误,使用列表的下一个.如果找
    "到一个能用的编码,设置 "fileencoding" 为该值.如果全部失败,
    " "fileencoding" 设为空字符串,这意味着使用 "encoding" 的值.
    "
    "警告:转换可能导致信息的丢失!如果 "encoding" 为 "utf-8" (或者某
    "个其它的Unicode变种),那么转换的结果通过逆转换很有可能产生
    "相同的文本.相反,如果 "encoding" 不是 "utf-8",一些非ASCII的字符
    "可能会丢失.
    set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
 
    " "v:lang" 运行环境当前的消息locale设置.它使得Vim脚本能得到当
    "前使用的语言.技术细节:这就是LC_MESSAGES的值.该值和系统有关.
    "
    " "=~" 为匹配正则表达式,详细介绍如下表:
    "               使用 "ignorecase"    匹配大小写	    忽略大小写 ~
    "等于                   "=="            "==#"		    "==?"
    "不等于                 "!="            "!=#"           "!=?"
    "大于                   ">"             ">#"            ">?"
    "大于等于               ">="            ">=#"           ">=?"
    "小于                   "<"             "<#"            "<?"
    "小于等于               "<="            "<=#"           "<=?"
    "匹配正规表达式         "=~"            "=~#"           "=~?"
    "不匹配正规表达式       "!~"            "!~#"           "!~?"
    "相同实例               "is"
    "不同实例               "isnot"
    "
    "设置CJK环境的编码选择
    if v:lang =~ "^zh_CN"
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=cp936
    elseif v:lang =~ "^zh_TW"
        set encoding=big5
		set termencoding=big5
		set fileencoding=big5
    elseif v:lang =~ "^ko"
		set encoding=euc-kr
		set termencoding=euc-kr
		set fileencoding=euc-kr
	elseif v:lang =~ "^ja_JP"
		set encoding=euc-jp
		set termencoding=euc-jp
		set fileencoding=euc-jp
	endif
 
	"在必要的时候,使用utf-8替代CJK的设置
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
		set encoding=utf-8
		set termencoding=utf-8
		set fileencoding=utf-8
	endif
endif
 
" "ambiwidth" 缺省为 "single"
"只有在 "encoding" 和 "utf-8" 或别的Unicode编码时才有效.告诉Vim怎
"么处理东亚二义性宽度字符类(East Asian Width Class Ambiguous)(例
"如欧元符号,注册记号,版权记号,希腊字母,西里尔字母等等)
"
"目前有两个可能的选择:
" "single": 使用和US-ASCII字符相同的宽度.多数用户希望如此.
" "double": 使用US-ASCII字符两倍的宽度
"
"在一些 CJK 字体里,这些字符的字形宽度完全由它们在传统的CJK编码
"里占据字节的数目决定.那些编码中,欧元,注册记号,希腊/西里尔字母
"等占据两个字节,因而它们在这些字体里用'宽'字形显示.这也包括文本
"文件里制表用的一些画线字符.因此如果GUI Vim使用CJK字体,或者在使
"用CJK字体的终端(模拟器)(包括带有 "-cjkwidth" 选项的xterm)里运
"行Vim,应把该选项设为 "double",这样可以匹配这些字体里Vim实际看
"到相关字形的宽度.在Windows 9x/ME 或 Windows 2k/XP 上,如果系统
"locale 为 CJK locale,也应把本选项设为 "double"
if exists("&ambiwidth")
    set ambiwidth=double
endif
 
" "guioptions" 选项只有在 Vim 的 GUI 版本才有效.它是字母的序
" 列,分别描述 GUI 应该使用的部件和选项.
" 建议使用 ":set" 的 "+=" 和 "-=" 特性,这可以避免未来版本增加
" 新的标志位时出现的问题.
 
"下面是合法的标志位字母:
"   "a" 自动选择: 如果存在,无论什么时候启动可视模式或者扩展可
"       视区域,Vim 都试图成为窗口系统全局选择区的拥有者.这意
"       味着可以粘贴高亮的可视文本到其它应用程序甚至 Vim 自身.
"       如果因为在文本之上进行了操作,或者应用程序需要粘贴选择
"       区等原因使得可视区域被终止,高亮文本会被自动抽出到 "*"
"       选择寄存器里.这样,即使在可视模式结束以后,选择区仍然可
"       以被粘贴到别的应用程序. 
"       如果不存在,Vim 不会成为窗口系统的全局选择区,除非使用
"       "*" 寄存器进行抽出和删除操作,这时该选择区被显式地占有.
"       同样适用无模式的选择.
"
"   "A" 自动选择无模式的选择.类似于 "a",但仅限于无模式的选择.
"       "guioptions"    自动选择可视    自动选择无模式
"           ""              --              --
"           "a"             是              是
"           "A"             --              是
"           "aA"            是              是
"
"   "c" 简单的选择使用控制台对话框而不是弹出式对话框.
"
"   "e" "showtabline" 要求时,加入标签页.
"       "guitablabel" 可用来改变标签文本.
"       如果没有 "e",可能使用非 GUI 标签页行.
"       只有一些系统支持 GUI 标签页,现在包括 GTK, Motif, 
"       Mac OS/X 和 MS-Windows.
"
"   "f" 前台: 不用 fork() 从启动外壳分叉出本 GUI 进程.用于
"       需要等待编辑器完成的程序 (例如,e-mail 程序).你也可
"       以用 "gvim -f" 或 ":gui -f" 来在前台启动 GUI.
"       注意: 在 vimrc 文件里设置本选项.读入 gvimrc 文件时
"       分叉操作可能已经发生.
"
"   "i" 使用 Vim 图标.GTK 和 KDE 上它出现在窗口的左上角.在
"       非 GTK 的环境上,因为 X11 的限制,它是黑白的.要得到
"       彩色图标,见 "X11-icon"
"
"   "m" 使用菜单栏
"
"   "M" 不执行系统菜单脚本 "$VIMRUNTIME/menu.vim".
"       注意:本标志位必须在	".vimrc" 文件里加入,在打开语法
"       或文件类型识别之前 (执行 "gvimrc" 文件时,系统菜单
"       已经载入;而 ":syntax on" 和 ":filetype on" 命令同
"       样会载入菜单).
"
"   "g" 灰色菜单项: 使得不活动的菜单项变灰.如果没有包含 "g",
"       不活动的菜单项完全不显示.
"       特例: Athena 总会使用灰色的菜单项.
"
"   "t" 包含可撕下的菜单项.目前只用于 Win32, GTK+ 和
"       Motif 1.2 GUI.
"
"   "T" 包含工具栏.目前只用于 Win32, GTK+, Motif, Photon
"       和 Athena GUI.
"
"   "r" 右边的滚动条总是存在.
"
"   "R" 如有垂直分割的窗口,右边的滚动条总是存在.
"
"   "l" 左边的滚动条总是存在.
"
"   "L" 如有垂直分割的窗口,左边的滚动条总是存在.
"
"   "b" 底部的 (水平) 滚动条总是存在.它的大小取决于最长的可
"       见行,或者如果包含 'h' 标志位的话,光标所在的行.详情
"       可见 "gui-horiz-scroll"
"
"   "h" 限制水平滚动条的大小为光标所在行的长度,以减少计算量.
"       是的,如果你真的想要,左右两边都可以有滚动条.详情可见
"       "gui-scrollbars"
"
"   "v" 对话框使用垂直的按钮布局.如果不包含,倾向使用水平布
"       局,但如果空间不够,还是用垂直的布局.
"
"   "p" 使用 X11 GUI 的指针回调.有些窗口管理器需要.如果光标
"       不闪烁或者在一定场合下变空,考虑增加此标志位.必须在
"       启动GUI 之前完成.在你的 "gvimrc" 里设置.在 GUI 启动
"       后增加或删除不会有任何效果.
"
"   "F" 增加信息页脚.只适用于 Motif.见 "gui-footer".
if has("gui_running")
    set guioptions-=m   " 关闭菜单栏
    set guioptions-=T   " 关闭工具栏
    set guioptions-=l   " 关闭左边滚动条
    set guioptions-=L   " 关闭垂直分隔窗口左边滚动条
    set guioptions-=r   " 关闭右边滚动条
    set guioptions-=R   " 关闭垂直分隔窗口右边滚动条
 
    if MySys()=="win32"
        " "autocmd" / "au" 定义自动命令
        "注意: ":autocmd" 命令不能有其他命令紧跟其后,因为"|"
        "命令是该命令的一个组成部分.
        "
        " ":au[tocmd] [group] {event} {pat} [nested] {cmd}"
        "把 {cmd} 加到 Vim 在匹配 {pat} 模式的文件执行 {event}
        "事件时自动执行的命令列表.Vim 把 {cmd} 加到已有的自动
        "命令之后,从而使自动命令的执行顺序与其定义的顺序相同.
        "关于 [nested],参见 "autocmd-nested".
 
        "注意 ":autocmd" 的参数里的特殊字符 (例如, "%", "<cword>")
        "在定义时不会被扩展,而是在事件发生并执行 {cmd} 的时候才
        "进行.唯一的例外是 "<sfile>" 在定义时扩展.
        "
        " "GUIEnter" 成功启动 GUI 并打开窗口后自动命令事件.用
        " gvim 的时候,它在 VimEnter 之前发生.在 .gvimrc 里可用
        " 它来定位窗口:
        "   ":autocmd GUIEnter * winpos 100 50"
        "
        " "si" / "simalt" 模拟 Alt-{key} 组合键.
        " ":si[malt] {key}"
        " {仅适用 Win32 版本}
        "
        "正常情况下,为了增加键映射 (map) 的数量,Vim 控制所有
        "Alt-{key} 组合键.但是这样做可能与用 Alt-{key} 访问菜单
        "的标准方法冲突.一个快速的解决办法是:设置 "winaltkeys"
        "选项的值为 "yes".但是这样阻止了所有与Alt 键有关的映射.
        "另一个办法是:设置 "winaltkeys" 选项为 "menu".这样与菜
        "单有关的快捷键有 Windows 管理,其余的与 Alt 相关的映射
        "仍然好用.但这样又产生了对当前状态的依赖性.
        "要解决这个问题,就要用 ":simalt" 命令告诉 Vim 
        "( "winaltkeys" 不要设置为 "yes") 虚拟一个 Windows 风
        "格的 Alt 按键行为.你可以用它来映射 Alt 组合键 (或者任
        "何其它键) 来产生标准的 Windows 操作.下面是一些例子:
        "   ":map <M-f> :simalt f<CR>"
        "这个命令通过把 Alt-F 映射为模拟按键的 Alt 和 F,使你按
        "下 Alt-F 时弹出 "文件" 菜单 (对于缺省的 Menu.vim 而言)
        "   ":map <M-Space> :simalt ~<CR>"
        "这个命令通过映射 Alt-Space 弹出 Vim 窗口的系统菜单.
        "注意: ~ 在 simalt 命令里代表 <Space> (空格).
        "   ":map <C-n> :simalt ~n<CR>"
        "把 CTRL-N 映射成 Alt-Space + N.也就是打开窗口的系统菜
        "单,然后按 N,最小化 Vim窗口
        "
        "这个选项是模拟弹出菜单中使用最大化的快捷键 "x"
        if has("autocmd")
            au GUIEnter * simalt ~x
        endif
    endif
 
    " "colorscheme" / "colo" 载入色彩方案
    " ":colo[rscheme] {name}"
    "载入色彩方案 {name}.
    "它会在 'runtimepath' 里搜索 "colors/{name}.vim",载入第一
    "个找到的文件.
	"要看到当前激活的色彩方案的名字 (如果有的话):
	"   ":echo g:colors_name"
    "它不能递归调用,所以你不能在色彩方案脚本里使用 ":colorscheme"
	"色彩方案载入后"激活 "ColorScheme" 自动命令事件.关于如何
    "编写色彩方案文件的信息: 
	"   ":edit $VIMRUNTIME/colors/README.txt"
    if v:version > 601
        colorscheme torte
    endif
else
    if v:version > 601
        colorscheme torte
    endif
endif
 
"当打开的文档中含有多种语言的时候,单一使用某一种文件类型的高亮
"方式必然会非常难看,比如说一个介绍J2EE的文件,里面必然有Java的代
"码,也会存在很多XML的代码,这个时候需要随时切换不同的高亮方案
map <Leader>1 :set syntax=java<CR>
map <Leader>2 :set syntax=c<CR>
map <Leader>3 :set syntax=xhtml<CR>
map <Leader>4 :set syntax=python<CR>
map <Leader>5 :set ft=javascript<CR>
map <Leader>0 :syntax sync fromstart<CR>
 
"用 "cursorline" 高亮光标所在的屏幕行.用于方便定位光标.屏幕刷新
"会变慢.
"激活可视模式时,为了容易看到选择的文本,不使用此高亮.
if has("gui_running")
    if exists("&cursorline")
        set cursorline
    endif
endif
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "fileformats" / "ffs"
"给出换行符(<EOL>)的格式,开始编辑新缓冲区或者读入文件到已有的缓
"冲区时,尝试这些格式:
"   -   如果为空,总是使用 "fileformat"定义的格式.不自动设置该选项.
"   -   如果设为一个名字,总是为打开的新缓冲区使用该格式,也为该缓
"       冲区相应地设置 "fileformat".文件读入已有的缓冲区时,使用
"       "fileformats" 给出的名字,不管该缓冲区设定的 "fileformat"
"       是什么.
"   -   如果给出多于一个以逗号分隔的名字,读入文件时会进行自动
"       <EOL>检测.
"       开始编辑文件时,这样检查 <EOL>:
"       1.  如果所有行都以 <CR><NL> 结尾,而 "fileformats" 包含
"           "dos" 的话, "fileformat" 设为 "dos".
"       2.  如果找到一个<NL>而 "fileformats" 包含 "unix"的话, 
"           "fileformat"设为 "unix".注意 如果找到的 <NL> 没有前
"           导 <CR>, "unix" 比 "dos" 优先.
"       3.  如果 "fileformats" 包含 "mac". "fileformat" 设为 "mac".
"           这意味着 "mac" 只有在没有给出 "unix" 或者在文件里没有
"           找到 <NL>,并且没有给出 "dos" 或者没有在文件里找到
"           <CR><NL> 时才会使用.如果先选择 "unix",但第一个 <CR> 出
"           现在第一个 <NL> 之前,而文件里的 <CR> 比 <NL> 多的话,
"           "fileformat" 也设为 "mac".
"       4.  如果还是不能设置 "fileformat",使用 "fileformats" 的第
"           一个名字.
"   读入文件到已有的缓冲区时,完成相同的步骤,但如同 "fileformat" 
"   已经为该文件合适地设置过,不改变该选项.
"如果置位 "binary",不使用 "fileformats" 的值.
"
" 对于使用 DOS 类型的 <EOL> (<CR><NL>) 的系统来说,读入待执行的脚本
"( ":source" ) 或者 vimrc 文件时,可能进行自动 <EOL> 的检测:
"   -   如果 "fileformats" 为空,没有自动检测.使用 DOS 格式.
"   -   如果 "fileformats" 设为一到多个名字,进行自动检测.它基于文
"       件中的第一个 <NL>: 如果在它之前有一个 <CR>,使用 DOS 格式,
"       不然,使用 Unix格式.
"   另见 |file-formats|.
"为了后向兼容: 如果设置此选项为空字符串或者单一格式 (没有包含逗号),
"复位 "textauto",否则置位 "textauto".
"注意: 如果置位 "compatible",本选项被设为 Vi 的缺省值.相反,如果复位
" "compatible",本选项被设为 Vim 的缺省值.
set fileformats=unix,dos,mac
 
"给出当前缓冲区的 <EOL> 格式,用于从文件读入缓冲区和把缓冲区写回文件:
"   "dos"       <CR> <NL>
"   "unix"      <NL>
"   "mac"       <CR>
"
"MS-DOS,MS-Windows,OS/2 的缺省: "dos",
"Unix 缺省: "unix",
"Macintosh 缺省: "mac"
"
"如果使用 "dos",文件尾的 CTRL-Z 被忽略.
"见 "file-formats" 和 "file-read|"
"文件使用的字符编码见 "fileencoding".
"如果设置 "binary",忽略 "fileformat" 的值.文件输入/输出如同它被设为
" "unix" 那样.
"文件开始编辑时,如果 'fileformats' 非空而 'binary' 关闭,本选项被
"自动设置.
"开始编辑文件后,如果设置该选项, "modified" 选项被置位,因为文件被认为
"和当初写入时已经不同.
"本选项在 "modifiable" 关闭时不能改变.
"
"为了后向兼容: 如果本选项设为 "dos",置位 "textmode",否则,复位之.
"
"这里的意思是定义快速转换文件格式的快捷键映射
nmap <leader>fd :set ff=dos<cr>
nmap <leader>fu :set ff=unix<cr>
nmap <leader>fm :set fm=unix<cr>
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "scrolloff" / "so"    (缺省为 0) 光标上下两侧最少保留的屏幕行数
"这使你工作时总有一些可见的上下文.我们这里设置的主要用处其实是
"可以用鼠标单击屏幕的前N行或者后N行来直接进行屏幕的上下滚动.对
"于习惯了鼠标操作的用户来说将会非常的方便.
"
"如果你设置此选项为很大的值 (比如 999),光标所在的行将总定位在
"窗口的中间位置 (除非你非常靠近文件开始或者结束的地方,或者有长
"行回绕).
"水平滚动见 'sidescrolloff'.
"注意: 如果置位 'compatible',该选项被设为 0.
set so=7
 
" "wildmenu" / "wmnu"   (缺省关闭) 命令行补全以增强模式运行 
" {仅当编译时加入 "+wildmenu" 特性才有效}
" "wildmenu" 打开时,命令行补全以增强模式运行,按下 "wildchar"
" (通常是 <Tab>) 启动补全.这时,在命令行的上方显示可能的匹配,
" 然后高亮首个匹配 (如果有状态行,覆盖之).显示前项/后项匹配的
" 热键,如 <Tab> 或 CTRL-P/CTRL-N,移动高亮到合适的匹配上.
"
" 使用 "wildmode" 时,指定 "full" 会启用 "wildmenu" 模式.
" "longest" 和 "list" 则不会启动 "wildmenu" 模式.
"
" 如果多个匹配超过一行,在右侧显示 ">" 和/或在左侧显示 "<".需
" 要的话,滚动状态行.
"按下不用于选择补全项的键时,放弃 "wildmenu" 模式.
"
" "wildmenu" 激活时,下面的键有特殊含义:
"   "<Left>" / "<Right>"    选择前项/后项匹配 (类似于 
"                           CTRL-P/CTRL-N)
"   "<Down>"                文件名/菜单名补全中: 移进子目录
"                           和子菜单.
"   "<CR>"                  菜单补全中,如果光标在句号之后:
"                           移进子菜单.
"   "<Up>"                  文件名/菜单名补全中: 上移到父目
"                           录或父菜单.
"
"这使得控制台上有菜单可用 "console-menus"
"如果你喜欢 <Left> 和 <Right> 键移动光标而不是选择不同的匹
"配,用: 
"   ":cnoremap <Left> <Space><BS><Left>"
"   ":cnoremap <Right> <Space><BS><Right>"
"
" "WildMenu" 高亮用于显示当前匹配 "hl-WildMenu".
set wildmenu
 
" "ruler" / "ru" (缺省关闭) 标尺
" {仅当编译时加入 "+cmdline_info" 特性才有效}
"显示光标位置的行号和列号,逗号分隔.如果还有空间,在最右端显
"示文本在文件中的相对位置:
"   "Top"   首行可见
"   "Bot"   末行可见
"   "All"   首末两行都可见
"   "45%"   文件中的相对位置
"如果设置 "rulerformat",它决定标尺的内容.
"每个窗口都有自己的标尺.如果窗口有状态行,标尺在那里显示.否
"则,它显示在屏幕的最后一行上.如果通过 "statusline" 给出状
"态行 (亦即,非空),该选项优先于 "ruler" 和 "rulerformat".
"如果显示的字符数不同于文本的字节数 (比如,TAB 或者多字节字
"符),同时显示文本列号 (字节数) 和屏幕列号,以连字符分隔.
"空行显示 "0-1"
"空缓冲区的行号也为零: "0,0-1"
"如果置位 "paste" 选项,本选项被复位.
"如果你不想一直看到标尺但想知道现在在哪里,使用 "g CTRL-G"
"注意: 如果置位 "compatible",该选项被复位
set ruler
 
" "cmdheight" / "ch" (缺省为 1)	命令行使用的屏幕行数
"有助于避免 "hit-enter" 提示.
"此选项值保存在每个标签页里,从而每个标签页可有不同的值.
set cmdheight=2
 
" ":nu" / ":number" 显示行号
" ":[range]nu[mber] [count] [flags]"
"和 ":print" 相同,但每行之前显示行号 (也参见 "highlight"
"和 "numberwidth" 选项).
set nu
 
" "lazyredraw" / "lz"   (缺省关闭)
"如果置位本选项,执行宏,寄存器和其它不通过输入的命令时屏
"幕不会重画.另外,窗口标题的刷新也被推迟.要强迫刷新,使用
" ":redraw".
set lz
 
" "hidden" / "hid"  (缺省关闭)
"如果关闭, "abandon" 放弃时卸载缓冲区.如果打开, "abandon"
"放弃时隐藏缓冲区.当然,如果缓冲区仍然在别的窗口里显示,
"它不会被隐藏.
"在缓冲区列表里移动的命令有时会隐藏缓冲区,即使关闭 "hidden"
"选项也是如此,条件是: 缓冲区被修改过, "autowrite" 关闭
"或者不能写入,并且使用 "!" 标志位.另见 "windows.txt".
"
"如果只想隐藏一个缓冲区,使用 "bufhidden" 选项.
" ":hide {command}" 为单个命令关闭本选项 ":hide".
"警告: 对隐藏缓冲区的修改很容易忘记. ":q!" 或 ":qa!" 时
"三思而后行!
set hid
 
" "backspace" / "bs" (缺省为 "")
"影响 <BS>,<Del>,CTRL-W 和 CTRL-U 在插入模式下的工作方
"式.它是逗号分隔的项目列表.每个项目允许一种退格删除的内
"容:
"   值	        效果
"   "indent"    允许在自动缩进上退格
"   "eol"       允许在换行符上退格 (连接行)
"   "start"     允许在插入开始的位置上退格;CTRL-W 和
"               CTRL-U 到达插入开始的位置时停留一次.
"
"如果该值为空,使用 Vi 兼容的退格方式.
"
"为了和 5.4 及更早的版本后向兼容:
"   值          效果
"   "0"         等同于 ":set backspace=" (Vi 兼容)
"   "1"         等同于 ":set backspace=indent,eol"
"   "2"         等同于 ":set backspace=indent,eol,start"
"
"如果你的 <BS> 或 <Del> 键不合你的期望,见 ":fixdel".
"注意: 如果置位 "compatible",该选项被设为 "".
set backspace=eol,start,indent
 
" "whichwrap" / "ww"    (Vim 缺省: "b,s",Vi 缺省: "")
"使指定的左右移动光标的键在行首或行尾可以移到前一行
"或者后一行.连接这些字符,可以让所有指定的键都有此功能:
"       字符    键          模式
"       "b"    <BS>         普通和可视
"       "s"    <Space>      普通和可视
"       "h"    "h"          普通和可视 (不建议)
"       "l"    "l"          普通和可视 (不建议)
"       "<"    <Left>       普通和可视
"       ">"    <Right>      普通和可视
"       "~"    "~"          普通
"       "["   <Left>        插入和替换
"       "]"    <Right>      插入和替换
"只允许光标键进行回绕.
"如果移动键和删除和改变操作符一起使用时,<EOL> 也被看作一个
"字符.这使得光标跨过行尾时, "3h" 和 "3dh" 效果不同."这也适
"用于 "x" 和 "X",因为它们分别和 "dl" 以及 "dh" 相同.如果这
"么用,你可能想用映射 ":map <BS> X"来使退格"键删除光标之前的
"字符.
"如果包含 'l',位于行尾时如果在操作符之后使用它,不会移动到下
"一行.这样 "dl", "cl", "yl" 等都能正常工作.
"注意: 如果置位 "compatible",本选项被设为 Vi 的缺省值.相反,
"如果复位 "compatible",本选项被设为 Vim 的缺省值.
set whichwrap+=<,>,h,l
 
" "incsearch" / "is"    (缺省关闭) 
"{仅当编译时加入 "+extra_search" 特性才有效}
"输入搜索命令时,显示目前输入的模式的匹配位置.
"匹配的字符串被高亮.如果该模式不合法或者没有匹配,不显示任何
"东西.屏幕会经常刷新,所以只有对快速终端,这才有意义.
"注意:会显示匹配,但如果找不到匹配和按 <Esc> 的时候,光标会回
"到原来的位置.你仍然需要用 <Enter> 完成搜索命令才会移动光标
"到匹配位置.
"编译时加入 "+reltime" 特性时,Vim 只会搜索大概半秒钟.如果模
"式太过复杂和/或有很多文本存在,不一定能找到匹配.这是为了避免
"Vim 在输入模式的时候挂起.
"
"可以用 "highlight" 的 "i" 标志位设置高亮.另见: "hlsearch".
"   "CTRL-L" 可用来在命令行上给当前匹配之后增加一个字符.
"   "CTRL-R" / "CTRL-W" 可用来在当前匹配的尾部增加单词,排除
"                       已经输入的部分.
"注意: 如果置位 "compatible",该选项被复位.
set incsearch
 
"某些字符在模式中是按本义出现的.它们匹配自身.然而,当前面有一
"个反斜杠时,这些字符具有特殊的含义.
"
"另外一些字符即使没有反斜杠也代表特殊的意思,它们反而需要一个
"反斜杠来匹配按本义出现的自身.
"
"一个字符是否按本义出现取决于 "magic" 选项以及下面将解释的条
"目.
"使用 "\m" 会使得其后的模式的解释方式就如同设定了 "magic" 选
"项一样.而且将忽略 "magic" 选项的实际值.
"使用 "\M" 会使得其后的模式的解释方式就如同设定了 "nomagic"
"选项一样.
"
"使用 "\v" 会使得其后的模式中所有 '0'-'9','a'-'z','A'-'Z'
"和 '_' 之外的字符都当作特殊字符解释.
"使用 "\V" 会使得其后的模式中只有反斜杠有特殊的意义.
"
"示例:
"在这之后:  \v      \m      \M      \V      匹配
"                 'magic' 'nomagic'
"           $       $       $       \$      匹配行尾
"           .       .       \.      \.      匹配任何字符
"           *       *       \*      \*      前面匹配原的任意次重复
"           ()      \(\)    \(\)    \(\)    组成为单个匹配原
"           |       \|      \|      \|      分隔可选分支
"           \a      \a      \a      \a      字母字符
"           \\      \\      \\      \\      反斜杠 (按本义)
"           \.      \.      .       .       英文句号 (按本义)
"           \{      {       {       {       '{' (按本义)
"           a       a       a       a       'a' (按本义)
"
"{仅 Vim 支持 \m,\M,\v 和 \V}
"
"建议始终将 "magic"选项保持在缺省值 - "magic".这可以避免移
"植性的麻烦.要使模式不受该选项值的影响,在模式前面加上 "\m"
"或 "\M".
set magic
 
"设置Vim静音
" "errorbells" / "eb" (缺省关闭)
"错误信息响铃 (鸣叫或屏幕闪烁).只有对错误信息有意义.很多没有消息的错误
"也会使用该响铃 (比如,普通模式里按 <Esc>).
"
" "visualbell" / "vb" (缺省关闭)
"使用可视响铃代替鸣叫.显示可视响铃的终端代码由 "t_vb" 给出.如果既不想
"要响铃也不想要闪烁,使用 ":set vb t_vb=".
"注意: GUI 启动时,'t_vb' 复位为缺省值.你可能想在 |gvimrc| 里再次设置之.
"在 GUI 里, "t_vb" 缺省为 "<Esc>|f",反转显示 20 毫秒.如果你想使用别的
"时间,可设 "<Esc>|40f",其中 40 是毫秒计的时间.
"在 Amiga 上没有用,你总会得到屏幕闪烁.
set noerrorbells
set novisualbell
set t_vb=
 
" "showmatch" / "sm"    (缺省关闭)
"插入括号时,短暂地跳转到匹配的对应括号.只有在屏幕上能看到匹配时才会进
"行跳转.显示匹配的时间用 "matchtime" 设置.
"如果没有匹配会响铃 (和匹配能否看到无关).置位 "paste" 时,复位本选项.
"如果 "cpoptions" 里没有 "m" 标志位,接着输入字符会立即把光标移动到它应
"该在的位置.
" "guicursor" 的 "sm" 域说明显示匹配时,如何设置光标形状和闪烁.
" "matchpairs" 选项可指定显示匹配所用的字符.用 "rightleft" 和 "revins"
"查找反方向的匹配.
"移动时要高亮匹配,另见 matchparen 插件 "pi_paren.txt".
set showmatch
 
" "matchtime" / "mat"   (缺省为 5)
"如果置位 'showmatch',显示配对括号的十分之一秒数.
"注意 这不是毫秒数.
set mat=4
 
" "hlsearch" / "hls"    (缺省关闭)
"{仅当编译时加入 "+extra_search" 特性才有效}
"如果有上一个搜索模式,高亮它的所有匹配.使用高亮的类型可以用 "highlight"
"选项的 "l" 位设置.缺省,使用 "Search" 高亮组.
"注意: 只有匹配的文本被高亮,位移此处不予考虑.
"另见: "incsearch" 和 ":match".
"
"如果你厌倦总是看到高亮匹配,用 ":nohlsearch" 或者 ":noh" 可以暂时关闭.
"一旦使用搜索命令,高亮会重新出现.
"
" "redrawtime" 指定寻找匹配会花费的最大时间.
"如果搜索模式可以匹配换行符,Vim 会试图高亮所有的匹配文本.不过,这依赖
"于搜索从哪里开始.如果是窗口的第一行,或者关闭折叠之下的第一行,那么从
"它们不会显示的上一行开始的匹配不会在新显示的行上继续.
"注意: 如果置位 "compatible",该选项被复位.
set hlsearch
 
""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"格式化状态栏
if performance_mode
else
    " "laststatus" / "ls" (缺省为 1)
	"本选项的值影响最后一个窗口何时有状态行:
	"   "0" 永不
	"   "1" 只有在有至少两个窗口时
	"   "2" 总是
	"如果你有多个窗口,有状态行会使屏幕看起来好一些,但它会占据一个屏幕行.
    set laststatus=2
 
    " "statusline" / "stl"  (缺省为空)
    "{仅当编译时加入 "+statusline" 特性才有效}"
    "如果非空,本选项决定状态行的内容.另见 "status-line"
    "
    "此选项包含 printf 风格的 '%' 项目,中间可以间杂普通文本.每个状态行项
    "目有如下形式:
    "   "%-0{minwid}.{maxwid}{item}"
    "除了 {item} 以外,每个字段都是可选的.单个百分号可以用 "%%" 给出.最多
    "可给出 80 个项目.
    "
    "如果此选项以 "%!" 开始,它用作表达式.计算此表达式的结果用作选项值.例
    "如:
    "   ":set statusline=%!MyStatusLine()"
    "返回值可以包含 %{} 项目,它还会被继续计算下去.
    "
    "如果计算选项时有错误,会把它清空以防将来继续出错.否则屏幕更新会陷入循
	"环.
    "
    "注意 如果设置本选项 (并且 "laststatus" 为 2 的话), "ruler" 的唯一效
    "果是控制 "CTRL-G" 的输出.
    "
    "   域          含义
    "   "-"	        左对齐项目.如果 minwid 大于项目的长度,缺省是右对齐.
    "   "0"         数值项目前面用零填补. '-' 更优先.
    "   "minwid"    项目的最小宽度,以 '-' 和 '0' 补空.该值不能超过 50.
    "   "maxwid"    项目的最大宽度.如果超过,在文本项目的左侧截短,以'<'代
    "               替.数值项目则往下移到 maxwid-2 个数位,然后跟 '>'number,
    "               其中的 number 是丢失的数位,这非常类似于指数记法.
    "   "item"      单个字符的代码,下面给出描述.
    "
    "下面是可能状态行项目的描述.其中,"项目" 的第二个字符代表类型:
    "   "N" 代表数值型
    "   "S" 代表字符串型
    "   "F" 代表下面描述的标志位
    "   "-" 不适用
    "
    "项目   含义
    "f S    缓冲区的文件路径,保持输入的形式或相对于当前目录.
    "F S    缓冲区的文件完整路径.
    "t S    缓冲区的文件的文件名 (尾部).
    "m F    修改标志位,文本是 "[+]";若 "modifiable" 关闭则是 "[-]".
    "M F    修改标志位,文本是 ",+" 或 ",-".
    "r F    只读标志位,文本是 "[RO]".
    "R F    只读标志位,文本是 ",RO".
    "h F    帮助缓冲区标志位,文本是 "[help]".
    "H F    帮助缓冲区标志位,文本是 ",HLP".
    "w F    预览窗口标志位,文本是 "[Preview]".
    "W F    预览窗口标志位,文本是 ",PRV".
    "y F    缓冲区的文件类型,如 "[vim]".见 "filetype".
    "Y F    缓冲区的文件类型,如 ",VIM".见 "filetype'".
    "       {仅当编译时加入 "+autocmd" 特性才有效}
    "k S    "b:keymap_name" 的值或使用 ":lmap" 映射时的 "keymap":
    "       "<keymap>".
    "n N    缓冲区号.
    "b N    光标所在字节的值.
    "B N    同上,以十六进制表示.
    "o N    光标所在字节在文件中的字节偏移,第一个字节为 1.
    "       助记: 从文件开始的偏移 (Offset) (加上 1)
    "       {仅当编译时加入 "+byte_offset" 特性才有效}
    "O N    同上,以十六进制表示.
    "N N    打印机页号.(只用于 'printheader" 选项.)
    "l N    行号.
    "L N    缓冲区里的行数.
    "c N    列号.
    "v N    虚拟列号.
    "V N    虚拟列号,表示为 -{num}.如果等于 "c" 的值,不显示.
    "p N    行数计算在文件位置的百分比,如同 "CTRL-G" 给出的那样.
    "P S    显示窗口在文件位置的百分比,类似于 "ruler" 描述的百分比.长度
    "       总是为 3.
    "a S    参数列表状态,就像缺省标题里的那样.({current} of {max})
    "       如果参数列表里的文件数为零或一,空字符串.
    "{ NF   计算 "%{" 和 "}" 之间的表达式,并返回其结果替代.注意 结束的
    "       "}" 之前没有 "%".
    "( -    项目组的开始.可以用来为某组项目设置宽度和对齐.后面某处必须有
    "       "%)".
    ") -    项目组的结束.不能指定宽度域.
    "T N    用于 'tabline': 标签页 N 标签的开始.最后一个标签之后用 "%T".
    "       鼠标点击时用此信息.
    "X N    用于 "tabline": 关闭标签页 N 标签的开始.最后一个标签之后用
    "       "%T".
    "       例如: "%3Xclose%X",用 "%999X" 来代表 "关闭当前标签页" 那个符
    "       号.鼠标点击时用此信息.
    "< -    如果行过长,在什么地方截短.缺省是在开头.不能指定宽度域.
    "= -    左对齐和右对齐项目之间的分割点.不能指定宽度域.
    "# -    设置高亮组.必须后面跟名字,然后又是 "#".这样, "%#HLname#" 代
    "       表高亮组 HLname.包括非当前窗口的状态行都使用相同的高亮组.
    "* -    设置高亮组为 User{N},其中的 {N} 取自 minwid 域,比如 %1*.用
    "       %* 或者 %*0 可以恢复 normal 高亮.User{N} 和 StatusLine 的区
    "       别也会应用到非当前窗口的状态行使用的 StatusLineNC 上.
    "       数字 N 必须从 1 到 9.见 "hl-User1..9"
    "
    "显示标志位时,如果它紧跟在普通文本之后,Vim 删除之前的前导逗号.这使得
    "下面例子里使用的标志位显示看起来很舒服.
    "
    "如果组内的所有项目都是空字符串 (比如,标志位没有设置) 而该组没有设置
    "minwid,整个组成为空字符串.这使得下面这样的组完全从状态行上消失,如果
    "没有标志位被置位的话.
    "   ":set statusline=...%(\ [%M%R%H]%)..."
    "要小心,每次显示状态行时都要计算此表达式.当前缓冲区和当前窗口会临时设
    "为目前要显示的状态行所属的窗口 (缓冲区),而表达式会使用此上下文计算.
    "变量 "actual_curbuf" 被设为实际的当前缓冲区的 "bufnr()" 号.
    "
    "可能在沙盘 "sandbox" 里计算 "statusline" 选项.见 "sandbox-option".
    "
    "计算 "statusline" 时不允许修改文本或者跳到其它窗口 "textlock".
    "
    "如果状态行在你希望时没有更新 (如在设置完表达式里使用的某变量之后),设
    "置选项可以强制进行更新而无须更改其值.例如: 
    "   ":let &ro = &ro"
    "
    "如果结果全是数字,用作显示时把它作为数值处理.否则结果作为文本,并应用
    "上面描述的规则.
    "
    "小心表达式里的错误.它们可能使 Vim 不可用！
    "如果你被困住,按住 ':' 或 'Q' 来得到提示,然后退出并用 "vim -u NONE"
    "来编辑 .vimrc 或者别的什么地方,以修正问题.
    "
    "示例:
    "模拟 "ruler" 设置的标准状态行
    "   ":set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P"
    "类似,但加上光标所在字符的 ASCII 值 (类似于 "ga")
    "   ":set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P"
    "显示字节偏移和字节值,用红色标记已修改标志位. 
    "   ":set statusline=%<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)%O'%02b'"
    "   ":hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red"
    "如果载入的是压缩文件,显示 ,GZ 标志
    "   ":set statusline=...%r%{VarExists('b:gzflag','\ [GZ]')}%h..."
    "并在 |:autocmd| 里:
    "   ":let b:gzflag = 1"
    "或:
    "   ":unlet b:gzflag"
    "还要定义此函数:
    "   ":function VarExists(var, val)"
    "   ":    if exists(a:var) | return a:val | else | return '' | endif"
    "   ":endfunction"
    set statusline=
    set statusline+=%2*%-3.3n%0*\   "缓冲器名
    set statusline+=%f\             "文件名
    set statusline+=%h%1*%m%r%w%0*  "标记符
    set statusline+=[
    if v:version >= 600
        set statusline+=%{strlen(&ft)?&ft:'none'},  "文件类型
        set statusline+=%{&encoding},               "编码类型
    endif
    set statusline+=%{&fileformat}]                 "文件格式
    if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
        set statusline+=\ %{VimBuddy()}             "添加VimBuddy插件
        "这个插件会在状态栏上加一个笑脸,鼻子会随着光标移动而改变
    endif
    set statusline+=%=                              "左右对齐的分割点
    set statusline+=%F\                             "文件的完整路径
    set statusline+=%2*0x%-8B\                      "16进制表示当前字符
    set statusline+=%-14.(%l,%c%V%)\ %<%P           "偏移量
 
    " special statusbar for special windows
    if has("autocmd")
        au FileType qf
                    \ if &buftype == "quickfix" |
                    \ setlocal statusline=%2*%-3.3n%0* |
                    \ setlocal statusline+=\ \[Compiler\ Messages\] |
                    \ setlocal statusline+=%=%2*\ %<%P |
                    \ endif
 
        fun! FixMiniBufExplorerTitle()
            if "-MiniBufExplorer-" == bufname("%")
                setlocal statusline=%2*%-3.3n%0*
                setlocal statusline+=\[Buffers\]
                setlocal statusline+=%=%2*\ %<%P
            endif
        endfun
 
        if v:version>=600
            au BufWinEnter *
                        \ let oldwinnr=winnr() |
                        \ windo call FixMiniBufExplorerTitle() |
                        \ exec oldwinnr . " wincmd w"
        endif
    endif
 
    " "titlestring" (缺省为 "") 设置窗口标题栏
    "{仅当编译时加入 "+title" 特性才有效}
    "如果此选项不为空,用来设置窗口的标题.只有在 "title" 选项打开时才会发
    "生.
    "只有终端支持设置窗口标题时才可用 (目前有 Amiga 控制台,Win32 控制台,
    "所有的 GUI 版本和带有非空的 "t_ts" 选项的终端).
    "如果 Vim 编译时定义 HAVE_X11,在可能的情况下恢复原来的标题 "X11".
    "如果本选项包含 printf 风格的 "%" 项目，依照 "statusline" 使用的规则
    "进行扩展.
    "例如:
    "   ":auto BufEnter * let &titlestring = hostname() . "/" . expand("%:p")"
    "   ":set title titlestring=%<%F%=%l/%L-%P titlelen=70"
    " "titlelen" 的值用来在可用空间的中间或右侧对齐项目.
    "有的人喜欢文件名放在前面:
    " ":set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)"
    "注意 "%{ }" 的使用,以及用于得到不含文件名的文件名路径的表达式.只有在
    "必要时, "%( %)" 构造才会加入分隔的空格.
    "注意: "titlestring" 使用特殊字符可能会使显示引起混乱 (比如,如果它包含
    "CR 或者 NL 字符的话).
    "{仅当编译时加入 "+statusline" 特性才有效}
    if has('title') && (has('gui_running') || &title)
        set titlestring=
        set titlestring+=%f\                "文件名
        set titlestring+=%h%m%r%w           "标记符
        set titlestring+=\ -\ %{v:progname} "程序名
    endif
endif
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to /
map <space> /
 
"为窗口跳转重新定义键映射
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
 
 
"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
 
if v:version>=700
    set switchbuf=usetab
endif
 
if exists("&showtabline")
    set stal=2
endif
 
"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommand
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>
 
"Map auto complete of (, ", ', [
"http://www.vim.org/tips/tip.php?tip_id=153
"
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrev
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Comment for C like language
if has("autocmd")
    au BufNewFile,BufRead *.js,*.htc,*.c,*.tmpl,*.css ino $c /**<cr> **/<esc>O
endif
 
"My information
ia xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"iab xname Amir Salihefendic
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^
 
"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
 
if MySys() == "mac"
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
"map <c-q> :sb
 
"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>
 
"Restore cursor to file position in previous editing session
set viminfo='10,"100,:20,%,n~/.viminfo
 
"用 "rot13" 编码整个文件
" "gg" 到文件首行首字符, "V" 进入Visual-Line模式, "G"到文件末行首字符,
"这样就选中了整篇文章,然后 "g?" 就是用 "rot13" 编码整个文件
"
"关于 "rot13":
" "ROT13" 是一种简单的编码,它把字母分成前后两组,每组13个,编码和译码的
" 算法相同,仅仅交换字母的这两个部分,即:
"   [a..m] --> [n..z] 和 [n..z] --> [a..m]
" "ROT13" 用简易的手段使得信件不能直接被识别和阅读,也不会被搜索匹配程
" 序用通常的方法直接找到.经常用于 USENET 中发表一些攻击性或令人不快的
" 言论或有简单保密需要的文章.
" 由于 "ROT13" 是自逆算法,所以,译码和编码是同一个过程.
map <F9> ggVGg?
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "backup" / "bk"   (缺省关闭)  覆盖文件前创建一个备份.
"文件成功写入后保留该备份.如果你不想保留备份文件,但希望写入期间能有备
"份,复位该选项并置位 "writebackup" 选项(这是缺省行为).如果你完全不想
"要备份文件,同时复位两个选项 (如果你的文件系统差不多满了,这会有用).更
"多的解释可见 "backup-table".
"如果匹配 "backupskip" 模式,无论如何都不会建立备份.
"如果设置 "patchmode",备份文件会换名成为文件的旧版本.
"注意: 如果置位 "compatible",该选项被复位.
"
" "writebackup" / "wb" (有 "+writebackup" 特性时缺省打开,否则缺省关闭)
"覆盖文件前建立备份.文件成功写入后,除非 "backup" 选项也被打开,删除该备
"份.如果你的文件系统几乎已满,复位此选项. "backup-table" 还有相关的解释.
"如果 "backupskip" 模式匹配,无论如何都不会建立备份.
"注意: 如果置位 "compatible", 该选项被设为缺省值.
set nobackup
set nowritebackup
 
" "swapfile" / "swf"    (缺省打开)
"缓冲区使用交换文件.如果不想为特定缓冲区使用交换文件,可以复位本选项.
"例如,包含即使 root 也不应得到的机密信息.要小心: 所有的文本都在内存:
"   - 不要在大文件里使用.
"   - 无法恢复!
"交换文件只有在 "updatecount" 不为零并且置位 "swapfile" 时才会存在.
"复位 "swapfile" 时,立即删除当前缓冲区的交换文件.如果置位 "swapfile"
"并且 "updatecount" 非零,立即建立交换文件.
"另见 "swap-file"和 "swapsync".
"
"此选项可以和 "bufhidden" 和 "buftype" 一起使用,指定特殊类型的缓冲区.
"见 "special-buffers"
set noswapfile
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "foldenable" / "fen"  (缺省打开)
"{仅当编译时加入 "+folding" 特性才有效}
"如果关闭,所有的折叠都被打开.本选项用于在文本显示的完全打开折叠和保留
"折叠之间 (包括手动打开或关闭的折叠) 快速切换."zi" 命令切换本选项.
"如果 "foldenable" 关闭, "foldcolumn" 会保持空白.
"建立新折叠或者关闭折叠的命令置位本选项.见 "folding".
"
"折叠方法
"可用选项 "foldmethod" 来设定折叠方法.
"设置选项 "foldmethod" 为非 "manual" 的其它值时,所有的折叠都会被删除并
"且创建新的.如果设置成 "manual",将不去除已有的折叠.可以利用这一点来先
"自动定义折叠,然后手工调整.
"
"有 6 种方法来选定折叠:
"   "manual"    手工定义折叠
"   "indent"    更多的缩进表示更高级别的折叠
"   "expr"      用表达式来定义折叠
"   "syntax"    用语法高亮来定义折叠
"   "diff"      对没有更改的文本进行折叠
"   "marker"    对文中的标志折叠
"
"选取了折叠方式后,我们就可以对某些代码实施我们需要的折叠了,由于我使用
" "indent" 稍微多一些,故以它的使用为例:
"如果使用了 "indent"方式,vim会自动的对大括号的中间部分进行折叠,我们可
"以直接使用这些现成的折叠成果.
"在可折叠处(大括号中间):
"   "zc"    折叠
"   "zC"    对所在范围内所有嵌套的折叠点进行折叠
"   "zo"    展开折叠
"   "zO"    对所在范围内所有嵌套的折叠点展开
"   "[z"    到当前打开的折叠的开始处
"   "]z"    到当前打开的折叠的末尾处
"   "zj"    向下移动.到达下一个折叠的开始处.关闭的折叠也被计入.
"   "zk"    向上移动到前一折叠的结束处.关闭的折叠也被计入."
if exists("&foldenable")
    set fen
    "set foldmethod=indent
endif
 
" "foldlevel" / "fdl"   (缺省: 0)   设置代码折叠级别
"{仅当编译时加入 "+folding" 特性才有效}
"设置折叠级别: 高于此级别的折叠会被关闭.
"设置此选项为零关闭所有的折叠.更高的数字关闭更少的折叠.
" "zm", "zM" 和 "zR" 等命令设置此选项.
"见 "fold-foldlevel".
if exists("&foldlevel")
    set fdl=0
endif
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text option
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "expandtab" / "et"    (缺省关闭)
"插入模式里: 插入 <Tab> 时使用合适数量的空格.如果 "autoindent" 打开,
" ">" 和 "<" 命令使用空格进行缩进. "expandtab" 打开时,要插入实际的制
"表,可用 CTRL-V<Tab>.另见 ":retab" 和 "ins-expandtab".
"注意: 如果置位 "compatible",该选项被复位.
set expandtab
 
" "shiftwidth" / "sw"   (缺省为 8)
"(自动) 缩进每一步使用的空白数目.用于 "cindent", ">>", "<<" 等.
set shiftwidth=4
 
" "softtabstop" / "sts" (缺省为 0)
"执行编辑操作,如插入 <Tab> 或者使用 <BS> 时,把 <Tab> 算作空格的数目.
"感觉上,你就像使用单个 <Tab> 一样,而实际上使用的是空格和 <Tab> 的混
"合.这可以用来维持 "ts" 的设置为标准值 8 不变,但编辑时感觉就像它被设
"为 "sts" 那样.不过, "x" 这样的命令仍然会在实际的字符上操作.
"如果 "sts" 为零,关闭此特性.
"
"如果置位 "paste" 选项, "softtabstop" 被设为 0.
"另见 "ins-expandtab". 如果没有置位 "expandtab",通过使用 <Tab>,使空
"格数目减到最小.
" "cpoptions" 里的 "L" 标志位改变制表在 "list" 置位时的使用方式.
"注意: 如果置位 "compatible",该选项被设为 0.
set softtabstop=4
 
" "tabstop" / "ts"  (缺省为 8)
"文件里的 <Tab> 代表的空格数.另见 ":retab" 命令和 "softtabstop" 选项.
"
"注意: 设置 "tabstop" 为不同于 8 的值可能使你的文件在很多地方看起来不
"正确 (比如，打印时).
"
"Vim 里有四个主要的使用制表的方法:
"1. 总是保持 "tabstop" 为 8,设置 "softtabstop" 和 "shiftwidth" 为 4
"   (或 3 或任何你想要的) 然后用 "noexpandtab".这时,Vim 使用制表和空
"   格的混合,但输入 <Tab> 或 <BS> 键就像每个制表占用 4 (或 3) 个字符
"   一样.
"2. 设置 "tabstop" 和 "shiftwidth" 为想要的任何值,然后用 "expandtab".
"   这样,你总是插入空格.改变 "tabstop" 时绝不会影响排版.
"3. 设置 "tabstop" 和 "shiftwidth" 为想要的任何值,然后用 "modeline",
"   再次编辑时就会重新设置这些值.这只适用于总是使用 Vim 进行文件编辑
"   的情况.
"4. 永远把 "tabstop" 和 "shiftwidth" 设为相同的值,并用 "noexpandtab".
"   这样,就可以 (只适用于行首的缩进) 使用任何别人的制表位设置.不过,
"   如果你这么做,最好在第一个非空白字符之后想插入制表时以空格代替.否
"   则,改变 "tabstop" 时,注释等的对齐会不正确.
set tabstop=4
 
" "smarttab" / "sta"    (缺省关闭)
"如果打开,行首的 <Tab> 根据 "shiftwidth" 插入空白. "tabstop" 或 
" "softtabstop" 用在别的地方.<BS> 删除行首 "shiftwidth" 那么多的空白.
" 如果关闭,<Tab> 总是根据 "tabstop" 或 "softtabstop" 决定插入空白的数\
" 目. "shiftwidth" 只用于文本左移或右移 "shift-left-right".
" 插入空白的具体方式 (制表还是空格) 取决于 "expandtab" 选项.另见
" "ins-expandtab".如果没有置位 "expandtab",通过使用 <Tab>,使空格数目
" 减到最小.
" 注意: 如果置位 "compatible",该选项被复位.
set smarttab
 
" "linebreak" / "lbr"   (缺省关闭)
"{仅当编译时加入 "+linebreak" 特性才有效}
"如果打开,Vim 会在 "breakat" 里的字符上,而不是在屏幕上可以显示的最后
"一个字符上回绕长行.和 "wrapmargin" 和 "textwidth" 不同,此处不会插入
"<EOL>,它只影响文件的显示方式,而不是其内容. "showbreak" 的值会出现在
"回绕行的前面.
"
"如果 "wrap" 选项关闭或 "list" 打开,不使用本选项.
"注意 <EOL> (屏幕上的) 之后的 <Tab> 字符在多数情况下.不会显示正确数量
"的空格.
set lbr
 
""""""""""""""""""""""""""""""
" => Indent
""""""""""""""""""""""""""""""
" "autoindent" / "ai" (缺省关闭) 启用自动缩进
"开启新行时 (插入模式下输入 <CR>,或者使用 "o" 或 "O" 命令),从当前行复
"制缩进距离.如果你在新行除了 <BS> 或 CTRL-D 以外不输入任何东西,然后输
"入 <Esc>,CTRL-O 或 <CR>,缩进又被删除.移动光标到其它行也有同样的效果,
"除非 "cpoptions" 里包含 'I' 标志位.
"如果打开自动缩进,排版 (用 "gq" 命令或者插入模式下到达了 "textwidth")
"使用第一行的缩进距离.
"打开 "smartindent" 或 "cindent" 时,缩进的修改方式有所不同.
"置位 "paste" 选项时, "autoindent" 选项被复位.
"{Vi 稍有不同: Vim 里输入 <Esc> 或 <CR> 删除缩进后,上下移动把光标放在
"删除的缩进之后;Vi 则把光标放在已删除的缩进的某处}.
set autoindent
 
" "smartindent" / "si"  (缺省关闭)  开启新行的自动缩进
"{仅当编译时加入 "+smartindent" 特性才有效}
"开启新行时使用智能自动缩进.适用于 C 这样的程序,但或许也能用于其它语
"言. "cindent" 类似,它多数情况下更好,但更严格,见 "C-indenting".如果
"打开 "cindent", 置位 "si" 没有效果.
" "indentexpr" 是更高级的替代方案.
"通常,使用 "smartindent" 时也应该打开 "autoindent".
"
"在这些情况下自动插入缩进:
"   - "{"           结束的行后.
"   - "cinwords"    中的某个关键字开始的行后.
"   - "}"           开始的行前 (只有使用 "O" 命令才会).
"在新行第一个输入的字符如果是 "}",该行使用匹配的 "{" 相同的缩进.
"在新行第一个输入的字符如果是 "#",该行的缩进被删除, "#" 被放到第一列.
"下一行上,恢复原来缩进.如果你不想这么做,使用下面的映射:
"   ":inoremap # X^H#"
"其中的 ^H 用 CTRL-V CTRL-H 输入.
"使用 ">>" 命令时,'#' 开始的行不右移.
"注意: 如果置位 "compatible",复位 "smartindent".如果置位 "paste",关
"闭这里的智能缩进功能.
set si
 
" "cindent" / "cin" (缺省关闭) 打开自动 C 程序的缩进
"{仅当编译时加入 "+cindent" 特性才有效}
" "cinkeys" 说明如何设置插入模式下启动重新缩进的热键, "cinoptions"
"说明如何设置你喜欢的缩进风格.
"如果 "indentexpr" 非空,它否决 "cindent" 的设置.
"如果没有打开 "lisp",而 "indentexpr" 和 "equalprg" 都为空, "=" 操作
"符使用本算法缩进,而不调用外部程序.
"见 "C-indenting".
"
"如果你不喜欢 'cindent' 的工作方式,可以试试 "smartindent" 选项或者
" "indentexpr".
" 如果置位 "paste",不使用本选项.
" 注意: 如果置位 "compatible",本选项被复位.
if has("cindent")
    set cindent
endif
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]
map <leader>sp [
map <leader>sa zg
map <leader>s? z=
 
 
""""""""""""""""""""""""""""""
" => VIM
""""""""""""""""""""""""""""""
if has("autocmd") && v:version>600
    au BufRead,BufNew *.vim map <buffer> <leader><space> :w!<cr>:source %<cr>
endif
 
""""""""""""""""""""""""""""""
" => HTML related
""""""""""""""""""""""""""""""
" HTML entities - used by xml edit plugin
let xml_use_xhtml = 1
"let xml_no_auto_nesting = 1
 
"To HTML
let html_use_css = 0
let html_number_lines = 0
let use_xhtml = 1
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Windows系统的换行符为\r\n,而Linux/Unix系统则为\n.因此,在Windows里编辑
"过的文本文件到了Linux/Unix里,每一行都会多出一个^M.
"命令中的 "^M" 是通过键入 <ctrl-v><enter> 或 <ctrl-v><ctrl-m> 生成的.
"可以在用以下命令清除该字符:
noremap <leader>m :%s/\r//g<CR>
 
"设置 'omnifunc' 选项。如：
if has("autocmd")
    au Filetype java setlocal omnifunc=javacomplete#Complete
endif
 
"进行Tlist的设置
"TlistUpdate可以更新tags
map <F3> :silent! Tlist<CR>
let Tlist_Ctags_Cmd='E:\develop\ctags\ctags.exe'
let Tlist_Use_Right_Window=1
let Tlist_Show_One_File=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Process_File_Always=1
let Tlist_Inc_Winwidth=0
let g:showfuncctagsbin = 'E:\develop\ctags\ctags.exe'
 
"进行NerdTree的设置
map <F4> :silent! NERDTree<CR>
 
 
"Paste toggle - when pasting something in, don't indent.
"set pastetoggle=<F3>
 
"移除空行的缩进
map <F2> :%s/s*$//g<cr>:noh<cr>''
 
"Super paste
ino <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>
