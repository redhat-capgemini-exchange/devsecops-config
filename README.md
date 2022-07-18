# DevSecOps

Install and configure the basic OpenShift operators needed for `DevSecOps`.

This will install the following operators:

* Red Hat OpenShift GitOps
* Red Hat OpenShift Pipelines
* Red Hat Quay
* Red Hat Quay Bridge Operator
* Red Hat Quay Conatiner Security Operator

## Preparation

### Install OpenShift Data Foundations

Install the ODF operator following the instructions [here](https://access.redhat.com/documentation/en-us/red_hat_openshift_data_foundation/4.10).

Create a `StorageSystem`.

## Install the operators

Subscribe to the operators:

```shell
oc apply -f operator/openshift-gitops-operator.yaml
oc apply -f operator/openshift-pipeline-operator.yaml
oc apply -f operator/openshift-quay-operator.yaml
```

Verify that the default GitOps instance is up-and-running:

```shell
oc get pods -n openshift-gitops
```

### Configure Red Hat Quay

Deploy the initial config params:

```shell
oc create secret generic -n openshift-operators --from-file config.yaml=./quay/config.yaml quay-init-config-bundle
```

Deploy the Quay instance:

```shell
oc create -n openshift-operators -f quay/quay-registry.yaml
```

#### Create the admin user

Get the Quay API endpoint:

```shell
oc get quayregistry -n openshift-operators quay-registry -o jsonpath="{.status.registryEndpoint}" -w
```

```shell
export QUAY_ENDPOINT=https://quay-registry-.... 

curl -X POST -k  "$QUAY_ENDPOINT/api/v1/user/initialize" \
    --header 'Content-Type: application/json' \
    --data '{ "username": "quayadmin", "password":"quaypass123", "email": "quayadmin@example.com", "access_token": true}'

```

#### Configure the Quay Bridge

Log into Quay as the admin user (quayadmin@quaypass123).

Create a `new organization` (gitopshq).

Create a new `application` within the organization (quay-bridge). 

Create an `Access Token` for the application. Give it full rights to the organization.

Create a secret with the above access token:

```shell
oc create secret -n openshift-operators generic quay-integration \
    --from-literal=token=<access_token>
```

Update `quay/quay-integration.yaml` with the actual Quay instance endpoint.

Deploy the Quay Bridge instance:

```shell
oc apply -n openshift-operators -f quay/quay-integration.yaml
```

See [https://github.com/quay/quay-bridge-operator](https://github.com/quay/quay-bridge-operator) for more details on the operator.


### Deploy the Quay Container Security Operator

```shell
oc apply -f operator/openshift-quay-security-operator.yaml
```

See [https://github.com/quay/container-security-operator](https://github.com/quay/container-security-operator) for more details on the operator.


## Usefull commands

```shell
# list installed operators
oc get csv

# list available operators
oc get packagemanifests -n openshift-marketplace

```
