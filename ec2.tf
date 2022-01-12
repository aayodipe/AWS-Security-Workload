
# //Port Number
# variable "server_port" {
#     type = number
#     description = "The Port Number that the server will use"
#     }

# //cidr_block
# variable "cidr_block_range" {
#     type= list(string)
#     default = ["0.0.0.0/16"]
# }

# # resource "aws_instance" "example" {
# #      ami = "ami-087c17d1fe0178315"
# #     instance_type = "t2.micro"
# #     vpc_security_group_ids =  [aws_security_group.instance.id]

# #     user_data = <<-EOF
# #              #!/bin/bash
# #             echo 'Hello, World'' > index.html
# #             nohup busybox httpd -f -p ${var.server_port} &
# #             EOF

# #     tags = {
# #       Name = "Oreilly Server"
# #      }
# # }

# resource "aws_security_group" "instance" {
#     name = "terraform-example-instance"
#     ingress {
#         from_port =var.server_port
#         to_port=var.server_port
#         protocol ="tcp"
#         cidr_blocks = [var.cidr_block_range[0]]
#     }
# }


# # output "public_ip"{
# #     value = aws_instance.example.public_ip
# #     description = "The public IP address of the web server"
# # }


# resource "aws_launch_configuration" "example" {
#   image_id        = "ami-0c55b159cbfafe1f0"
#   instance_type   = "t2.micro"
#   security_groups = [aws_security_group.instance.id]

#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, World" > index.html
#               nohup busybox httpd -f -p ${var.server_port} &
#               EOF
# }

# resource "aws_autoscaling_group" "example" {
#   launch_configuration = aws_launch_configuration.example.name

#   min_size = 2
#   max_size = 10

#   tag {
#     key                 = "Name"
#     value               = "terraform-asg-example"
#     propagate_at_launch = true
#   }
# }