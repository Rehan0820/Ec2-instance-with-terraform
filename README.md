# 🚀 Terraform AWS EC2 Deployment

This project provisions an **EC2 instance** on AWS using **Terraform**.  
It automates the setup of:

- ✅ SSH key pair
- ✅ Default VPC usage
- ✅ Security group (allowing SSH, HTTP, and port 8000)
- ✅ EC2 instance (`t2.micro`) with a 15GB gp3 root volume
- ✅ Tags for better resource management

---
## ⚙️ Resources Created

### 1. **Key Pair**
- Key name: `terra-key-ec2`
- Uses the public key from `Terra-key-pair.pub`

### 2. **VPC**
- Uses the AWS default VPC

### 3. **Security Group**
- Name: `automate-sg`
- Ingress rules:
  - Port 22 → SSH
  - Port 80 → HTTP
  - Port 8000 → Custom app access
- Egress rules:
  - All outbound traffic allowed

### 4. **EC2 Instance**
- Instance type: `t2.micro` (Free Tier eligible)
- AMI: `ami-0d1b5a8c13042c939` (Amazon Linux 2 AMI, region-specific)
- Root volume: 15GB gp3
- Tags: 
  - `Name = automate-ec2`
  - `Environment = Development`

---
## 🛠️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- AWS CLI configured with IAM user credentials:
  ```bash
  aws configure
A valid AWS account

🚀 Usage

Clone this repository:

git clone https://github.com/<your-username>/<repo-name>.git
cd <repo-name>


Initialize Terraform:

terraform init


Validate configuration:

terraform validate


Apply the configuration:

terraform apply -auto-approve


Once created, Terraform will output the instance details.

🛑 Clean Up

To avoid unwanted AWS charges, destroy the resources:

terraform destroy -auto-approve

📌 Notes

Make sure your AWS region supports the AMI ID ami-0d1b5a8c13042c939.
If not, replace it with a region-specific AMI.

Use the corresponding private key for SSH login:

ssh -i Terra-key-pair.pem ec2-user@<public-ip>

📜 License

This project is licensed under the MIT License.

