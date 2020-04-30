// variable "public_key_file"  { default = "~/.ssh/id_rsa.pub" }
// locals {
//   public_key    = "${file(pathexpand(var.public_key_file))}"
// }

variable "public_key" { }
// variable "ssh_key_name" { default = "schematics-test-key" }

variable "port" {
  default = 8080
}
