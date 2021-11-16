variable "name" {
    type = string
    default = "hw-instance-terraform-ssh"
}

locals {
    ami_id = "ami-0d058fe428540cd89"
    instance_type = "t2.micro"
}

resource "aws_instance" "ssh-hw" {
    ami = local.ami_id
    instance_type = local.instance_type
    key_name = "id_rsa"
    vpc_security_group_ids = [aws_security_group.main.id]

    connection {
        type = "ssh"
        host = self.public_ip
        user = "ubuntu"
        private_key = file()
    }

    tags = {
        Name = var.name
    }
}

output "instance_info" {
    value  = [aws_instance.ssh-hw.public_ip, aws_instance.ssh-hw.id]
}

resource "aws_key_pair" "deployer" {
    key_name = "id_rsa"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLabjBNikL+uAxXMJJ9QxMyOCn5me8Fy+UMP9HjIhHKYCEnYA1KhBb41dVDElatOJIYVAMwFomak/SAG9mLts+KTHMkRA2wYKw1y7XPh7M8rnJXLqawL0xF3H1vBykZAvCZBLFqHxV3d1uXNDPdP0Xh+i90lwnxF4k3YRvqM2/C8z7Pw13OpXQM+r0qSOb9lAXnyl4T03sxx1XUVmfagFbcF9Jdd+EzRulAOcIzoyeNlDaSUnfn6I41sj2btF2Tqcinv4dZ8adx45vubqKfQoBC5ULXNth28FPqXLlaML8FBUcmWt/oewCvZfX+CSij5cAot4SfY1o5Md/Q3igSouLcPdIl1Lr5QnJSE6N4r8KSGyOlrhvnm1luWFa/xsmFnibMTytFAFofq5nBR2TKb1AQ6c0rTO+ePRseD+Ehgcdvkxajkrk5b8zNpU2HjBYOXW0GUituymHi/tgguuf3r4VqGct0Du4IiSdscqu7myH4vb5PoQEtt82QVjf5hIBfH0= azmi_@DESKTOP-IVJ4CD3"
}

resource "aws_security_group" "main" {
    egress = [
        {
        cidr_blocks      = [ "0.0.0.0/0", ]
        description      = ""
        from_port        = 0
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        protocol         = "-1"
        security_groups  = []
        self             = false
        to_port          = 0
        }
    ]
    ingress = [
    {
        cidr_blocks      = [ "121.6.39.187/32" ]
        description      = "for ssh"
        from_port        = 22
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        protocol         = "tcp"
        security_groups  = []
        self             = false
        to_port          = 22
    }
    ]
}