variable "security_group_ids" {
  description = "An array of security groups for the instance"
}
variable "subnet_id" {
  description = "The id of the subnet"
}
variable "instance_type" {
  default     = "t2.micro"
  description = "The type of instance"
}
variable "instance_count" {
  default     = 1
  description = "The amount of instances to create"
}
variable "user_data" {
  description = "Custom user data to run on first start"
}