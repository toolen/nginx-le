GITTAG=$(shell git describe --abbrev=0 --tags)
B=$(shell git rev-parse --abbrev-ref HEAD)
ref=$(subst /,-,$(B))

release_master:
	- docker buildx build --push --progress=plain --platform linux/amd64,linux/arm/v7,linux/arm64 -t ghcr.io/umputun/nginx-le:${ref} -t umputun/nginx-le:${ref} .

release_latest:
	- docker buildx build --push  --progress=plain --platform linux/amd64,linux/arm/v7,linux/arm64 \
 		-t ghcr.io/umputun/nginx-le:${GITTAG} -t ghcr.io/umputun/nginx-le:latest \
 		-t umputun/nginx-le:${GITTAG} -t umputun/nginx-le:latest .

.PHONY: release

repository = toolen/nginx-le
version = 1.1.5
tag = ghcr.io/$(repository):$(version)
trivy_version=0.68.2

image:
	docker build --pull --no-cache -t $(tag) .

trivy:
	docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ~/.cache/trivy:/root/.cache/ ghcr.io/aquasecurity/trivy:$(trivy_version) image --ignore-unfixed $(tag)

push-to-ghcr:
	docker login ghcr.io -u toolen -p $(CR_PAT)
	docker push $(tag)
