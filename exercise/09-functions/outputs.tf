output "example2" {
  value = pow(local.age, 2)
}

output "example4" {
  value = jsonencode(local.my_object)
}