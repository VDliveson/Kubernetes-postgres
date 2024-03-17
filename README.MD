    kubectl apply -f postgres-configmap.yaml && kubectl apply -f postgres-secret.yaml && kubectl apply -f psql-pv.yaml && kubectl apply -f psql-claim.yaml && kubectl apply -f ps-deployment.yaml && kubectl apply -f ps-service.yaml

Dashboard

    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

    kubectl apply -f dashboard/dashboard-adminuser.yaml && kubectl apply -f dashboard/cluster-role-binding.yaml

    kubectl -n kubernetes-dashboard create token admin-user > token.txt

    kubectl proxy


Access : http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/workloads?namespace=default

PostgreSQL database run

    kubectl exec -it {pod_name} -- psql -h localhost -U ps_user --password -p 5432 pg_db