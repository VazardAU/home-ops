locals {
  minio_buckets = [
    "test-tfbucket1",
    "test-tfbucket2"
  ]
}

module "onepassword_item_minio" {
  source = "github.com/VazardAU/home-ops/terraform/1password"
  vault  = "sc_secrets"
  item   = "minio"
}

module "minio_bucket" {
  for_each         = toset(local.minio_buckets)
  source           = "./modules/minio_bucket"
  bucket_name      = each.key
  is_public        = false
  owner_access_key = lookup(module.onepassword_item_minio.fields, "${each.key}_access_key", null)
  owner_secret_key = lookup(module.onepassword_item_minio.fields, "${each.key}_secret_key", null)
  providers = {
    minio = minio.nas
  }
}
output "minio_bucket_outputs" {
  value     = module.minio_bucket
  sensitive = true
}
