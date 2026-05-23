output "operators" {
  value = {
    math       = local.math
    equal      = local.equal
    comparison = local.comparison
    logical    = local.logical
  }
}

output "double_numbers" {
  value = local.double_numbers
}

output "even_numbers" {
  value = local.even_numbers
}

output "first_names" {
  value = local.first_names
}

output "full_names" {
  value = local.full_names
}

output "double_maps" {
  value = local.double_maps
}

output "even_map" {
  value = local.even_map
}

output "user_to_output_roles" {
  value = local.users_map2[var.user_to_output].role
}

output "users_map" {
  value = local.users_map
}

output "users_map2" {
  value = local.users_map2
}

output "usernames_from_map" {
  value = local.usernames_from_map
}
