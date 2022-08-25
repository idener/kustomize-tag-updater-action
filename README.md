# Kustomize Update Image Tags

## Inputs

| name          | required | type   | default         | description |
| ------------  | ---      | ------ | --------------- | ----------- |
| repo_url      | yes      | string |                 | URL of the repository containing the kubernetes manifests
| new_image     | yes      | string |                 | Image name with the new tag
| token         | false    | string |                 | Personal access token (PAT) used to fetch the repository
| kustomize_path| false    | string | `manifests`     | Path to the folder where kustomization.yaml is stored

## Usage

In the last step of the CI pipeline:

```yaml
# .github/workflows/ci-pipeline.yaml
name: CI Pipeline

on:
  push:
    branches:
      - develop
      - main

jobs:
  
  # Testing, building and pushing container jobs
  # [...]

  update_tags:
    - uses: idener/kustomize-tag-updater@v0.1
      with:
        repo_url: https://github.com/idener/CD-Cityloops
        new_image: "$IMAGE_NAME:$NEW_TAG"
        token: ""

```