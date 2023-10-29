# EC2-Terraform
# Instructions

1. Create tf directory to house tf files

   ``
   mkdir terraform ansible
   ``

2. Switch to terraform directory, create empty tf files and begin to add necessary code to build out infrastructure

   ``
   cd terraform; touch ec2.tf variables.tf vpc.tf provider.tf
   ``

3. Once infrastructure is deployed ssh into the server to create the directory Ansible & the yml files that will be executed

    ``
   ssh -i (key_file created in tf code) ubuntu@public_ip; mkdir Ansible; touch packages.yml main.yml users.yml groups.yml
   ``

4. Install Ansible onto server

   ``
   sudo apt update
   ``
   ``
   sudo apt install software-properties-common
   ``
   ``
   sudo apt-add-repository --yes --update ppa:ansible/ansible
   ``
   ``
   sudo apt install ansible
   ``
   
6. Run command ``ansible-playbook main.yml`` to push tasks on localhost
