# chmod +x ./.debug-dev.sh

# Set the subscription
export ARM_SUBSCRIPTION_ID="<subscription_id>"
az account set --subscription "$ARM_SUBSCRIPTION_ID"

# Set the application / environment
export TF_VAR_application_name="azapivm"
export TF_VAR_environment_name="dev"

# if new environment name is different from the old one, set the new environment name
if [ "$TF_VAR_environment_name" != "$TF_VAR_old_environment_name" ]; then
  echo "changing environment name from $TF_VAR_old_environment_name to $TF_VAR_environment_name"
  export TF_VAR_old_environment_name=$TF_VAR_environment_name

  # clean up the local environment
  rm -rf .terraform
fi

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

terraform workspace new $TF_VAR_environment_name | terraform workspace select $TF_VAR_environment_name

terraform $* -var-file ./env/$TF_VAR_environment_name.tfvars # -auto-approve
