/* Application DNS Register */

resource "aws_route53_record" "nodejs_public_dns" {
  zone_id = "${data.aws_route53_zone.nodejs_public_zone.zone_id}"
  name = "nodejs.${data.aws_route53_zone.nodejs_public_zone.name}"
  type = "CNAME"
  ttl = "300"
  records = ["${aws_elastic_beanstalk_environment.nodejs.cname}"]
}
