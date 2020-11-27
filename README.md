# Kubernetes Airflow Template

### Description
This project demonstrates how Kubernetes can be employed to manage an Airflow deployment

### Local Usage
* Setup an appropriate local k8 environment (if you're using linux) with kubectl and minikube by running: ` make setupk8 `
* Start a local k8 cluster with the appropriate Docker images and apply the k8 infrastructure via: ` make start `
* Stop the local k8 cluster (airflow state will be preserved) via: ` make stop `
* Reset the local k8 cluster (and thereby the airflow state) with ` make reset `

### Notes
* This project simply demonstrates how a kubernetes deployment could be managed for Airflow: something like dokcer-compose would still be easier for local dev testing.
* The logs will not show properly because a persistent storage (like S3) should be used in production
* Additonally, the "endpoint_url" would need to be updated to the load balancer CNAME record used in production,
* as even locally "http://localhost:8080" will not be assigned to the webserver service by kubernetes.
