📘 This documentation is also available in [Portuguese 🇧🇷](README_PT-BR.MD)

# 📦 K3s Cluster with N8N, Keycloak, and Databases

Lightweight and automated infrastructure with Traefik, Keel, and continuous update support.

This project defines the complete infrastructure for a lightweight cluster using **K3s**, including:

- Automated deployment of middlewares on Traefik
- Database configuration (PostgreSQL and Redis)
- Main applications: N8N and Keycloak
- Continuous image updates via **Keel**

---

## 📁 Directory Structure

```plaintext
infrastructure/
  ├── resources/
  │   ├── base/
  │   │   └── namespaces.yaml
  │   ├── traefik/
  │   │   ├── 01-middleware-redirect-https.yaml
  │   │   ├── 02-middleware-secure-headers.yaml
  │   │   └── 03-middleware-rate-limit.yaml
  │   └── keel/
  │       ├── deployment.yaml
  │       └── service.yaml
  │
  ├── databases/
  │   ├── postgres-n8n/
  │   │   ├── configmap.yaml
  │   │   ├── deployment.yaml
  │   │   └── service.yaml
  │   ├── postgres-keycloak/
  │   │   ├── configmap.yaml
  │   │   ├── deployment.yaml
  │   │   └── service.yaml
  │   └── redis-n8n/
  │       ├── configmap.yaml
  │       ├── deployment.yaml
  │       └── service.yaml
  │
applications/
  ├── n8n/
  │   ├── configmap.yaml
  │   ├── deployment.yaml
  │   ├── service.yaml
  │   └── ingressroute.yaml
  │
  └── keycloak/
      ├── configmap.yaml
      ├── deployment.yaml
      ├── service.yaml
      └── ingressroute.yaml
```

---

## 🚀 Environment Setup

### Prerequisites

- ✅ **K3s installed:**  
  [https://k3s.io](https://k3s.io)  
  Quick installation:

  ```bash
  curl -sfL https://get.k3s.io | sh -
  ```

- ✅ **Make installed (Debian/Ubuntu):**

  ```bash
  sudo apt install make
  ```

- ✅ **Permissions to apply manifests (`kubectl` is included with K3s)**

- ✅ **Project cloned locally**

### Deployment command

At the project root, run:

```bash
make
```

This command applies, in the following order:

1. Namespaces for applications and databases
2. Traefik middlewares
3. Database services with configmaps
4. Applications (N8N and Keycloak)
5. Keel (for automatic image updates)

### Important notes

- The Traefik dashboard is **disabled by default** to avoid unnecessary exposure.
- Database volumes are mapped on disk (hostPath), respecting VPS storage space.
- The environment was built specifically for lightness and native K3s resources, ensuring efficiency and simplicity in management.

---

## 🔄 Image Updates with Keel

- Keel monitors the images used in the `deployment.yaml` files and performs rolling updates automatically when new versions are available.
- Each `deployment.yaml` must contain the following annotation:

  ```yaml
  metadata:
    annotations:
      keel.sh/policy: force
  ```

---

## 📌 Final Considerations

This project was designed and validated to run on clusters based on **K3s**, leveraging its built-in resources such as Traefik and simplified local storage. However, it can be adapted for conventional Kubernetes clusters with minimal changes.

For questions or improvements, contributions are welcome!

> **Note:** This infrastructure was planned to run on clusters based on **K3s**, leveraging its built-in resources such as Traefik and simplified local storage.
