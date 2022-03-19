# repeatable-infrastructure
Building Repeatable Infrastructure with Terraform and Ansible on AWS
High degree of automation can be achieved by these use cases for Repeatable Infrastructure:
- Dynamic infrastructure
- Repeatable Processes (DevOps Automation)
- Self-Documented Systems and Processes
- Multi-Cloud Deployment
- Idempotent (making repeatedly REST API calls while producing the same result)
- Moving from stateful to stateless
- Scaling policy, reduce resources at night and scale back in the morning.
- Disposable Environments
- Resilient platform
- Configuration Drift detection (avoid configuration drift at the infrastructure layer)
- Durability of data
- Software-Defined Networking (SDN)
- Provision of new servers in minutes or seconds.

## Ansible and Terraform compilation
(IaC ) Infrastructure as Code “Terraform” and (CM) Configuration Management “Ansible”
Ansible is a lot easier to configure for software setup. Terraform is excellent for the provision of the infrastructure,
Simple architecture:
 ![architecture](https://github.com/ahmedbadawy4/repeatable-infrastructure/files/architecture.png)

 Dynamic infrastructure must be treated as a first class citizen in any cloud project,
 You can deploy the same infrastructure in development, test and production environments; the sizing can be parameterize.

 ## Setting up the environment:
This guide assumes that you already have some understanding of AWS and have a working account. The installation of Terraform and Ansible are straightforward

### Prerequisites:
- [AWSCLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (Install AWS CLI)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) (Install Terraform)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (Install Ansible)
- [SSH-Keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
  Note: we will use public and private keys to handle ansible user communication

