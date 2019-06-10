wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh -b
git clone https://github.com/pisa-engine/nyt-corpus-reader.git
/root/miniconda3/bin/pip install -r nyt-corpus-reader/requirements.txt
apt-get update -y && apt-get install -y time --no-install-recommends && apt-get clean -y && rm -rf /var/lib/apt/lists/*
curl https://cmake.org/files/v3.14/cmake-3.14.1-Linux-x86_64.sh -o /tmp/curl-install.sh \
      && chmod u+x /tmp/curl-install.sh \
      && mkdir /usr/bin/cmake \
      && /tmp/curl-install.sh --skip-license --prefix=/usr/bin/cmake \
      && rm /tmp/curl-install.sh
