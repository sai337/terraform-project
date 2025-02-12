module "vpc" {
    source = "../../modules/vpc"
    cidr_block           = var.cidr_block 
    # "10.0.0.0/22"
    public_subnet_cidrs  = var.public_subnet_cidrs
    # ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    private_subnet_cidrs = var.private_subnet_cidrs
    # ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    azs                  = var.azs
    # ["us-west-2a", "us-west-2b", "us-west-2c"]
}
