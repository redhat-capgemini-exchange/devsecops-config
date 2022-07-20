VERSION = 1.0.0
BUILD_NAMESPACE = devsecops-config

.PHONY: install
install: create_namespaces config prepare_build
	oc appyl -f gitops-tasks/task_github_update_manifest.yaml
	oc appyl -f gitops-tasks/task_tag_image_stream.yaml
	
.PHONY: create_namespaces
create_namespaces: config prepare_build
	oc new-project ${BUILD_NAMESPACE}

.PHONY: config
config_build:
	oc policy add-role-to-user system:image-builder \
		system:serviceaccount:${BUILD_NAMESPACE}:builder \
		--namespace=openshift

.PHONY: prepare_build
prepare_build:
	oc apply -f gitops-tasks/builder.yaml

.PHONY: cleanup
cleanup:
	oc delete build --all -n ${BUILD_NAMESPACE}
	oc delete pod --field-selector=status.phase==Succeeded -n ${BUILD_NAMESPACE}
	oc delete pod --field-selector=status.phase==Succeeded -n ${BUILD_NAMESPACE}