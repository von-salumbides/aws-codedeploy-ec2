//SECURITY GROUP(S)
module "security-group-ec2" {
  source        = "git::https://github.com/von-salumbides/terraform-module.git//aws-security-group?ref=v0.1.1"
  config        = "EC2"
  vpc           = var.vpc
  env           = var.env
  project       = var.project
  source_id_var = {}
}