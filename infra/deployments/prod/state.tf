//resource "aws_s3_bucket" "state" {
//  bucket = "2022-warsztaty-state"
//  force_destroy = true
//}
//
//resource "aws_s3_bucket_acl" "state-acl" {
//  bucket = aws_s3_bucket.state.id
//  acl = "private"
//}
//
////potrzebne aby korzystać z tzw. state locka czyli żeby dwóch programistów nie wcisnęło w tym samym czasie `terraform apply`
//resource "aws_dynamodb_table" "state-lock" {
//  name = "state-lock-dynamo"
//  hash_key = "LockID"
//  billing_mode = "PAY_PER_REQUEST"
//
//  attribute {
//    name = "LockID"
//    type = "S"
//  }
//}
