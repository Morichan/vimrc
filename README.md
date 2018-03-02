# vimrc

これはvimの設定ファイルを保存するためのリポジトリです。



# 導入方法

```bash:command
$ dir
vim80-kaoriya-win32 # vim.exeが存在するフォルダ

$ git clone https://github.com/Morichan/vimrc.git vim80-kaoriya-win32.git
# 実際にはこのコマンドは正しく動作しません。
# 前のコマンドのvim.exeが存在するフォルダ内のうち、
# vimrcファイル以外のファイルとフォルダを全てvimrcフォルダにコピーしてください。
# また、ディレクトリ名を次のように変更してください。
# * vim80-kaoriya-win32/ -> vim80-kaoriya-win32_default/
# * vimrc/ -> vim80-kaoriya-win32/

$ cd vim80-kaoriya-win32
$ perl install_dein.pl
```
