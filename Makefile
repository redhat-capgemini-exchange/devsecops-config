VERSION = 1.0.0
BUILD_NAMESPACE = devsecops-config

.PHONY: namespace
namespace:
	oc new-project ${BUILD_NAMESPACE}

.PHONY: install
install:
	oc policy add-role-to-user system:image-builder \
		system:serviceaccount:${BUILD_NAMESPACE}:builder \
		--namespace=openshift
	oc apply -f gitops-tasks/task_github_update_manifest.yaml
	oc apply -f gitops-tasks/task_tag_image_stream.yaml
	oc apply -f gitops-tasks/builder.yaml
	

.PHONY: cleanup
cleanup:
	oc delete build --all -n ${BUILD_NAMESPACE}
	oc delete pod --field-selector=status.phase==Succeeded -n ${BUILD_NAMESPACE}
	oc delete pod --field-selector=status.phase==Succeeded -n ${BUILD_NAMESPACE}