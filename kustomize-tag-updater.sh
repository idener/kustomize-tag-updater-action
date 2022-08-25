#!/bin/bash

# Install Kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

# Edit kustomization.yaml with new image tag
./kustomize edit set image $1/$2

# Remove Kustomize binary
rm kustomize

# Push changes to repo
git commit . && git push
