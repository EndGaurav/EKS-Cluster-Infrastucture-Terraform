region = "us-east-1"
    
vpc_config = {
    vpc01 = {
        cidr_block = "192.168.0.0/16"
        tags = {
            "Name" = "myvpc"
        }
    }
}

subnet_config = {

    "public-us-east-1a" = {
        vpc_name = "vpc01"
        cidr_blocks = "192.168.0.0/18"
        availability_zone = "us-east-1a"
        tags = {
            "Name" = "public-us-east-1a"
        }
    }
    "public-us-east-1b" = {
        vpc_name = "vpc01"
        cidr_blocks = "192.168.64.0/18"
        availability_zone = "us-east-1b"
        tags = {
            "Name" = "public-us-east-1b"
        }
    }
    "private-us-east-1a" = {
        vpc_name = "vpc01"
        cidr_blocks = "192.168.128.0/18"
        availability_zone = "us-east-1a"
        tags = {
            "Name" = "private-us-east-1a"
        }
    }
    "private-us-east-1b" = {
        vpc_name = "vpc01"
        cidr_blocks = "192.168.192.0/18"
        availability_zone = "us-east-1b"
        tags = {
            "Name" = "private-us-east-1b"
        }
    }
}

internetGW_config = {
    igw01 = {
        vpc_name = "vpc01"
        tags = {
            "Name" = "my-IGW"
        }
    }
}

eip_config = {
    eip01 = {
        tags = {
            "Name" = "eip01"
        }
    }

    eip02 = {
        tags = {
            "Name" = "eip02"
        }
    }
}

nat_GW_config = {
    natgw01 = {
        elastic_name = "eip01"
        subnet_name = "public-us-east-1a"
        tags = {
            "Name" = "natgw01"
        }
    }
    natgw02 = {
        elastic_name = "eip02"
        subnet_name = "public-us-east-1b"
        tags = {
            "Name" = "natgw02"
        }
    }
}
route_table_config = {
    RT01 = {
        private = 0
         vpc_name = "vpc01"
         gataway_name = "igw01"
         tags = {
            "Name" = "Public-route"
         }

    }
    RT02 = {
        private = 1
        vpc_name = "vpc01"
         gataway_name = "natgw01"
         tags = {
            "Name" = "Private-route"
         }
    }
    RT03 = {
        private = 1
        vpc_name = "vpc01"
         gataway_name = "natgw02"
         tags = {
            "Name" = "Private-route"
         }
    }
}

route_table_association = {
    RT-01Association = {
        subnet_name = "public-us-east-1a"
        route_table_name = "RT01"
    }
    RT-02Association = {
         subnet_name = "public-us-east-1b"
         route_table_name = "RT01"
    }
    RT-03Association = {
         subnet_name = "private-us-east-1a"
         route_table_name = "RT02"
    }
    RT-04Association = {
         subnet_name = "private-us-east-1b"
         route_table_name = "RT03"
    }
}


eks_cluster_config = {
    "Master-Node-1" = {
        aws_eks_cluster_name = "Master-Node-1"
        subnet1 = "public-us-east-1a" 
        subnet2 = "public-us-east-1b" 
        subnet3 = "private-us-east-1a" 
        subnet4 = "private-us-east-1b" 
    
        tags = {
            "Name" = "Master-Node-1"
        }
    }
}

eks_nodegroup_config = {
    "node01" = {
        eks_cluster_name = "Master-Node-1"
        node_group_name = "node01"
        node_role_name = "eks_node_general_role1"
        subnet1 = "private-us-east-1a" 
        subnet2 = "private-us-east-1b" 
        
        tags = {
            "Name" = "Node01"
        }
    }
    # "node02" = {
    #     eks_cluster_name = "CP01"
    #     node_group_name = "node02"
    #     node_role_name = "eks_node_general_role1"
    #     subnet1 = "private-us-east-1a" 
    #     subnet2 = "private-us-east-1b" 

    #     tags = {
    #         "Name" = "Node02"
    #     }
    # }
}
