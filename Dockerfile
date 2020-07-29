FROM mysql:5.6.49

RUN apt-get update && \
  apt-get install -y locales vim && \
  rm -rf /var/lib/apt/lists/* && \
  echo "ja_JP.EUC-JP EUC-JP" > /etc/locale.gen && \
  locale-gen ja_JP.ujis
ENV LC_ALL ja_JP.ujis
