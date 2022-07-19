# devsecops-config

This repo contains a collection of deployment configs and instructions on how to setup the basic OpenShift components needed for `GitOps` and `DevSecOps`.

The following components are used:

* Red Hat OpenShift GitOps
* Red Hat OpenShift Pipelines
* Red Hat Quay
* Red Hat Quay Bridge Operator
* Red Hat Quay Container Security Operator


## Install the operators

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
