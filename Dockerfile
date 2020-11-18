FROM grpc/go:1.0

ENV PATH $PATH:/gopath/bin
ENV GOPATH /gopath

RUN echo "Installing dependensies" && \
    apt update && \
    apt install -y \
        cmake \
        git \
        openssl \
        build-essential \
        autoconf \
        libtool \
        pkg-config \
        libgflags-dev \
        libgtest-dev \
        libc++-dev && \
    echo "Installing godep" && \
    mkdir -p /gopath/bin && \
    mkdir -p /gopath/pkg && \
    mkdir -p /gopath/src && \
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh && \
    echo "Installing protobuf" && \
    go get github.com/golang/protobuf/protoc-gen-go && \
    go install github.com/golang/protobuf/protoc-gen-go && \
    echo "Installing grpc" && \
    go get google.golang.org/grpc && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc && \
    echo "Installing gRPC->RESTful API middleware" && \
    cd /gopath/src && \
    mkdir -p github.com/grpc-ecosystem && \
    cd github.com/grpc-ecosystem && \
    git clone https://github.com/grpc-ecosystem/grpc-gateway.git && \
    cd grpc-gateway && \
    git fetch && git checkout remotes/origin/v1 && \
    go get github.com/golang/glog && \
    go get github.com/ghodss/yaml && \
    go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
    go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger && \
    echo "Installing mwitkow/go-proto-validators" && \
    go get -u github.com/mwitkow/go-proto-validators/protoc-gen-govalidators

WORKDIR /gopath/src
