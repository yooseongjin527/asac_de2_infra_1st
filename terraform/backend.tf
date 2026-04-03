terraform {
  backend "s3" {
    bucket         = "my-raffle-app-tfstate-829a9161"  # bootstrap output 값으로 교체
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "my-raffle-app-tflock"
    encrypt        = true
  }
}