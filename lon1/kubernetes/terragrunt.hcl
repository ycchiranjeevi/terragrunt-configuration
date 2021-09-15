locals {
  terraform_config   = read_terragrunt_config(find_in_parent_folders("terraform_config.hcl"))
  tag                       = local.terraform_config.locals.terraform-module-catalogue-tag
  # Regional configuration
  regional_config   = read_terragrunt_config(find_in_parent_folders("regional_config.hcl"))
  token                     = local.regional_config.locals.civotoken
}


terraform {
  source = "git::git@github.com:AlexsJones/terraform-module-catalogue.git//civo/kubernetes?ref=${local.tag}"
}

inputs = {
  civotoken = local.token
  cluster_name = "terragrunt-test"
  cluster_nodes = 5
  region = "LON1"
}