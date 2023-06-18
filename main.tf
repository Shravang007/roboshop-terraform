module "instances" {
  for_each  = var.components
  source    = "git::https://github.com/Shravang007/tf-module-app.git"
  name = each.key
  env       = var.env
}



