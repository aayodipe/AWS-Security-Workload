

# # ami-0ed9277fb7eb570c9
# #Instances
# resource "aws_instance" "web" {
#   ami           = "ami-0ed9277fb7eb570c9"
#   instance_type = "t3.micro"
#   vpc_security_group_ids = [aws_security_group.demo_sg.id]
#     //Web Server
#     user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, This is a demo" > index.html
#               nohup busybox httpd -f -p 8080 &
#               EOF
#   tags = {
#     Name = "HelloWorld"

# }
# //security_groups
# # resource "aws_security_group" "demo_sg" {
# #   name        = "allow_tcp"
# #   description = "Allow Tcp inbound traffic"
# #   vpc_id      = "vpc-02a02749e122b791f"

# #   ingress {
# #     description      = "TLS from VPC"
# #     from_port        = 8080
# #     to_port          = 8080
# #     protocol         = "tcp"
# #     cidr_blocks      = ["0.0.0.0/0"]
# #     ipv6_cidr_blocks = ["::/0"]
# #   }


# #   tags = {
# #     Name = "allow_tcp"
# #   }
# # }