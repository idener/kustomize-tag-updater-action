# Kustomize Update Image Tags

## Inputs

| name          | required | type   | default         | description |
| ------------  | ---      | ------ | --------------- | ----------- |
| repo          | yes      | string |                 | Repository containing the kubernetes manifests ("owner/repo-name")
| image         | yes      | string |                 | Image name with the new tag
| tag           | yes      | string |                 | New tag assigned to the image
| registry      | false    | string | `ghcr.io`       | URL of the registry used to store the image
| token         | false    | string |                 | Personal access token (PAT) used to fetch the repository
| ssh-key       | false    | string |                 | SSH key used to fetch the repository
| kustomize-path| false    | string | `manifests`     | Path to the folder where kustomization.yaml is stored

## Usage

Use this action in the last step of the CI pipeline, after the testing, building and pushing to registry jobs.

```yaml
# .github/workflows/ci-pipeline.yaml
#
# ┌──────┐   ┌───────┐   ┌────────┐   ┌──────────┐
# │ Test │   │ Build │   │Push to │   │Update K8s│
# │      ├──►│ Image ├──►│Registry├──►│manifests │
# └──────┘   └───────┘   └────────┘   └──────────┘
# 
name: CI Pipeline with K8s Manifests Update

on:
  push:
    branches: [ "main" ]

env:
  IMAGE_NAME: ""
  DEPLOY_REPO: ""
  DEPLOY_ENABLE: true

jobs:
  
  # Testing, building and pushing container jobs
  # [...]

  update_tags:
    runs-on: ubuntu-latest
    needs: previous-job-name

    steps:

      # Example setting the image tag with the first 6 digits of the commit SHA sum
      - name: Set image tag
        run: echo "TAG=${GITHUB_SHA}" | head -c 10  >> $GITHUB_ENV

      - name: Update image tag in the deployment repository
        uses: idener/kustomize-tag-updater-action@main
        if: env.DEPLOY_ENABLE == 'true'
        with:
          repo: ${{ env.DEPLOY_REPO }}
          image: ${{ env.IMAGE_NAME }}
          tag: ${{ env.TAG }}
          ssh-key: "${{ secrets.REPO_SSH }}"
```

You should use either `ssh-key` or `token` for authentication with the private repository, but not both. It's recommended to store this data as a repository secret.
