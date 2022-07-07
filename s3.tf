# data "aws_canonical_user_id" "current_user" {}

# resource "aws_s3_bucket" "terraform_state_sufle" {
#   bucket = "terraform-sufle-bucket"

#   grant {
#     id          = data.aws_canonical_user_id.current_user.id
#     type        = "CanonicalUser"
#     permissions = ["FULL_CONTROL"]
#   }

#   grant {
#     type        = "Group"
#     permissions = ["READ_ACP", "WRITE"]
#     uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
#   }
# } 
