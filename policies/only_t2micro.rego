package terraform.policies

deny[msg] {
  resource := input.resource.aws_instance[name]
  resource.instance_type != "t2.micro"
  msg := sprintf("VIOLACION: La instancia EC2 '%v' usa tipo '%v'. Solo se permite t2.micro.", [name, resource.instance_type])
}
