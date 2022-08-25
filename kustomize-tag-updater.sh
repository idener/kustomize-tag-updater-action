#!/bin/bash

# Install Kustomize
cd manifests
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

# Edit kustomization.yaml with new image tag
./kustomize edit set image ghcr.io/$1

# Remove Kustomize binary
rm kustomize

# Push changes to repo
git commit . && git push