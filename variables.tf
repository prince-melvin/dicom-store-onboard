variable "iam_tenant_orgs" {
  type = list(object({
    name = string
    id   = string
  }))
  description = "A list of tenant orgs to onboard onto the dicom store."
}

variable "edi_platform_org_id" {
  type        = string
  description = "The UUID for the EDI Platform root IAM org"
}

variable "edi_platform_service_identity" {
  type        = string
  description = "Service Identity of EDI Platform root IAM org"
}

variable "dss_config_url" {
  description = "DICOM Store config URL (Should have received from Onboarding Request)"
  type        = string
  validation {
    condition     = can(regex("^https://dss-config", var.dss_config_url))
    error_message = "The dss_config_url value must be a valid url, starting with \"https://dss-config\"."
  }
}

variable "dicom_s3creds_bucket_name" {
  description = "The S3Creds bucket name"
  type        = string
}

variable "dicom_s3creds_product_key" {
  description = "The S3Creds product key"
  type        = string
}

variable "dicom_s3creds_bucket_endpoint" {
  description = "The S3 Bucket external endpoint"
  type        = string
}

