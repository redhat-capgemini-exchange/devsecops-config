# devsecops-config

The `devsecops-config` repo provides a collection of instructions, deployment configurations, sample files etc. to create a DevSecOps CICD setup on Red Hat OpenShift.

It uses several technologies such as:

* Red Hat OpenShift GitOps (a.k.a ArgoCD)
* Red Hat OpenShift Pipelines (a.k.a. Tekton)
* Red Hat Quay (and Quay Bridge Operator)
* Red Hat Quay Container Security Operator

Additionally multi-cluster management tools can be added:

* Red Hat OpenShift Advanced Cluster Manager for Kubernetes
* Red Hat OpenShift Advanced Cluster Security for Kubernetes

## Preparation

See [operator/README.md](operators/README.md) for a step-by-step guid how to install and configure the operators used in the devsecops-config setup.


## Accessing OpenShift GitOps

A default instance is installed in the `openshift-gitops` namespace. 

Verify that the default GitOps instance is up-and-running:

```shell
oc get pods -n openshift-gitops
```

The instance has a default user `admin`. A password is created during the inital deployment. In order to retrieve the password, run:

```shell
oc extract secret/openshift-gitops-cluster -n openshift-gitops --to=-
```

Get the ArgoCD route:

```shell
oc get route openshift-gitops-server -n openshift-gitops
```

## Deploy the Pipelines

There are two generic Tekton pipelines to support secure builds and auditable rollouts of container images:

* `build-pipeline`, defined in `pipelines/build`
* `rollout-pipeline`, defined in `pipelines/rollout`

The pipelines use custom `ClusterTasks` and a custom container image.

To deploy the pipelines and all other resoureces:

```shell
make namespace
```

This creates the `devsecops-config` namespace.

Install the remaining resources:

```shell
make install
```

Validat that everything is deployed correctly by checking the `sync` status of all resources in the ArgoCD web UI.

### Configuration and secrets

Before you can run any of these pipelines, make sure that all configs and secrets are deployed.

Make a copy of the `secrets/*.example.yaml` files and edit their contents to match your environment.

Deploy the pipeline configs and secrets:

```shell

oc apply -f secrets/github_secrets.yaml -n devsecops-config
oc apply -f secrets/argocd_secrets.yaml -n devsecops-config
oc apply -f secrets/argocd_configmap.yaml -n devsecops-config

```