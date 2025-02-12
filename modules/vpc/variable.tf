variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16" 
}

# variable "public_subnet_cidrs" {
#     description = "List of CIDR blocks for the public subnets"
#     type        = list(string)
#     default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# }
variable "subnet_cidrs" {
    description = "Subnets CIDR blocks"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# Add the new public_subnet_cidrs variable
variable "public_subnet_cidrs" {
    description = "CIDR blocks for the public subnets"
    type        = list(string)
}
variable "private_subnet_cidrs" {
    description = "List of CIDR blocks for the private subnets"
    type        = list(string)
   
}
 #default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

variable "azs" {
    description = "Availability zones for the subnets"
    type        = list(string)
}

variable "az_count" {
    description = "Number of availability zones"
    type        = number
    default     = 3
}