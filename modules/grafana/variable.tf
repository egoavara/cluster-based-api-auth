variable "namespace" {
  type    = string
  default = "grafana"
}


variable "admin-auth" {
  type    = string
  default = "random"
  validation {
    condition = contains(
      ["random", "password"],
      var.admin-auth
    )
    error_message = "Allowed value is one of 'random', 'password'"
  }
}

variable "admin-password" {
  type      = string
  default   = null
  sensitive = true
}
