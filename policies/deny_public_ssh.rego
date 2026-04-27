package terraform.policies

deny[msg] {
  resource := input.resource.aws_security_group[name]
  ingress := resource.ingress[_]
  ingress.from_port <= 22
  ingress.to_port >= 22
  ingress.cidr_blocks[_] == "0.0.0.0/0"
  msg := sprintf("VIOLACION: El Security Group '%v' permite acceso SSH publico (0.0.0.0/0). Solo se permiten rangos privados.", [name])
}
