# chmod +x ./.debug-dev.sh

# Set the subscription
export ARM_SUBSCRIPTION_ID="<subscription_id>"
az account set --subscription "$ARM_SUBSCRIPTION_ID"

# Set the application / environment
export TF_VAR_application_name="observability"
export TF_VAR_environment_name="dev"

# Set the backend
export BACKEND_RESOURCE_GROUP_NAME="rg-terraform-state-dev"
export BACKEND_STORAGE_ACCOUNT_NAME="ste7n58lbhfr"
export BACKEND_CONTAINER_NAME="tfstate"
export BACKEND_KEY=$TF_VAR_application_name-$TF_VAR_environment_name # correlation of app name and environment name

terraform init \
  -backend-config="resource_group_name=${BACKEND_RESOURCE_GROUP_NAME}" \
  -backend-config="storage_account_name=${BACKEND_STORAGE_ACCOUNT_NAME}" \
  -backend-config="container_name=${BACKEND_CONTAINER_NAME}" \
  -backend-config="key=${BACKEND_KEY}" \
  -reconfigure

terraform $* -var-file ./env/${TF_VAR_environment_name}.tfvars

# clean up the local environment
# rm -rf .terraform