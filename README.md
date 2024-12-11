# acsProject




# In the network folder
terraform apply -var-file="../common.tfvars"

# In the webserver folder
terraform apply -var-file="../common.tfvars"

#Add cloud9 security group in network/sg.tf:

data "aws_security_group" "cloud9_sg" {
  filter {
    name   = "group-name"
    values = ["sg-076247a61a1ffb4c4"]
  }