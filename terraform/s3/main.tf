terraform {
  required_providers {
    storj = {
      source = "storj/storj"
      version = "0.0.1"
    }

    minio = {
      source = "aminueza/minio"
      version = "2.5.1"
    }
  }
}
