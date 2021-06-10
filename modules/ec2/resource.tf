data "template_file" "script" {
  template = file(format("%s/bootstrap.sh.tpl", path.module))


  vars = {
    USER          = "sre_admin"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.script.rendered
  }
}

resource "aws_key_pair" "tech_test" {
  key_name   = "admin_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCgDstIk4DNKx0CJ1QeEfVubxqcGpUL4lKG59A94n4nyzqAIgeldkq68KWEWmBdTudTFxTuy57dTPQq/LBLidM2qQBSC97V8L0CDF5vqdbrsd8lFGgJMOwuPyOJM/W65TGKSpW7vecDKDb9bSVZXg3OxylgCr53kKDFaLDnXQoSxrxrNsOHwsGmBURrf+N/WC2I8M7qYLwUGgXbD/COCA7Q9wEJfGSc4xO/XdKwOdn8zpsHjCajE7QkQ+YP5YPN+AYjFRBOpGIWLthqXJqy5CeDaNDPuq+EWYeYj2vnCw/soWE9x9MDvEZaoSRqCQ6Xod7QKB5ZFTCT7sqMgVIlvceEJ0U++VIHe+Vk0SDNOuOzOjJnRojkdrTT76p2l9nKvJi3uwjHeDN0lqo6J4pKULQD8ScY4T2yjIw0by6EQf7oaSNfBIpdxpwZgGFzGPBHS82vT/xtKhWEqXGzLVBTrtd0EiDf8a33FV+ZdRNK75u9+JW3r7mlmi3lfXb+3n3EiLs="
}

resource "aws_instance" "instance" {

  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = var.security_groups
  associate_public_ip_address = var.public_ip
  user_data_base64            = data.template_cloudinit_config.config.rendered


  tags = {
    Name = var.name
  }
}