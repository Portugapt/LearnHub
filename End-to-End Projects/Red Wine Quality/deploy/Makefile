IMAGE_NAME=deployed-redwine-model
VERSION=1.2
GCP_PROJECT=jm-learnhub-redwine
build:
	docker build -t "${IMAGE_NAME}" .

docker-auth:
	gcloud auth configure-docker

tag:
	docker tag "${IMAGE_NAME}" "gcr.io/${GCP_PROJECT}/${IMAGE_NAME}:${VERSION}"

push:
	cat ../../../auth/credentials.json | docker login -u _json_key --password-stdin https://gcr.io
	docker push "gcr.io/${GCP_PROJECT}/${IMAGE_NAME}:${VERSION}"
