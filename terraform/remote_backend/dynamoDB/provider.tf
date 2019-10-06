# provider.tf

# Specify the provider and access details
# Note: change to profile instead of keys for security reasons.
provider "aws" {
    region     = var.aws_region
}

resource "aws_dynamodb_table" "terraform_state_lock" {
    name           = "terraform-lock"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}
