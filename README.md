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

個人的には主に、OSインストール時に [shift]+([F3]? [F10]?) などしてAdministratorでログインしてから使う。


など。以上
