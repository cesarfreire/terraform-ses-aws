terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "3.39.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

data "aws_route53_zone" "zona_selecionada" {
    name         = "${terraform.workspace}"
}

resource "aws_ses_domain_identity" "ses_dominio" {
    domain = "${terraform.workspace}"
}

resource "aws_ses_domain_dkim" "dkim_cliente" {
    domain = aws_ses_domain_identity.ses_dominio.domain
}

resource "aws_route53_record" "example_amazonses_dkim_record" {
    count   = 3
    zone_id = data.aws_route53_zone.zona_selecionada.zone_id
    name    = "${element(aws_ses_domain_dkim.dkim_cliente.dkim_tokens, count.index)}._domainkey"
    type    = "CNAME"
    ttl     = "600"
    records = ["${element(aws_ses_domain_dkim.dkim_cliente.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

output "zone_id" {
    description = "ID da zona"
    value       = data.aws_route53_zone.zona_selecionada.zone_id
}