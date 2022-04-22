provider "aws"{
 region = "ap-northeast-2"
}

resource "aws_instance" "example"{
 ami = "ami-02e05347a68e9c76f"
 instance_type = "t2.micro"

 tags = {
     Name = "terraform-example"
 }
}


