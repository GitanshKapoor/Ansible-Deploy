# 🚀 Ansible Deploy with Terraform and AWS CLI

This repository contains Terraform code to deploy and set up **Ansible** on a host (controller) server and **three child servers** using **Terraform** and **AWS CLI**.
Easily set up your own Ansible lab automatically 😉

---

## 📄 Description

This project automates the deployment of an Ansible infrastructure on AWS. It provisions:

- One EC2 instance as the **Ansible controller**
- Three EC2 instances as **child (managed) servers**

All resources are provisioned using **Terraform**, with **AWS CLI** used for supporting tasks like S3 bucket creation. Ansible is installed on the controller server and configured to manage the child nodes via SSH.

---

## ✅ Prerequisites

Before getting started, ensure you have:

- ✅ [AWS CLI (latest version)](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- ✅ [Terraform (latest version)](https://developer.hashicorp.com/terraform/install)
- ✅ An AWS account with permissions for EC2, S3, VPC, and IAM
- ✅ SSH access configured and `ssh-keygen` available in your terminal

---

## 🛠️ Setup Instructions

### 🔹 Step 1: Create S3 Bucket for Terraform Backend

Use AWS CLI to create an S3 bucket and folder named `backend/` for storing Terraform state remotely:

```bash
aws s3 mb s3://your-unique-bucket-name
aws s3api put-object --bucket your-unique-bucket-name --key backend/
```

Now, edit the backend configuration:

📄 File: /ansible deploy/backend.tf

Replace the placeholder values with your actual bucket name and AWS region:

backend.tf
``` file
terraform {
  backend "s3" {
    bucket = "your-unique-bucket-name"
    key    = "backend/terraform.tfstate"
    region = "your-region"
  }
}
```
<hr>

### 🔹 Step 2: Create SSH Key Pairs
Generate two separate SSH key pairs:

controller-key: for accessing the controller server

server-key: for accessing the child servers

``` bash
ssh-keygen -t rsa -f controller-key
ssh-keygen -t rsa -f server-key
```

⚠️ Note: Keep the .pem (private) files secure. Please do not share or commit them.
<hr>

### 🔹 Step 3: Configure AWS CLI
If not already configured, set up your AWS CLI credentials:

``` bash
aws configure
```

- You'll be prompted to enter:

``` bash
AWS Access Key ID
AWS Secret Access Key
AWS Region (e.g., us-east-1)
Output format (json)
```

<hr>

### 🔹 Step 4: Initialise and Apply Terraform
Navigate to the Terraform deployment directory:

``` bash
cd ansible-deploy/
```

- Run the following commands:

``` bash
terraform init -reconfigure
terraform apply
```
✅ Confirm the action when prompted.

Terraform will now:

Provision one EC2 controller instance

Provision three child EC2 instances

Set up VPC, subnets, security groups, and key pairs

Install Ansible on the controller

---
##  Project Structure

```sh
Ansible-Deploy.git/
├── Ansible-Playbooks/                    # Ansible configuration and automation
│   ├── Db.yaml                           # Playbook for database setup
│   ├── Inventory.yaml                    # Static Ansible inventory
│   ├── Play.yaml                         # General playbook
│   ├── Prov.yaml                         # Provisioning/configuration playbook
│   ├── Web.yml                           # Web server playbook
│   ├── addusr.yaml                       # User management playbook
│   ├── ansible.cfg                       # Ansible configuration file
│   ├── group_vars/                       # Group-wide variables
│   │   ├── all                           # Vars for all hosts
│   │   └── webserver                     # Vars for the webserver group
│   ├── host_vars/                        # Host-specific variables
│   │   └── web02                         # Vars for host "web02"
│   └── template/                         # Jinja2 templates for config management
│       ├── RHEL_conf.j2                  # RHEL system template
│       └── Ubuntu_conf.j2                # Ubuntu system template
│
└── Ansible Deploy/                       # Terraform infrastructure provisioning
    ├── .terraform/                       # Terraform plugin cache and state
    │   ├── providers/          
    │   └── terraform.tfstate            # Local Terraform state file
    ├── .terraform.lock.hcl              # Dependency lock file
    ├── Bucket.txt                       # Possibly defines S3 bucket info
    ├── InstID.tf                        # Holds instance ID outputs or inputs
    ├── Instance.tf                      # EC2 instance definition
    ├── KeyPair.tf                       # AWS key pair resource
    ├── SecurityGroup.tf                 # AWS security group configuration
    ├── backend.tf                       # Backend config (e.g., S3, remote state)
    ├── controller-key                   # SSH private key for controller
    ├── controller-key.pub               # SSH public key for controller
    ├── provider.tf                      # AWS provider block
    ├── server-key                       # SSH private key for server
    ├── server-key.pub                   # SSH public key for server
    └── vars.tf                          # Terraform input variables
```

---
### 📌 Output
After a successful deployment:

✅ One EC2 instance is running as the Ansible Controller

✅ Three EC2 instances are running as Child Nodes

✅ Ansible is installed and configured on the controller to manage the children via SSH


---
### 🧹 Cleanup
To destroy all the resources created by Terraform:

``` bash
terraform destroy
```
---
### 🛡️ Security Notes
- Never commit your .pem private key files.
- Use .gitignore to exclude them from version control.
- Rotate keys regularly in production environments.
