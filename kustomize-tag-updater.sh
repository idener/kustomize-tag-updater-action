#!/bin/bash

echo "Installing Kustomize..."
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

echo "Editing kustomization.yaml with new image tag..."
./kustomize edit set image $1/$2

echo "Removing Kustomize binary..."
rm kustomize

echo "Pushing changes to repo..."
git commit . && git push
