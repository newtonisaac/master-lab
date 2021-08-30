variable scale_to_zero { 
  type = bool
  default = true
}

variable name { 
  type = string
}

variable project { 
  type = string
}

variable region { 
  type = string
}

variable image { 
  type = string
}

variable cloudrun_connector_id { 
  type = string
}

variable memory { 
  type = string
  default = "512Mi"
}

variable cpu { 
  type = string
  default = "1000m"
}
