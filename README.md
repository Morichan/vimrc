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

