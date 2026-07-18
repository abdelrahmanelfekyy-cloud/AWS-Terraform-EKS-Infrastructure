terraform {
  backend "s3" {
    bucket  = "my-packet-1"
    key     = "key3"
    region  = "us-east-1"
    profile = "abdelrahman"
  }

}
