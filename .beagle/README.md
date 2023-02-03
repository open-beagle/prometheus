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
docker run \
-it \
--rm \
-v /usr/local/share/.cache/yarn:/usr/local/share/.cache/yarn \
-v $PWD/:/go/src/github.com/prometheus/prometheus \
-w /go/src/github.com/prometheus/prometheus/web/ui \
registry.cn-qingdao.aliyuncs.com/wod/devops-node:v16 \
bash -c "npm install && npm run build && scripts/compress_assets.sh"

docker run \
-it \
--rm \
-v $PWD/:/go/src/github.com/prometheus/prometheus \
-w /go/src/github.com/prometheus/prometheus \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19 \
bash .beagle/build.sh
```

## cache

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="prometheus" \
  -e PLUGIN_MOUNT="./.git,./vendor,./web/ui/static/react" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="prometheus" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
