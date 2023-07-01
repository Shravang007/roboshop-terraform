#module "instances" {
#  for_each  = var.components
#  source    = "git::https://github.com/Shravang007/tf-module-app.git"
#  component = each.key
#  env       = var.env
#  tags      = merge(each.value["tags"], var.tags)
#}
#
#

module "vpc" {
  for_each  = var.vpc
  source    = "git::https://github.com/Shravang007/tf-module-vpc.git"
  cidr_block = each.value["cidr_block"]
  env       = var.env
  tags      = merge(each.value["tags"], var.tags)

}