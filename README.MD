## Create Cluster

Create kind cluster

    kind create cluster

Start the cluster with manifests

    bash apply.sh kubeflow

## Dashboard
To run Dashboard

    kubectl proxy


Access : http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/workloads?namespace=default

PostgreSQL check database run

    kubectl exec -it {pod_name} -- psql -h localhost -U ps_user --password -p 5432 pg_db

Port forward the database if you want to connect locally

    kubectl port-forward service/postgres 5432:5432 --namespace={YOUR_NAMESPACE}