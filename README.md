# acsProject

- Make sure terraform, aws cli are installed in your root directory 
- Make your your bucket name as u created
- change the config.tf in network & backend.tf + config.tf in webserver folders
- It will also create the cloud 9 for you as well
- git clone the project in cloud 9 as well(only for ansible)
- replace the key_pait to be your own machine's, but keep the name same and in the same directory as current

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

# In the network folder
terraform apply

# In the webserver folder
terraform apply
