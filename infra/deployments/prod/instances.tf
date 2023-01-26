//module "instance1" {
//  source = "../../modules/instance"
//
//  instance_name = "otrebski3"
//  ecr_url = aws_ecr_repository.php.repository_url
//
//  ssh_key = file("../../ssh_keys/konrad.pub")
//  instance_unique_variable = "zabawy_w_niedziele3"
//}
//
//output "instance_ip" {
//  value = module.instance1.instance_ip
//}
