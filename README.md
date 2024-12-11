# acsProject

- Make sure terraform, aws cli are installed in your root directory 
- Make your your bucket name as u created
- change the config.tf in network & backend.tf + config.tf in webserver folders
- It will also create the cloud 9 for you as well
- git clone the project in cloud 9 as well(only for ansible), install ansible in cloud9

In cloud 9:
mkdir project
cd project

git clone https://github.com/HamzaSid020/acsProject.git .
cd Ansible
sudo yum update -y
sudo yum install python3-pip -y
pip install boto3 botocore
sudo pip install ansible
ansible --version

chmod 400 ../Webserver/project_key

ansible-playbook playbook_deploy.yaml -i aws_ec2.yaml --private-key ../Webserver/project_key
 you will then have to go to alb and click on the dns name to check the fluctuating/ toggle images on different images

To do in Vscode again:
- replace the key_pair to be your own machine's, but keep the name same and in the same directory as current

cd Network
tf init 
tf plan 
tf apply
tf apply --auto-approve

cd Webserver 
tf init -reconfigure 
tf plan 
tf apply
tf apply --auto-approve
