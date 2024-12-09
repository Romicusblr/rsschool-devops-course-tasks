# Install Prometheus with Helm

This guide provides step-by-step instructions to install Prometheus using Helm in your Kubernetes cluster.

## Prerequisites

- Kubernetes cluster up and running
- `kubectl` command-line tool configured
- Helm installed and set up on your local machine

## Steps to Install Prometheus

1. **Add Helm Repositories**

    Add the `prometheus-community` and `bitnami` repositories to Helm for accessing the necessary charts.

```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
```

4. **Install Prometheus**


```sh
kubectl create namespace monitoring
helm install prometheus bitnami/prometheus -f values-prometheus.yaml -n monitoring
```

5. **Install Node Exporter and Kube State Metrics**

```sh
helm install kube-state-metrics prometheus-community/kube-state-metrics -n monitoring
helm install node-exporter prometheus-community/prometheus-node-exporter -n monitoring
```

**Install Grafana**

### Prerequisites
1. Create admin credentials secret:
```sh
kubectl create secret generic grafana-admin-credentials \
  --from-literal=admin-password=password \
  -n monitoring
```

2. Create datasource secret:
```sh
kubectl create secret generic datasource-secret \
  --from-file=datasource-secret.yaml \
  -n monitoring
```

3. Create dashboard ConfigMap:
```sh
kubectl create configmap my-dashboard-1 \
  --from-file=my-dashboard-1.json \
  -n monitoring
```

4. Install Grafana:
```sh
helm install grafana bitnami/grafana \
  -f values-grafana.yaml \
  -n monitoring
```
