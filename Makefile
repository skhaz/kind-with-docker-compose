.PHONY: clean cluster compose context coverage install lint test update vet web

.SILENT:

clean:
	kind delete cluster
	rm -f kind.conf &>/dev/null

cluster: clean
	kind create cluster --config=kind.yaml

kind.conf: context
	kubectl config view --raw | sed -E 's/127.0.0.1|localhost/host.docker.internal/' > kind.conf

context:
	kubectl config use-context kind-kind

compose: kind.conf
	docker-compose up --build
