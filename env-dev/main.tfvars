env = "dev"


#components = {
#
#  frontend = {
#    tags = { Monitor = "true", env = "dev" }
#  }
#  mongodb = {
#    tags = { env = "dev" }
#  }
#  catalogue = {
#    tags = { Monitor = "true", env = "dev" }
#  }
#  redis = {
#    tags = { env = "dev" }
#  }
#  user = {
#    tags = { Monitor = "true", env = "dev" }
#  }
#  cart = {
#    tags = { Monitor = "true", env = "dev" }
#  }
#  mysql = {
#    tags = { env = "dev" }
#  }
#  shipping = {
#    tags = { Monitor = "true", env = "dev" }
#  }
#  rabbitmq = {
#    tags = { env = "dev" }
#  }
#  payment = {
#    tags = { Monitor = "true", env = "dev" }
#  }
#}

  tags = {
    company_name  = "XYZ Tech"
    business      = "ecommerce"
    business_unit = "retail"
    cost_center   = "322"
    project_name  = "roboshop"
  }

  vpc = {
   main = {
     cidr_block = "10.0.0.0/16"
     subnets  = {
        web     = { cidr_block = ["10.0.0.0/24", "10.0.1.0/24"] }
        app     = { cidr_block = ["10.0.2.0/24", "10.0.3.0/24"] }
        db      = { cidr_block = ["10.0.4.0/24", "10.0.5.0/24"] }
        public  = { cidr_block = ["10.0.6.0/24", "10.0.7.0/24"] }
     }
   }
 }

  default_vpc_id = "vpc-0f2281b96b66a8907"
  default_vpc_rt = "rtb-0eba10399021f8ac0"
  allow_ssh_cidr = [ "172.31.4.166/32" ]
  zone_id        = "Z08411971YPWLUUTH65Y1"
  kms_key_id     = "65440a1c-b9ad-4ac4-9614-e06631037055"
  kms_key_arn    = "arn:aws:kms:us-east-1:752442278108:key/65440a1c-b9ad-4ac4-9614-e06631037055"


rabbitmq     = {
  main       = {
    instance_type = "t3.small"
    component     = "rabbitmq"
  }
}

rds = {
  main = {
    component               = "rds"
    engine                  = "aurora-mysql"
    engine_version          = "5.7.mysql_aurora.2.11.3"
    database_name           = "dummy"
    instance_count          = 1
    instance_class          = "db.t3.small"
  }
}

documentdb = {
    main      = {
      component         = "docdb"
      engine            = "docdb"
      engine_version    = "4.0.0"
      instance_class    = "db.t3.medium"
      db_instance_count = 1
    }
}

elasticache = {
  main = {
    component               = "elasticache"
    engine                  = "redis"
    engine_version          = "6.2"
    replicas_per_node_group = 1
    num_node_groups         = 1
    node_type               = "cache.t3.micro"
    parameter_group_name    = "default.redis7"
  }
}

alb = {
  public = {
    name               = "public"
    internal           = false
    load_balancer_type = "application"
    subnet_ref         = "public"
  }
  private = {
    name               = "private"
    internal           = true
    load_balancer_type = "application"
    subnet_ref         = "app"

  }
}

apps = {
  cart = {
    component        = "cart"
    app_port         = 8080
    instance_type    = "t3.micro"
    desired_capacity = 1
    max_size         = 1
    min_size         = 1
    subnet_ref       = "app"
    lb_ref           = "private"
    lb_rule_priority = 100
  }
}