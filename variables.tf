# Contient les variables utilisées dans le projet Terraform (type, description, valeur par défaut, etc.)
#postgres_db
#postgres_password
#postgres_user

variable "postgres_user" {
  type      = string
  sensitive = true
}
variable "postgres_password" {
  type      = string
  sensitive = true
}
variable "postgres_db" {
  type      = string
  sensitive = true
}
