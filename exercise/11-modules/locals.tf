locals {
  project_name = "exercise-11-modules"
  common_tags = {
    ProjectName = local.project_name
    ManagedBy   = "Terraform"
  }
}
