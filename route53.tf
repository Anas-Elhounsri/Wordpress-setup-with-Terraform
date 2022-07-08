resource "aws_route53_zone" "wp_route53"{
    name = "wpterraform.com"
    vpc {
        vpc_id = aws_vpc.wp_vpc.id
    }
}

resource "aws_route53_record" "www" {
    zone_id = aws_route53_zone.wp_route53.zone_id
    name="www.wpterraform.com"
    type="A"
    ttl="300"
    records = [aws_eip.one.public_ip]
}
