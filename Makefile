# main make file to run provsioning pipeline tasks

ARGO_WORKFLOWS_VERSION := "vX.Y.Z"

####### deploy argo workflow helm chart
PHONY: deploy-argo-workflow uninstall-argo-workflow
deploy-argo-workflow:
	kubectl create ns argo || echo "namespace argo-workflow already exists"
	kubectl apply --server-side -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v4.1.5/quick-start-postgres.yaml

uninstall-argo-workflow:
	kubectl delete ns argo || echo "namespace argo-workflow already deleted"

run-argo-workflow:
	kubectl -n argo port-forward deployment/argo-server 2746:2746

######## deploy provisioning pipeline workflow template
PHONY: deploy-provisioning-pipeline uninstall-provisioning-pipeline
deploy-provisioning-pipeline:
	argo template create workflow-templates/provisioning-pipeline/provisioning-pipeline.yaml -n argo

update-provisioning-pipeline:
	argo template update workflow-templates/provisioning-pipeline/provisioning-pipeline.yaml -n argo