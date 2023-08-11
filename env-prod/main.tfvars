env = "prod"

tags = {
  company_name  = "XYZ Tech"
  business      = "ecommerce"
  business_unit = "retail"
  cost_center   = "322"
  project_name  = "roboshop"
}

 vpc = {
  main = {
    cidr_block = "10.10.0.0/16"
    subnets  = {
      web     = { cidr_block = ["10.10.0.0/24", "10.10.1.0/24"] }
      app     = { cidr_block = ["10.10.2.0/24", "10.10.3.0/24"] }
      db      = { cidr_block = ["10.10.4.0/24", "10.10.5.0/24"] }
      public  = { cidr_block = ["10.10.6.0/24", "10.10.7.0/24"] }
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
    instance_class          = "db.t3.medium"
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
    node_type               = "cache.t3.medium"
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
    component          = "cart"
    app_port           = 8080
    instance_type      = "t3.micro"
    desired_capacity   = 2
    max_size           = 5
    min_size           = 2
    subnet_ref         = "app"
    lb_ref             = "private"
    lb_rule_priority   = 100
  }
  catalogue = {
    component          = "catalogue"
    app_port           = 8080
    instance_type      = "t3.small"
    desired_capacity   = 2
    max_size           = 5
    min_size           = 2
    subnet_ref         = "app"
    lb_ref             = "private"
    lb_rule_priority   = 101
    extra_param_access = ["arn:aws:ssm:us-east-1:752442278108:parameter/roboshop.prod.docdb.*"]
  }
  user = {
    component          = "user"
    app_port           = 8080
    instance_type      = "t3.small"
    desired_capacity   = 2
    max_size           = 5
    min_size           = 2
    subnet_ref         = "app"
    lb_ref             = "private"
    lb_rule_priority   = 102
    extra_param_access = ["arn:aws:ssm:us-east-1:752442278108:parameter/roboshop.prod.docdb.*"]
  }
  shipping = {
    component          = "shipping"
    app_port           = 8080
    instance_type      = "t3.medium"
    desired_capacity   = 3
    max_size           = 6
    min_size           = 3
    subnet_ref         = "app"
    lb_ref             = "private"
    lb_rule_priority   = 103
    extra_param_access = ["arn:aws:ssm:us-east-1:752442278108:parameter/roboshop.prod.mysql.*"]

  }
  payment = {
    component        = "payment"
    app_port         = 8080
    instance_type    = "t3.small"
    desired_capacity = 2
    max_size         = 5
    min_size         = 2
    subnet_ref       = "app"
    lb_ref           = "private"
    lb_rule_priority = 104
  }
  frontend = {
    component        = "frontend"
    app_port         = 80
    instance_type    = "t3.small"
    desired_capacity = 2
    max_size         = 5
    min_size         = 2
    subnet_ref       = "web"
    lb_ref           = "public"
    lb_rule_priority = 100
  }
}

  eks = {
    main = {
    subnet_ref     = "app"
    min_size       = 2
    max_size       = 2
    capacity_type  = "SPOT"
    instance_types= ["m2.2xlarge", "m2.xlarge", "m3.2xlarge" ]

#    instance_types = ["t3.xlarge", "t3.large", "t3.medium"]
  }
}



