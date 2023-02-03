
### Create S3 bucket and DynamoDB table
- those will be used for remote state and for state locking (so that multiple developers can press `terraform apply` at the same time)
- uncomment code in [infra/deployments/prod/state.tf](https://github.com/kmotrebski/warsztaty-iac-tmp/blob/master/infra/deployments/prod/state.tf)
- change S3 bucket name to your unique name because it must be unique globally (I am assuming somebody will go through this tutorial but maybe I am idealistic)
- `terraform apply` changes

### Switch from local to remote state
- comment [local state configuration](https://github.com/kmotrebski/warsztaty-iac-tmp/blob/f803930a29f945897eacb1d3f3500d03be64db6c/infra/deployments/prod/meta.tf#L10-L11) and uncomment [remote S3 state](https://github.com/kmotrebski/warsztaty-iac-tmp/blob/f803930a29f945897eacb1d3f3500d03be64db6c/infra/deployments/prod/meta.tf#L2-L8)
- `terraform init` with state migration option
```
./terraform init -migrate-state
```

### Create EC2 instance
- copy&paste your public ssh key to `infra/ssh_keys/your_key.pub` file
- uncomment code in [`infra/deployments/prod/instances.tf` file](https://github.com/kmotrebski/warsztaty-iac-tmp/blob/master/infra/deployments/prod/instances.tf)
- run `terraform init` and them `... apply` changes (that is create module infrastructure). Wait few minutes till infrastructure gets created.
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

- set up project on 2x separate laptops (simple: or in different directory)
- introduce some change to infrastructure, e.g. change `instance_name`
- commit this change to git and make sure it is present in both projects. We need to motivate terraform to start introducing changes.
- execute `terraform apply` (you don't need to type `yes`, make terraform wait for your yes)
- try to execute `terraform apply` on different laptop
