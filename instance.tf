data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "userdata" {
  template = "${file("${path.cwd}/userdata.tpl")}"
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "ohio"
  security_groups   = ["${aws_security_group.allow_from_my_ip.name}"]
  user_data = data.template_file.userdata.template
  

  tags = {
    Name = "server"
  }

  provisioner "file" {
    source      = "packages/"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/spring-and-react-0.0.1-SNAPSHOT.jar /opt",
      "java -jar spring-and-react-0.0.1-SNAPSHOT.jar 2> errorOutput.log > output.log &",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    user        = "${var.INSTANCE_USERNAME}"
    type        = "ssh"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}
