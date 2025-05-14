# Azure with Terraform Knowledge Backup

This project serves as a knowledge backup for managing Azure infrastructure using Terraform. It includes examples, modules, and configurations to help you:

- Learn how to use Terraform to provision and manage Azure resources.
- Understand best practices for structuring Terraform projects.
- Explore reusable modules for common Azure services.

## Project Structure

- **module.tf**: Contains the main Terraform configuration for the project.
- **terraform.tf**: Includes provider configurations and global settings.
- **modules/**: A directory containing reusable Terraform modules for Azure services.

## Prerequisites

- **Terraform**: Ensure Terraform is installed on your system. You can download it from [Terraform's official website](https://www.terraform.io/downloads.html).
- **Azure CLI**: Install the Azure CLI and authenticate using `az login`.

## Usage

1. Initialize the project:
   ```bash
   terraform init
   ```

2. Plan the changes:
   ```bash
   terraform plan -out=tfplan
   ```

3. Apply the changes:
   ```bash
   terraform apply tfplan
   ```

4. Verify the state:
   ```bash
   terraform show
   ```

## Notes

- Sensitive files like `*.tfstate` and `*.tfvars` are excluded from version control using the `.gitignore` file.
- Always review the execution plan before applying changes to avoid unintended modifications.

## License

This project is for educational purposes and is not intended for production use. Use it at your own risk.