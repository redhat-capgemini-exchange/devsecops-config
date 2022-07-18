# devsecops-config

This repo contains a collection of deployment configs and instructions on how to setup the basic OpenShift components needed for `GitOps` and `DevSecOps`.

The following components are used:

* Red Hat OpenShift GitOps
* Red Hat OpenShift Pipelines
* Red Hat Quay
* Red Hat Quay Bridge Operator
* Red Hat Quay Conatiner Security Operator

## Preparation

### Install OpenShift Data Foundations

Red Hat Quay uses some Red Hat Data Foundations APIs. To install the ODF operator, follow the instructions [here](https://access.redhat.com/documentation/en-us/red_hat_openshift_data_foundation/4.10).

Also create a default `StorageSystem`.

## Install the operators

See [operator/README.md](operator/README.md) for a step-by-step guid how to install and configure the operators.

