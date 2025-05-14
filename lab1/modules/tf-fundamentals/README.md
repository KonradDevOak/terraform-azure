# Passing Input Variables Using Environment Variables

Terraform allows you to pass input variables using environment variables. This is particularly useful for managing sensitive data or dynamically setting values without hardcoding them in your configuration files.

## Using Environment Variables in PowerShell

In PowerShell, you can set environment variables for Terraform variables by prefixing the variable name with `TF_VAR_`. For example:

```powershell
# Set environment variables
$env:TF_VAR_application_name = "app"
$env:TF_VAR_environment_name = "dev"

# Run Terraform commands
terraform plan
terraform apply
```

### Notes for PowerShell:

- Environment variables set this way are only available for the current PowerShell session.
- To make them persistent, you can add them to your system environment variables or include the commands in your PowerShell profile script.

## Using Environment Variables in Bash

In Bash, you can set environment variables for Terraform variables by prefixing the variable name with `TF_VAR_`. For example:

```bash
# Set environment variables
export TF_VAR_application_name="konradsblog"
export TF_VAR_environment_name="dev"

# Run Terraform commands
terraform plan
terraform apply
```

### Notes for Bash:

- Use the `export` command to make the variables available to Terraform.
- These variables will only persist for the duration of the shell session. To make them persistent, add the `export` commands to your `~/.bashrc` or `~/.bash_profile` file and reload the shell using `source ~/.bashrc`.

## Advantages of Using Environment Variables

- Keeps sensitive data (like secrets or passwords) out of version-controlled files.
- Allows dynamic configuration of Terraform variables without modifying the code.
- Simplifies switching between different environments or configurations.

## Example

For a Terraform configuration that uses the following variables:

```terraform
variable "application_name" {
  description = "The name of the application"
  type        = string
}

variable "environment_name" {
  description = "The environment name"
  type        = string
}
```

You can set the values using environment variables as shown above, and Terraform will automatically pick them up during execution.
