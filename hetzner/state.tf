terraform {
  backend "s3" {                                # Backend designation
    bucket  = "hetzner-terraform-caixeta"       # Bucket name
    key     = "sandbox-state/terraform.tfstate" # Key
    region  = "eu-central-1"                    # Region
    encrypt = "true"                            # Encryption enabled
  }
}
