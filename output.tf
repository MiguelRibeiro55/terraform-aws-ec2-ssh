output "os_detected" {
  value = var.host_os
}


output "demovpc_ip" {
    value = aws_instance.demovpc_node.public_ip
}