variable "tenant_organization_id" {
  type        = string
  description = "The UUID of the tenant org to be onboarded to Dicom Store"
}

variable "edi_platform_service_identity" {
  type        = string
  description = "Service Identity of EDI Platform root IAM org"
}

variable "cdr_service_identity" {
  type        = string
  description = "CDR service account for background processing of data of Dicom Store" // One CDR account created in EDI ROOT shared across all tenants
}

variable "dicom_s3_creds_service_identity" {
  type        = string
  description = "Dicom S3 service account accessing policies" // One S3 account created in EDI ROOT shared across all tenants
}

variable "dicom_s3_creds_private_key" {
  type        = string
  description = "Dicom S3 service account's private key" // S3 Account's private ley
}

variable "dss_config_url" {
  description = "DICOM Store config URL (Should have received from Onboarding Request)"
  type        = string
  validation {
    condition     = can(regex("^https://dss-config", var.dss_config_url))
    error_message = "The dss_config_url value must be a valid url, starting with \"https://dss-config\"."
  }
}

variable "force_delete_object_store" {
  description = "This will delete the object store entry, you will not get the older data which was processed with this entry. Use this with caution."
  type        = bool
  default     = false
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
