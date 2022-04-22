provider "aws"{
 region = "ap-northeast-2"
}

resource "aws_instance" "example"{
 ami = "ami-02e05347a68e9c76f"
 instance_type = "t2.micro"
 vpc_security_group_ids = [aws_security_group.instance.id]
 
 user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
                EOF
 tags = {
     Name = "terraform-example4"
 }
}

resource "aws_security_group" "instance"{
    name = "terraform-example-instance"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

