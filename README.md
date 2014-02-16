elasticsearch-study
===================

Elasticsearchチュートリアル - 不可視点
http://code46.hatenablog.com/entry/2014/01/21/115620

を実践するための各種ファイルです。

## VirtualBox + Vagrant + Ansible で elasticsearch 用サーバーをたてる

Ansible は次のコマンドでインストールします。
```
sudo pip install ansible
```

VirtualBox は https://www.virtualbox.org/ からダウンロードしてインストールします。

Vagrant は http://www.vagrantup.com/ からダウンロードしてインストールします。

ここまでできたら、このファイルのあるディレクトリで `vagrant up` と実行すれば CentOS 6 サーバーが起動します。
ゲストOSに2GB,2CPU(core)割り当てる Vagrantfile になっているので、変更する場合は vb.customize の行を書き換えます。

次に Ansible で elasticsearch のインストールなどを行います。

Oracle JDK (RPM) は事前にダウンロードして `ansible/roles/java7/files/` に置きます。
http://www.oracle.com/technetwork/java/javase/downloads/index.html

`jdk-7u25-linux-x64.rpm` 想定ですが、7u25 でない場合は ansible-playbook 実行時に `-e jdk_version=7u51` などと指定します。

```
cd ansible
ansible-playbook -i hosts site.yml
```

JVM の Heap に 1GB 割り当てる設定になっていますが、減らす場合は ansible-playbook のオプションで `-e es_heap_size=500M` などと指定します。

これで [http://localhost:9200/](http://localhost:9200/) にアクセスすると elasticsearch につながります。
[http://localhost:9200/_plugin/head/](http://localhost:9200/_plugin/head/) で head plugin に [http://localhost:9200/_plugin/marvel/](http://localhost:9200/_plugin/marvel/) で marvel にアクセスできます。


## Livedoor のグルメの研究用データセットを登録する

Ruby スクリプトで Livedoor のグルメの研究用データセットを ES に投入します。
https://github.com/livedoor/datasets

```
git clone https://github.com/livedoor/datasets.git
cd datasets
tar xvf ldgourmet.tar.gz
```

### インデックスを定義する

```
curl -XPOST localhost:9200/ldgourmet -d @mapping.json
```

### データを登録する

script ディレクトリに登録用 Ruby スクリプトがあります。
load_data.rb は CSV ファイルを1行ずつ elasticsearch に PUT で登録します。
すごく時間がかかります。bulk_load_data.rb は1000行単位でまとめて POST します。

2GB RAM, 2 CPU (cores) のゲストOSで1GB JVM Heapの環境では10分強で登録できました。
H/W は Core i3-3217U 1.80GHz, SSD(M4-CT128M4SSD1)

```
time script/bulk_load_data.rb -t rating -f datasets/ratings.csv 
real	6m13.948s
user	0m33.851s
sys	0m0.524s
```

```
time script/bulk_load_data.rb -t restaurant -f datasets/restaurants.csv 
real	4m7.254s
user	0m47.194s
sys	0m0.248s
```

## id:code64 さんのチュートリアルにそってクエリを実行してみる

条件とか変えていろいろ試してみましょう

### 「地名 料理ジャンル/店名」と言った形でレストランを探す

```
script/simple_query_string1.sh
script/simple_query_string2.sh
```

### PV順・口コミが多い順・評価が高い順など検索結果をソート

```
script/simple_query_string_sort.sh
```

### ドキュメントのスコアを自分で定義する

```
script/function_score_query1.sh
```

### 望ましい条件を列挙し、どれかにヒットすれば加点

```
script/function_score_query2.sh
```

## JSON を扱うので jq コマンドがあると便利かも

http://stedolan.github.io/jq/

