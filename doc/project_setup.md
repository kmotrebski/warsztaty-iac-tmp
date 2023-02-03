# Project setup

### Helper to rename Ubuntu terminal tabs

- to install it copy&paste below snippet inside `~/.bashrc` file:
```
function kotitle() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}
```
- you can than use it following way:
```
kotitle terraform-window
```


### Setting up project on fresh Ubuntu instance

- generate ssh key and set it up in GitHub via Firefox
```
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa && eval "$(ssh-agent -s)"
printf "This is your key:\n"
cat ~/.ssh/id_rsa.pub
firefox https://github.com/settings/keys
```
- installing git and pulling the project
```
sudo apt install git -y && \ 
mkdir -p ~/projects/warsztaty-iac && \
git clone git@github.com:kmotrebski/warsztaty-iac.git ~/projects/warsztaty-iac && \
cd ~/projects/warsztaty-iac
```

### Create AWS config and credentials file
- below paths are for Linux Ubuntu! Check [this doc file for other OS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-configuration-and-credentials-files).
- create config file `~/.aws/config`
```
mkdir -p ~/.aws
nano ~/.aws/config
```
- file contents:
```
[profile warsztaty_iac]
output = json
region = eu-central-1
```
- create credentials file `~/.aws/credentials`:
```
nano ~/.aws/credentials
```
- file contents:
```
[warsztaty_iac]
aws_access_key_id = your_key_id_here
aws_secret_access_key = your_secret_here
```
- fill in credentials with your own account data

### Installing all dependencies like Docker, Terraform, IDE

- run script
```
./helpers/new_developer.sh
```
- make sure script ended with `New developer finished!`

### Create ECR (Docker) registry and Docker image
- using Terraform create ECR infrastructure in `ecr.tf` file
- after creating the infrastructure Terraform should output `repository_url` which is your ECR URL
- create `development.env` file in project's top directory:
```
nano development.env
```
- file template:
```
WARSZTATY_AWS_DIR=~/.aws
WARSZTATY_REGION=eu-central-1

WARSZTATY_ECR_URL=1234567890.dkr.ecr.eu-central-1.amazonaws.com
WARSZTATY_IMAGE_DEV=1234567890.dkr.ecr.eu-central-1.amazonaws.com/php:dev
WARSZTATY_IMAGE_PROD=1234567890.dkr.ecr.eu-central-1.amazonaws.com/php:prod
```
- don't forget to replace `1234567890` above with your AWS account ID (or entire URL if you decided to change `eu-central-1` region to different)
- using `build_and_push_docker_images.sh` helper build Docker images and push `prod` one to ECR registry
```
./build_and_push_docker_images.sh
```
- see ECR URL displayed as Terraform output. Use it to fill in all data in `development.env` file in main directory
- install Composer dependencies using Docker wrapper
```
./helpers/composer.sh install
```
