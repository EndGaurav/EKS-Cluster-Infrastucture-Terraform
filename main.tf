module "vpc_module" {
  source = "./module/aws_vpc"
  for_each = var.vpc_config
  cidr_block = each.value.cidr_block
  tags = each.value.tags
}

module "aws_subnet" {
  source = "./module/aws_subnet"
  for_each = var.subnet_config
  vpc_id = module.vpc_module[each.value.vpc_name].vpc_id
  subnet_cidr_block = each.value.cidr_blocks
  availability_zone = each.value.availability_zone
  tags = each.value.tags
}

module "internetGW_module" {
  source = "./module/aws_internet_gateway"
  for_each = var.internetGW_config
  vpc_id =  module.vpc_module[each.value.vpc_name].vpc_id
  tags = each.value.tags
}

module "natGW_module" {
  source = "./module/aws_NATGW"
  for_each = var.nat_GW_config
  elasticIP_id = module.eip_module[each.value.elastic_name].elastic_IP_id
  subnet_id = module.aws_subnet[each.value.subnet_name].subnet_id
  tags = each.value.tags
}

module "eip_module" {
  source = "./module/aws_eip"
  for_each = var.eip_config
  tags = each.value.tags
}

module "route_table_module" {
  source = "./module/aws_route_table"
  for_each = var.route_table_config
  vpc_id =  module.vpc_module[each.value.vpc_name].vpc_id 
  internetGW_id = each.value.private == 0 ? module.internetGW_module[each.value.gataway_name].internetGW_id : module.natGW_module[each.value.gataway_name].NAT_id
  tags =  each.value.tags
}

module "route_table_association_module" {
  source = "./module/aws_route_table_association"
  for_each = var.route_table_association
  subnet_id = module.aws_subnet[each.value.subnet_name].subnet_id 
  route_table_id = module.route_table_module[each.value.route_table_name].route_table_id 
}

module "eks_module" {
  source = "./module/aws_eks"
  for_each = var.eks_cluster_config
  aws_eks_cluster_name = each.value.aws_eks_cluster_name
  subnet_ids = [module.aws_subnet[each.value.subnet1].subnet_id, module.aws_subnet[each.value.subnet2].subnet_id, module.aws_subnet[each.value.subnet3].subnet_id, module.aws_subnet[each.value.subnet4].subnet_id]
  tags = each.value.tags
}



module "eks_nodegroup_module" {
  source = "./module/aws_eks_nodegroup"
  for_each = var.eks_nodegroup_config
  eks_cluster_name = each.value.eks_cluster_name
  node_group_name = each.value.node_group_name
  node_role_name = each.value.node_role_name
  subnet_ids = [module.aws_subnet[each.value.subnet1].subnet_id, module.aws_subnet[each.value.subnet2].subnet_id]
  tags = each.value.tags
}

