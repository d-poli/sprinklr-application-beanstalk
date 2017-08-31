/* nodejs app Load Balance */

resource "aws_elb" "nodejs_elb" {
  name               = "nodejs-${var.stack_env}"
  security_groups = ["${aws_security_group.publicsg.id}"]
  subnets         = [ "${aws_subnet.subnet-A-public.id}", "${aws_subnet.subnet-B-public.id}", "${aws_subnet.subnet-C-public.id}" ]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  listener {
    instance_port      = 8080
    instance_protocol  = "tcp"
    lb_port            = 443
    lb_protocol        = "ssl"
    ssl_certificate_id = "${var.certificate_arn}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.nodejs-A.id}","${aws_instance.nodejs-B.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
        Name = "${var.stack_name} nodejs Load Balance"
        Creation-Tool = "terraform"
        Env = "${var.stack_env}"
  }
}


resource "aws_proxy_protocol_policy" "websockets" {
  load_balancer  = "${aws_elb.nodejs_elb.name}"
  instance_ports = ["8080"]
}