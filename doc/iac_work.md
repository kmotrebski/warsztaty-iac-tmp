
### Create S3 bucket and DynamoDB table
- those will be used for remote state and for state locking (so that multiple developers can press `terraform apply` at the same time)
- uncomment `state.tf` (see [commit here](https://github.com/kmotrebski/warsztaty-iac/commit/18c0771e189f35eadecd6b8ac1b9d3d339b1baff))
- change S3 bucket name to your unique name because it must be unique globally
- `terraform apply` changes

### Switch from local to remote state
- comment local state configuration and uncomment remote S3 state [as in this commit](https://github.com/kmotrebski/warsztaty-iac/commit/5fc0f537e1eebda23c7c24285b993d506638d945)
- `terraform init` with state migration option
```
./terraform init -migrate-state
```

### Create EC2 instance
- uncomment code in `instances.tf` file as in [this commit](https://github.com/kmotrebski/warsztaty-iac/commit/69b3bdafd7eb302b61382c7536495792c2564017)
- apply changes
### Run tests from main directory
```
./terraform_apply_and_tests.sh
```

### State lock experiment

Goal: see this kind of error when trying `terraform apply` by two different developers at the same time:
```
./terraform apply
╷
│ Error: Error acquiring the state lock
│ 
│ Error message: ConditionalCheckFailedException: The conditional request failed
│ Lock Info:
│   ID:        a9781225-0f45-c5bc-e2e8-b01b332730ef
│   Path:      2022-warsztatyf-state/terraform.tfstate
│   Operation: OperationTypeApply
│   Who:       miglanc2@miglancowy2
│   Version:   1.2.3
│   Created:   2022-11-06 21:23:53.423120048 +0000 UTC
│   Info:      
│ 
│ 
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.
╵
```

- set up project on 2x separate laptops (or different directories should work too)
- execute `terraform apply` (you don't need to type `yes`, make terraform wait for your yes)
- try to execute `terraform apply` on different laptop
