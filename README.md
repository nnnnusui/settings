書いた [.bat, .sh] や、設定ファイル、環境テンプレートなど の保存場所。

## /init/*
`git clone` 後に使うスクリプトなどが入っている。

ex) link.sh を実行すると ~/.vimrc (リンク)が生成される


## /script/*
手順の省略に使う便利系スクリプト。

ex) sh ~/git/init.sh とかやって使う


## ~xxxxx/*
各環境用のファイル群。あまり直接触る必要はないようにしたい気もするところがある。

### ~dotfiles/*
Linux系OS用のdotfiles を入れる予定。

_vimrcなど、これに限らないものも入れる


### ~windows/*
Windows用の .bat や、フォルダ整理テンプレート 等

#### ~windows/whenInstalling/*
環境構築スクリプト。

個人的には主に、OSインストール時に [ctrl]+[shift]+[F3] などしてAdministratorでログインしてから使う。

##### createSystemDrive.bat
指定のドライブをクリーンアップしてシステムパーティションを作成する。

パーティション作成画面で [shift]+[F10] で`cmd`を起動した後、これを起動する。

##### relocateProfilesDirectory_toU.bat & relocate_toU.xml
/Users/ を `U:\Users` に移動する。

Windowsインストール後のアカウント作成時に [ctrl]+[shift]+[F3] を押下すると Administrator でログインできる。
この状態でスクリプトを実行することで、Usersフォルダを移動する。

実行前に、 [Uドライブを割り当てる/Uドライブ以外(存在するドライブ)への移動に書き換える]必要がある


など。以上
