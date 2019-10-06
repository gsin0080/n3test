# provider.tf

# Specify the provider and access details
# Note: change to profile instead of keys for security reasons.
provider "aws" {
    region     = var.aws_region
}

resource "aws_s3_bucket" "n3_bucket" {
    bucket  = "n3bucket"
    tags    = {
        Name = "s3 remote terraform state store"
    }
}

