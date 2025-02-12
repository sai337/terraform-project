terraform {
    backend "s3" {
    bucket         = "terraform-statebucket-s3"           
    key            = "state/vpc/terraform.tfstate"  
    region         = "us-east-1"                    
    encrypt        = true                           
    # dynamodb_table = "my-terraform-locks"           # Optional: DynamoDB table for state locking
    }
}
