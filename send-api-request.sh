#!/bin/bash

ARGO_TOKEN=$(kubectl get secret jenkins.service-account-token -n argo -o jsonpath='{.data.token}' | base64 --decode)
curl --request POST \
    --insecure \
    --verbose \
    --url https://localhost:2746/api/v1/workflows/argo/submit \
    --header 'content-type: application/json' \
    --header 'authorization: ${ARGO_TOKEN}' \
    --data '{
            "namespace": "argo",
            "resourceKind": "WorkflowTemplate",
            "resourceName": "provisioning-pipeline",
            "submitOptions": {
            "generateName": "provisioning-workflow-",
            "parameters": [
                "message=Mr Max our guy"
            ]
            }
        }'