
# 🚀 Terraform AWS EC2 with Remote SSH & Docker

This project provisions a secure and customizable AWS EC2 infrastructure using Terraform — ideal for testing, learning, or extending into a production-ready environment.

## 🌐 What It Does

- Creates a new **VPC**, **public subnet**, **Internet Gateway**, and **Route Table**
- Provisions a **t3.micro EC2 instance** with **Ubuntu 22.04**
- Automatically **installs Docker** via user data script
- **Appends SSH config** on your local machine (Windows or Linux/macOS) to enable 1-click connection with VS Code Remote SSH
- Dynamically restricts access to **your current public IP**

## 📸 Preview

Once applied, you'll be able to:

- SSH into your instance with:  
  `ssh demovpc`
- Or use **VS Code** Remote-SSH:
  - `Host: demovpc`
  - `User: ubuntu`
  - `IdentityFile: ~/.ssh/mtckey`

## 🧰 Requirements

- [Terraform](https://www.terraform.io/downloads)
- [AWS CLI](https://aws.amazon.com/cli/) configured with your credentials
- Python 3 with `requests` module (`pip install requests`)
- Git Bash or WSL (if you're on Windows)
- An existing SSH key pair (saved in `~/.ssh/`)

## 📂 Files

| File/Folder                  | Purpose                              |
|-----------------------------|--------------------------------------|
| `main.tf`                   | Core infrastructure definitions       |
| `variables.tf`              | Input variables                      |
| `terraform.tfvars`          | Your personal settings (not committed)|
| `userdata.tpl`              | Docker install script                |
| `linux-ssh-config.tpl`      | Template to update SSH config (Linux)|
| `windows-ssh-config.tpl`    | Template to update SSH config (Windows)|
| `get-my-ip.py`              | Script to auto-detect public IP      |
| `output.tf`                 | Outputs IP and useful SSH info       |
| `providers.tf`              | AWS provider configuration           |
| `.gitignore`                | Ignore Terraform state and cache     |

## 🚀 How to Use

```bash
git clone https://github.com/YOUR-USERNAME/terraform-aws-ec2-ssh.git
cd terraform-aws-ec2-ssh

# Customize your settings
vim terraform.tfvars

# Initialize Terraform
terraform init

# Apply the infrastructure
terraform apply
```

## 📌 Example `terraform.tfvars`

```hcl
region      = "eu-west-1"
aws_profile = "your-aws-profile-name"
host_os     = "windows" # or "linux"
```

## 🔐 Security Note

This project dynamically restricts SSH access to your **current public IP address** using the `external` data source and Python. Your IP is never exposed or logged.

## 🧠 Why This Project?

This project was built to demonstrate:
- Practical knowledge of Terraform
- Secure infrastructure design
- Dynamic user customization
- Automation for developer experience (VS Code integration)

It’s a great example to showcase Terraform + AWS skills on your CV or GitHub portfolio.

## 🧼 Cleanup

To destroy the infrastructure:

```bash
terraform destroy
```

## 🤝 License

MIT — use freely, but at your own risk. Contributions welcome.
