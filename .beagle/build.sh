#!/bin/bash 

set -ex

mkdir -p dist

export GOOS=linux

export GOARCH=amd64
make common-build
mv prometheus dist/prometheus-linux-$GOARCH
mv promtool dist/promtool-linux-$GOARCH

export GOARCH=arm64
# export CC=aarch64-linux-gnu-gcc
make common-build
mv prometheus dist/prometheus-linux-$GOARCH
mv promtool dist/promtool-linux-$GOARCH

export GOARCH=ppc64le
# export CC=powerpc64le-linux-gnu-gcc
make common-build
mv prometheus dist/prometheus-linux-$GOARCH
mv promtool dist/promtool-linux-$GOARCH

export GOARCH=mips64le
# export CC=mips64el-linux-gnuabi64-gcc
make common-build
mv prometheus dist/prometheus-linux-$GOARCH
mv promtool dist/promtool-linux-$GOARCH