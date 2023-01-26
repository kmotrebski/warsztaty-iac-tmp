
#https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax
resource "null_resource" "install_docker_and_run_php_image" {

  depends_on = [
    aws_instance.instance,
  ]

  triggers = {
    instance_id = aws_instance.instance.id,
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    host = aws_eip.ip.public_ip
    port = 22
  }

  provisioner "file" {
    source      = "${path.module}/install_docker.sh"
    destination = "/tmp/install_docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_docker.sh",
      "/tmp/install_docker.sh",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${var.ecr_url}",
      "docker pull ${var.ecr_url}:prod",
      "docker run -d -p 80:80 --rm --name my-running-app --env WARSZTATY_INSTANCE_ID=${var.instance_unique_variable} ${var.ecr_url}:prod"
    ]
  }
}
