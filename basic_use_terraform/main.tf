resource "local_file" "first_file" {
  filename = "first_file.txt"
  content  = "This is an example file created by Terraform."
}