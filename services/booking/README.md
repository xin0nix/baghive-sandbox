## How to build

```sh
sudo apt-get install -y build-essential \
    libssl-dev \
    libcurl4-openssl-dev \
    libpq-dev \
    libgmock-dev \
    libgtest-dev \
    libboost-all-dev \
    libprotobuf-dev \
    protobuf-compiler;
```

```sh
cmake --preset=debug
```

Pulsar client...
https://apache.googlesource.com/pulsar-client-cpp/+/7cefe0e66439da69a75168842ba867d41ea5f346/README.md