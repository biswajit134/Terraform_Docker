# Provision a local Docker container using Terraform.
## Stpes:
### 1. Write the Docker provider block
   ![image_url](https://github.com/biswajit134/Terraform_Docker/blob/main/Screenshot/Screenshot%202026-02-16%20210747.png?raw=true))
### 2. Write the resource block
![image_url](https://github.com/biswajit134/Terraform_Docker/blob/main/Screenshot/Screenshot%202026-02-16%20210817.png?raw=true)
### 3. File structure
![image_url](https://github.com/biswajit134/Terraform_Docker/blob/main/Screenshot/Screenshot%202026-02-16%20210905.png?raw=true)
### 4. Initialize the terraform - terraform init
![image_url](https://github.com/biswajit134/Terraform_Docker/blob/main/Screenshot/Screenshot%202026-02-16%20211006.png?raw=true)
### 5. Type terraform plan
![image_url](https://github.com/biswajit134/Terraform_Docker/blob/main/Screenshot/Screenshot%202026-02-16%20211134.png?raw=true)
![image_url](https://github.com/biswajit134/Terraform_Docker/blob/main/Screenshot/Screenshot%202026-02-16%20211048.png?raw=true)
### 6. Type terraform apply --auto-approve
![image_url](https://github.com/biswajit134/Terraform_Docker/blob/main/Screenshot/Screenshot%202026-02-16%20211239.png?raw=true)
### 7. NGINX image and container in local 
![image_url](https://github.com/biswajit134/Terraform_Docker/blob/main/Screenshot/Screenshot%202026-02-16%20211455.png?raw=true)
### 8. Run nginx web server live on localhost:8000
![image_url](https://github.com/biswajit134/Terraform_Docker/blob/main/Screenshot/Screenshot%202026-02-16%20212058.png?raw=true)
### 9. At last distroy the whole infra
![image_url](https://github.com/biswajit134/Terraform_Docker/blob/main/Screenshot/Screenshot%202026-02-16%20211303.png?raw=true)

## Interview Questions:

### 1. What is IaC?
Infrastructure as Code (IaC) is the process of managing and provisioning computer data centers and cloud resources through machine-readable definition files, rather than through physical hardware configuration or manual, interactive tools (like clicking through a web console). It allows infrastructure to be version-controlled, tested, and treated just like application software.

### 2. How does Terraform work?
Terraform works by translating declarative configuration files (written in HashiCorp Configuration Language, or HCL) into API calls to cloud providers.

It operates in three main steps:

* Write: You write the configuration defining the resources you want.

* Plan: Terraform compares your configuration to the current state of the infrastructure and creates an execution plan detailing what needs to be created, updated, or destroyed.

* Apply: Terraform executes the plan, interacting with the target platform's APIs via Providers to provision the infrastructure.

### 3. What is a Terraform state file?
The state file (terraform.tfstate) is a JSON file that Terraform uses to map your real-world infrastructure to your configuration.

It acts as a database that keeps track of metadata, resource IDs, and the current state of your deployments. Without the state file, Terraform would not know which resources it manages, making it impossible to accurately update or destroy them later without causing conflicts.

Important Interview Note: You should never manually edit the state file, and for team environments, it should be stored in a remote backend (like AWS S3 with DynamoDB for state locking) rather than locally.

### 4. Difference between plan and apply
* terraform plan (The Dry Run): This command evaluates your code and the current state file to generate an execution plan. It shows you exactly what changes will be made to your infrastructure, but it does not make any actual changes.

* terraform apply (The Execution): This command takes the execution plan and actually builds, modifies, or tears down the real-world infrastructure to match your desired configuration.

### 5. What are Terraform providers?
Providers are plugins that allow Terraform to interact with cloud platforms (like AWS, Azure, GCP), SaaS platforms (like Datadog or GitHub), and other APIs. Terraform Core relies on these providers to translate the HCL code into the specific API calls required by the target platform.

### 6. What is resource dependency?
Resource dependency occurs when one piece of infrastructure must be created before another because the second resource relies on the first. Terraform builds a dependency graph to determine the correct order of resource creation.

* Implicit Dependency: Terraform automatically figures this out when you reference one resource's attribute inside another (e.g., using a VPC ID to create a Subnet). This is the preferred method.

* Explicit Dependency: When Terraform cannot figure out the relationship automatically (e.g., a software installation script that needs an EC2 instance to be fully booted), you use the depends_on meta-argument to manually force the order.

### 7. How do you handle secret variables?
Handling secrets requires strict security practices to prevent them from leaking in logs or version control:

* Never hardcode secrets in your .tf files.

* Use environment variables (prefixed with TF_VAR_) or a secure .tfvars file that is strictly ignored by .gitignore.

* Mark the variable with sensitive = true in your configuration. This prevents Terraform from printing the secret to the console output during plans and applies.

* Fetch secrets dynamically at runtime using secure storage services like AWS Secrets Manager, Azure Key Vault, or HashiCorp Vault.

  Crucial Caveat: Even if marked as sensitive, the secret will still be stored in plain text inside the Terraform state file. Therefore, encrypting the remote state bucket and restricting access via IAM roles is mandatory.

### 8. Explain the benefits of Terraform
* Platform Agnostic: Unlike AWS CloudFormation or Azure ARM templates, Terraform can manage multi-cloud deployments from a single workflow.

* Declarative Code: You describe the desired end state, and Terraform figures out the steps to get there. You don't have to write procedural scripts step-by-step.

* State Management: It keeps an accurate blueprint of your environment, preventing configuration drift and making updates safe and predictable.

* Modularity: You can bundle configurations into reusable Terraform Modules, saving time and enforcing standardization across teams.

* Massive Ecosystem: It has thousands of official and community-supported providers.
