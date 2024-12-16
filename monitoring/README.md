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

create a smtp secret
```sh
kubectl create secret generic grafana-smtp-secret \
  --from-literal=SMTP_USER=<SMTP_USER> \
  --from-literal=SMTP_PASSWORD=<SMTP_PASSWORD> \
  -n monitoring
```

create notifiers config
```sh
kubectl apply -f grafana-notifiers.yaml -n monitoring
```

create alerting config
```sh
kubectl apply -f grafana-alerting.yaml -n monitoring
```

4. Install Grafana:
```sh
helm install grafana bitnami/grafana \
  -f values-grafana.yaml \
  -n monitoring
```

### Running Ansible Scripts to Set Up Monitoring with Grafana

The Ansible playbooks included in this project can be used to set up monitoring with Grafana on your Kubernetes cluster. Below are the steps to run these playbooks:

### Prerequisites
- Ansible installed on your local machine.
- SSH access to the target nodes where K3s will be installed.
- Properly configured inventory file specifying the target nodes.

### Example Usage
1. Populate inventory.example with actual ip from terraform output

2. Install K3s on the master and worker nodes
```sh
ansible-playbook -i inventory.ini monitoring.yaml
```
