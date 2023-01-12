output "pubsubnets" {
    value = aws_subnet.pubsubnets.*.id
  
}

output "prisubnets" {
 value = aws_subnet.prisubnets.*.id
}