# github-actions-test

Test in Githab Actions

## Branch

### python-pip

pipでreqirements.txtのパッケージをインストールしてアプリを実行

### scp-deploy

ssh-keyの生成(ローカル)

```shell
ssh-keygen -m PEM -t rsa -b 4096 -C "test for github actions" -f id_rsa_<name>
```

`id_rsa_<name>`と`id_rsa_<name>.pub`ができる

デプロイ先に上記で作成した公開鍵を登録

```shell
# ローカル
scp id_rsa_<name>.pub <user>@<remote>:
scp <user>@<remote>
# リモート
cat id_rsa_<name>.pub >> ~/.ssh/authorized_keys2 
```

以下の環境変数をGithub/Secresで設定(`Settings>Secrets`)

* `SSH_PRIVATE_KEY`: 上記で作成した`id_rsa_<name>`
* `SSH_HOST`: デプロイ先のリモートホスト
* `SSH_PORT`: デフォルト22(省略可能)
* `SSH_DIR`: デプロイ先のディレクトリ
* `SSH_USER`: リモートユーザ
* `SRC_DIR`: コピー元のディレクトリ

#### リンク

* [SCP deploy action · Actions · GitHub Marketplace](https://github.com/marketplace/actions/scp-deploy-action)

### upload-artifact

設定は下記リンク参照

![作成されたArtifacts](screenshot.png)

#### WEB-APIを利用したArtifactsの取得

* アクセストークンの発行(右上のユーザアイコンから)
  * `Settings>Developer settings>Personal access tokens>Generate new token`
    * 一番上の`repo`にチェック

#### 確認

```shell
make download
```

`test.http`の`download_url`はうまく取得できてない

#### リンク

* [actions/upload\-artifact](https://github.com/actions/upload-artifact)
