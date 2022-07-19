# devsecops-config

This repo contains a collection of deployment configs and instructions on how to setup the basic OpenShift components needed for `GitOps` and `DevSecOps`.

The following components are used:

* Red Hat OpenShift GitOps
* Red Hat OpenShift Pipelines
* Red Hat Quay
* Red Hat Quay Bridge Operator
* Red Hat Quay Container Security Operator

## Preparation

### Install OpenShift Data Foundations

Red Hat Quay uses some Red Hat Data Foundation APIs. To install the ODF operator, follow the instructions [here](https://access.redhat.com/documentation/en-us/red_hat_openshift_data_foundation/4.10).

Also create a default `StorageSystem`.

## Install the operators

See [operator/README.md](operators/README.md) for a step-by-step guid how to install and configure the operators.

## OpenShift GitOps

A default instance is installed in the `openshift-operators` namespace. 

Verify that the default GitOps instance is up-and-running:

```shell
oc get pods -n openshift-gitops
```

The instance has a default user `admin`. A password is created during the inital deployment. In order to retrieve the password, run:

```shell
oc extract secret/openshift-gitops-cluster -n openshift-gitops --to=-
```

