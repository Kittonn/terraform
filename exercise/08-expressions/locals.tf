locals {
  math       = 2 + 2
  equal      = 5 == 5
  comparison = 10 > 5
  logical    = true && false
}

locals {
  # [for <ITEM> in <COLLECTION> : <OUTPUT_VALUE> if <CONDITION>]
  double_numbers = [for num in var.numbers_list : num * 2]
  even_numbers   = [for num in var.numbers_list : num if num % 2 == 0]
  first_names    = [for obj in var.objects_list : obj.first_name]
  full_names     = [for obj in var.objects_list : "${obj.first_name} ${obj.last_name}"]
}

locals {
  # { for <KEY>, <VALUE> in <MAP_COLLECTION> : <NEW_KEY> => <NEW_VALUE> if <CONDITION> }
  double_maps = {
    for key, value in var.numbers_map : key => value * 2
  }

  even_map = {
    for key, value in var.numbers_map : key => value * 2 if value % 2 == 0
  }
}

locals {
  users_map = {
    for user in var.users : user.username => user.role...
  }

  users_map2 = {
    for user in var.users : user.username => {
      role = user.role
    }
  }


  usernames_from_map = [for user in var.users : user.username]
}
