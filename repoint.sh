# 1) Create/Edit K3s config:
sudo mkdir -p /etc/rancher/k3s
sudo tee /etc/rancher/k3s/config.yaml >/dev/null <<'YAML'
write-kubeconfig-mode: "0644"
tls-san:
  - homelab01
  - 127.0.0.1
  - 192.168.178.4 
  - kraken
YAML

# 2) Rotate serving certs and restart k3s
# (rotation picks up new SANs; if your k3s version lacks this command, just restart)
sudo k3s certificate rotate || true
sudo systemctl restart k3s

# 3) Point kubeconfig back to homelab01 if you want:
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
CLUSTER=$(kubectl config view -o jsonpath='{.clusters[0].name}')
kubectl config set-cluster "$CLUSTER" --server=https://homelab01:6443

# 4) Test:
kubectl get nodes

