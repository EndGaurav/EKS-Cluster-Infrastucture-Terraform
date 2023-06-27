# EKS-Cluster-Infrastucture-Terraform
- I have created this infrastucture using best practices of terraform code.
- Every resource of aws for eks cluster, i have created in module directory.
- And terraform.tfvars file, i have created in config directory.
- Using .tfvars extension you can create infrastructure for different different stages.
- I have created EKS node in private subnet for security purpose.
  
# Following resources i have created:-
- aws vpc.
- aws 4 subnet : 2 public subnet and 2 private subnet.
- aws route table.
- aws route table association.
- aws internet gateway.
- aws NAT gateway for private subnets.
- aws elastic ip.
- aws EKS cluster.
- aws EKS Node group.

# What's After this:-
- I have created end to end jenkins declarative pipeline.
- I have pulled code from github and deploy it on this EKS Cluster.
- Must checkout that repository.
- repo url: https://github.com/EndGaurav/demo-counter-app 
