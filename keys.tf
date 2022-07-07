resource "aws_key_pair" "my_blog_key" {
  key_name = "my_tf_key"
  public_key = file("./myblog-key.pub")
}