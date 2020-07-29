#!/bin/sh

echo "[i] MySQL data directory not found, creating initial DBs"
mysql_install_db --user=root > /dev/null

### DB作成処理 ###
/usr/bin/mysqld --user=root --bootstrap --verbose=0 /startup/mysql/db/


### テーブル作成処理 ###
dir_path="/startup/mysql/tables/*"
sql_files=`find $dir_path -maxdepth 0 -type f -name *.sql`

# テーブル作成SQLがない場合エラー
if [ ! -f "$sql_files" ]; then
  exit 1
fi

# テーブル作成
for sql_file in $sql_files:
do
  echo $sql_file
  /usr/bin/mysqld --user=root --bootstrap --verbose=0 $sql_file
done


### 初期データ登録処理 ###
dir_path="/startup/mysql/data/*"
sql_files=`find $dir_path -maxdepth 0 -type f -name *.sql`

# 初期データがない場合エラー
if [ ! -f "$sql_files" ]; then
  exit 1
fi

# 初期データ登録
for sql_file in $sql_files:
do
  echo $sql_file
  /usr/bin/mysqld --user=root --bootstrap --verbose=0 $sql_file
done

### MySQL起動
exec /usr/bin/mysqld --user=root --console
