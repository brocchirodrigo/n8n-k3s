📘 Esta documentação também está disponível em [English 🌐](README.MD)

# 📦 Cluster K3s com N8N, Keycloak e Bancos de Dados

Infraestrutura leve e automatizada com Traefik, Keel e suporte a atualizações contínuas.

Este projeto define a infraestrutura completa para um cluster leve usando **K3s**, incluindo:

- Deploy automatizado de middlewares no Traefik
- Configuração de bancos de dados (PostgreSQL e Redis)
- Aplicações principais: N8N e Keycloak
- Atualização contínua de imagens via **Keel**

---

## 📁 Estrutura de Diretórios

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
  │   │   ├── secret.yaml
  │   │   ├── deployment.yaml
  │   │   └── service.yaml
  │   ├── postgres-keycloak/
  │   │   ├── configmap.yaml
  │   │   ├── secret.yaml
  │   │   ├── deployment.yaml
  │   │   └── service.yaml
  │   └── redis-n8n/
  │       ├── configmap.yaml
  │       ├── secret.yaml
  │       ├── deployment.yaml
  │       └── service.yaml
  │
applications/
  ├── n8n/
  │   ├── configmap.yaml
  │   ├── secret.yaml
  │   ├── deployment.yaml
  │   ├── service.yaml
  │   └── ingressroute.yaml
  │
  └── keycloak/
      ├── configmap.yaml
      ├── secret.yaml
      ├── deployment.yaml
      ├── service.yaml
      └── ingressroute.yaml
```

---

## 🚀 Execução do Ambiente

### Pré-requisitos

- ✅ **K3s instalado:**  
  [https://k3s.io](https://k3s.io)  
  Instalação rápida:

  ```bash
  curl -sfL https://get.k3s.io | sh -
  ```

- ✅ **Make instalado (Debian/Ubuntu):**

  ```bash
  sudo apt install make
  ```

- ✅ **Permissões para aplicar manifests (`kubectl` já incluso com K3s)**

- ✅ **Projeto clonado localmente**

### Comando de implantação

Na raiz do projeto, execute:

```bash
make
```

Este comando aplica, na seguinte ordem:

1. Namespaces para aplicações e bancos
2. Middlewares do Traefik
3. Serviços de banco de dados com configmaps
4. Aplicações (N8N e Keycloak)
5. Keel (para atualização automática de imagens)

### Observações importantes

- O painel do Traefik está **desativado por padrão** para evitar exposição desnecessária.
- Os volumes dos bancos de dados são mapeados em disco (hostPath), respeitando o espaço da VPS.
- O ambiente foi construído pensando especificamente na leveza e nos recursos nativos do K3s, garantindo eficiência e simplicidade no gerenciamento.

---

## 🔄 Atualizações de Imagens com Keel

- O Keel monitora as imagens usadas no `deployment.yaml` e realiza _rolling updates_ automaticamente quando há novas versões.
- Cada `deployment.yaml` deve conter a seguinte anotação:

  ```yaml
  metadata:
    annotations:
      keel.sh/policy: force
  ```

---

## 📌 Considerações Finais

Este projeto foi idealizado e validado para rodar em clusters baseados em **K3s**, aproveitando seus recursos embutidos como o Traefik e o armazenamento local simplificado. Contudo, pode ser adaptado para clusters Kubernetes convencionais com mínimas alterações.

Para dúvidas ou melhorias, contribuições são bem-vindas!

> **Nota:** Esta infraestrutura foi planejada para rodar em clusters baseados em **K3s**, aproveitando seus recursos embutidos como o Traefik e o armazenamento local simplificado.
