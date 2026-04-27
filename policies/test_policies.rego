package terraform.policies

test_deny_public_ssh {
  deny[_] with input as {
    "resource": {
      "aws_security_group": {
        "AUY1105-rojas-sg": {
          "ingress": [{"from_port": 22, "to_port": 22, "cidr_blocks": ["0.0.0.0/0"]}]
        }
      }
    }
  }
}

test_deny_wrong_instance_type {
  deny[_] with input as {
    "resource": {
      "aws_instance": {
        "AUY1105-rojas-ec2": {
          "instance_type": "t3.micro"
        }
      }
    }
  }
}
