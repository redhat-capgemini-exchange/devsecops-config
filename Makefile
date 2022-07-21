VERSION = 1.0.0
BUILD_NAMESPACE = devsecops-config

.PHONY: namespace
namespace:
	oc new-project ${BUILD_NAMESPACE}

.PHONY: install
install: install_tasks
	oc policy add-role-to-user system:image-builder \
		system:serviceaccount:${BUILD_NAMESPACE}:builder \
		--namespace=openshift
	oc apply -f gitops-tasks/image_builder/builder.yaml
	
.PHONY: install_tasks
install_tasks:
	oc apply -f gitops-tasks/cluster_tasks/

.PHONY: cleanup
cleanup:
	oc delete build --all -n ${BUILD_NAMESPACE}
	oc delete pod --field-selector=status.phase==Succeeded -n ${BUILD_NAMESPACE}
	oc delete pod --field-selector=status.phase==Succeeded -n ${BUILD_NAMESPACE}