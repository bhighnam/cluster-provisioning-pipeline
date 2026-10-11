# cluster-provisioning-pipeline
Deploy clusters in an automated fashion

# Environment setup
- Setup Docker desktop Kind K8s cluster
- [Quick start of Argo Workflow](https://github.com/argoproj/argo-workflows/releases/download/v4.1.5/quick-start-postgres.yaml)

# steps to get token for curl commands

Documentation: https://argo-workflows.readthedocs.io/en/latest/access-token/

API Swagger: https://argo-workflows.readthedocs.io/en/latest/swagger/

``` bash

    # create the role, service account, and bind the account and role together within the argo namespaces
    kubectl create role jenkins --verb=list,update --resource=workflows.argoproj.io -n argo
    kubectl create sa jenkins -n argo
    kubectl create rolebinding jenkins --role=jenkins --serviceaccount=argo:jenkins -n argo

    kubectl apply -f api-token-secret.yaml

    # fetch the secret
    ARGO_TOKEN="Bearer $(kubectl get secret jenkins.service-account-token -n argo -o=jsonpath='{.data.token}' | base64 --decode)"

    # test curl
    curl --insecure https://localhost:2746/api/v1/workflows/argo -H "Authorization: $ARGO_TOKEN" | jq .
```

curl example

``` bash
    curl --request POST \
        --url https://localhost:2746/api/v1/workflows/argo \
```

# TODO: Create an argo workflow template