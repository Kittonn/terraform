module "vpc" {
  source = "./modules/networking"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "12-local-modules"
  }

  subnet_config = {
    public = {
      az         = "ap-southeast-1a"
      cidr_block = "10.0.1.0/24"
      public = true
    }
    private = {
      az         = "ap-southeast-1b"
      cidr_block = "10.0.2.0/24"
      public = false
    }
  }
}
