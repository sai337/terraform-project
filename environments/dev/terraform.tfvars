cidr_block           = "10.0.0.0/22"
public_subnet_cidrs  = ["10.0.3.0/26", "10.0.3.64/26", "10.0.3.128/26"]
private_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
az_count             = 3
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]