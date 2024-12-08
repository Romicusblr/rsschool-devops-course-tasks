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

6. **Install Grafana**
```sh
helm install grafana bitnami/grafana -f values-grafana.yaml -n monitoring
```



## Verification

- Check all Prometheus components are running in the namespace.
- Access the Prometheus server UI to confirm it's collecting metrics.

## Additional Resources

- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Helm Charts for Prometheus](https://github.com/prometheus-community/helm-charts)
