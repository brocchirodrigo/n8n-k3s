KUBECTL ?= kubectl

all: namespaces base keel databases applications

namespaces:
	@echo "🔧 Applying namespaces..."
	$(KUBECTL) apply -f infrastructure/resources/base/namespaces.yaml

base:
	@echo "🌐 Applying Traefik middlewares..."
	$(KUBECTL) apply -R -f infrastructure/resources/traefik/

keel:
	@echo "🤖 Applying Keel..."
	$(KUBECTL) apply -R -f infrastructure/resources/keel/

databases:
	@echo "💾 Applying database services..."
	$(KUBECTL) apply -R -f infrastructure/databases/

applications:
	@echo "🚀 Applying applications..."
	$(KUBECTL) apply -R -f applications/n8n/
	$(KUBECTL) apply -R -f applications/keycloak/


.PHONY: all namespaces base keel databases applications