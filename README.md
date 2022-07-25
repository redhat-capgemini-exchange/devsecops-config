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

## Installation

See [operator/README.md](operators/README.md) for a step-by-step guid how to install and configure the operators.


## OpenShift GitOps

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



