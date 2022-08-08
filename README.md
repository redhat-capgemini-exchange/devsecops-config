# devsecops-config

This is a generic implementation of a GitOps application delivery workflow on Red Hat OpenShift.

It uses several technologies such as:

* Red Hat OpenShift GitOps (a.k.a ArgoCD)
* Red Hat OpenShift Pipelines (a.k.a. Tekton)
* Red Hat Quay and the Red Hat Quay Bridge Operator
* Red Hat Quay Container Security Operator

The implementation assumes a [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) workflow to develop and release software. A `Config Git Repository` allows for a declarative approach to application delivery. Using Git to controll the rollout of container images via pull requests makes the software delivery workflow revision and audit-proof.

To support hybrid-cloud and multi-cluster deployments, additional management tools can be added:

* Red Hat OpenShift Advanced Cluster Manager for Kubernetes
* Red Hat OpenShift Advanced Cluster Security for Kubernetes


## Concept and Architecture

TBD

## Preparation

See [operator/README.md](operators/README.md) for a step-by-step guid how to install and configure the operators used in the devsecops-config setup.


### Accessing OpenShift GitOps

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

### Deploy the Pipelines

There are two generic Tekton pipelines to support secure builds and auditable rollouts of container images:

* `build-pipeline`, defined in `pipelines/build`
* `rollout-pipeline`, defined in `pipelines/rollout`

The pipelines use custom `ClusterTasks` and a custom `container image`.

Create the namespace first:

```shell
make namespace
```

To deploy the pipelines and all resoureces:

```shell
make install
```

**Note:** you can verify that everything is deployed correctly by checking the `sync` status of all resources in the Red Hat OpenShift GitOps UI.

#### Configuration and secrets

Before you can start any pipeline runs, make sure that all configs and secrets are deployed.

Make a copy of the `secrets/*.example.yaml` files and edit their contents to match your environment.

Deploy the pipeline configs and secrets:

```shell

oc apply -f secrets/github_secrets.yaml -n devsecops-config
oc apply -f secrets/argocd_secrets.yaml -n devsecops-config
oc apply -f secrets/argocd_configmap.yaml -n devsecops-config

```