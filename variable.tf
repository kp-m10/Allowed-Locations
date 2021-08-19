variable "policy_definition_category" {
  type        = string
  description = "The category to use for all Policy Definitions"
  default     = "General"
}

variable "subscription" {
 type	 	= list
 description 	= "The value of the subscription for assigning the policy"
}

variable "location" {
 type		= list
 description	= "List of allowed Locations"
}

variable "assign_name" {
 type		= string
 description	= "Name of the Assignment"
 default	= "Allowed Locations"
}

variable "name" {
 type		= string
 description	= "Name of the Policy Definition"
 default	= "Allowed Locations"
}
