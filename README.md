# vimrc

これはvimの設定ファイルを保存するためのリポジトリです。



# 導入方法

## Windows

### PowerShell

インストールは以下の通り。

```ps1
# GitHubからリポジトリをクローンする
git clone https://github.com/Morichan/vimrc.git

# クローンしたディレクトリに移動する
Set-Location vimrc

# 値を設定する
Set-Location rc\init\config.sample.vim rc\init\config.vim
vim rc\init\config.vim

# 設定を読込む
.\install.ps1
```

アンインストールは下記の通り。

```ps1
# アンインストールする
.\install.ps1 -Uninstall
```

### コマンドプロンプト

PowerShellを起動して、PowerShell用のコマンドを実行すればよい。

```cmd
@REM PowerShellを起動する（以降は上記コマンドを実行する）
powershell
```

## MacOS, Linux

インストールは下記の通り。

```sh
# GitHubからリポジトリをクローンする
git clone https://github.com/Morichan/vimrc.git

# クローンしたディレクトリに移動する
cd vimrc

# 値を設定する
cp rc/init/config.sample.vim rc/init/config.vim
vim rc/init/config.vim

# 設定を読込む
./install.sh
```

アンインストールは下記の通り。

```sh
# アンインストールする
./install.sh --uninstall
```


## 古い方法

```sh
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
