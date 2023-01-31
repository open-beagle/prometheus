# prometheus

<https://github.com/prometheus/prometheus>

```bash
git remote add upstream git@github.com:prometheus/prometheus.git
git fetch upstream
# 2.41.0
git merge upstream/release-2.41
```

## build

```bash
docker run -ti --rm \
-v /usr/local/share/.cache/yarn:/usr/local/share/.cache/yarn \
-v $PWD/web/ui/react-app:/go/src/github.com/prometheus/prometheus/web/ui/react-app \
-w /go/src/github.com/prometheus/prometheus/web/ui/react-app \
registry.cn-qingdao.aliyuncs.com/wod/devops-node:v16.18.1-bullseye \
yarn && yarn build

docker run -ti --rm \
-v /usr/local/share/.cache/yarn:/usr/local/share/.cache/yarn \
-v $PWD/web/ui:/go/src/github.com/prometheus/prometheus/web/ui \
-w /go/src/github.com/prometheus/prometheus/web/ui \
registry.cn-qingdao.aliyuncs.com/wod/devops-node:v16.18.1-bullseye \
yarn && yarn build

docker run -it \
--rm \
-v $PWD/:/go/src/github.com/prometheus/prometheus \
-w /go/src/github.com/prometheus/prometheus \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19 \
bash .beagle/build.sh
```

## cache

```bash
# dev
docker run \
--rm \
-v $PWD/:/go/src/github.com/prometheus/prometheus \
-v $PWD/dist/cache/:/cache \
-w /go/src/github.com/prometheus/prometheus \
-e PLUGIN_REBUILD=true \
-e PLUGIN_CHECK=./web/ui/react-app/yarn.lock \
-e PLUGIN_MOUNT=./web/ui/react-app/node_modules \
-e DRONE_COMMIT_BRANCH=master \
-e CI_WORKSPACE=/go/src/github.com/prometheus/prometheus \
registry.cn-qingdao.aliyuncs.com/wod/devops-cache:1.0
```

## prometheus-ui

```bash
docker run -ti --rm \
-v /usr/local/share/.cache/yarn:/usr/local/share/.cache/yarn \
-v $PWD/:/go/src/github.com/prometheus/prometheus \
-w /go/src/github.com/prometheus/prometheus \
registry.cn-qingdao.aliyuncs.com/wod/devops-node:14.18.1-bullseye \
bash -c 'cd web/ui/react-app && yarn && yarn build'

docker build \
  --build-arg BASE=registry.cn-qingdao.aliyuncs.com/wod/alpine:3.12 \
  --build-arg AUTHOR=mengkzhaoyun@gmail.com \
  --build-arg VERSION=v2.23.0 \
  --tag registry.cn-qingdao.aliyuncs.com/wod/prometheus-ui:v2.23.0 \
  --file .beagle/prometheus-ui.dockerfile .

docker push registry.cn-qingdao.aliyuncs.com/wod/prometheus-ui:v2.23.0
```
