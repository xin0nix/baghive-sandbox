## How to build

```sh
sudo apt-get install -y  libssl-dev libcurl4-openssl-dev libpq-dev \
    libboost1.83-dev libgmock-dev libgtest-dev g++ cmake \
    libprotobuf-dev libboost-all-dev protobuf-compiler
```

```sh
cmake --preset=debug
```

Pulsar client...
https://apache.googlesource.com/pulsar-client-cpp/+/7cefe0e66439da69a75168842ba867d41ea5f346/README.md