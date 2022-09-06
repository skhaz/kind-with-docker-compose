.PHONY: clean cluster compose context deploy

.SILENT:

clean:
	kind delete cluster
	rm -f kind.conf &>/dev/null

cluster: clean
	kind create cluster --config=kind.yaml

kind.conf: context
	kubectl config view --raw | sed -E 's/127.0.0.1|localhost/host.docker.internal/' > kind.conf

compose: kind.conf
	docker-compose up --build

context:
	kubectl config use-context kind-kind

deploy: context
	kubectl create deployment hello-node --image=k8s.gcr.io/echoserver
