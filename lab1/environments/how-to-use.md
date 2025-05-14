# How to Use Specific Environments in Terraform

This guide explains how to use Terraform with specific environments by leveraging environment-specific variable files.

## Steps to Use a Specific Environment

1. **Define Environment-Specific Variable Files**
   Ensure that you have variable files for each environment in the `environments/` directory. For example:

   - `dev.tfvars` for the development environment
   - `prod.tfvars` for the production environment
   - `test.tfvars` for the testing environment

2. **Use the `-var-file` Flag**
   Pass the appropriate variable file for the desired environment using the `-var-file` flag. For example:

   - For the development environment:

     ```bash
     terraform plan -var-file="environments/dev.tfvars"
     terraform apply -var-file="environments/dev.tfvars"
     ```

   - For the production environment:

     ```bash
     terraform plan -var-file="environments/prod.tfvars"
     terraform apply -var-file="environments/prod.tfvars"
     ```

   - For the testing environment:
     ```bash
     terraform plan -var-file="environments/test.tfvars"
     terraform apply -var-file="environments/test.tfvars"
     ```

3. **Review the Execution Plan**
   Always review the execution plan before applying changes to ensure the correct environment is being used:

   ```bash
   terraform plan -var-file="environments/<environment>.tfvars"
   ```

   Replace `<environments>` with `dev`, `prod`, or `test` as needed.

4. **Switch Between Environments**
   To switch environments, simply use the corresponding variable file for the desired environment in the `-var-file` flag.

## Notes

- Ensure that the variable files (`dev.tfvars`, `prod.tfvars`, `test.tfvars`) contain all the required variables for your Terraform configuration.
- Use a consistent naming convention for variable files to avoid confusion.
- Avoid hardcoding environment-specific values directly in the Terraform configuration files. Instead, use variable files to keep your configuration modular and reusable.
