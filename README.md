
# Terraform Script para configuração do SES DKIM no Route53 AWS

Simples script para geração dos DKIM para validação do Amazon SES e implementação no Route 53 do domínio.




## Rodando localmente

Configure o domínio no Route53.

Inicie um novo workspace do Terraform, onde o nome do workspace será o domínio a ser validado.

Para validar, utilize o comando :
```
terraform plan
```

Para validar, utilize:
```
terraform apply
```

Caso deseje aplicar sem confirmação, utilize:
```
terraform apply --auto-approve
```
