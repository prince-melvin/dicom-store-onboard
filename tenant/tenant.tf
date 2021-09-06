# Groups, roles  neeed for DICOM Onboarding
# 1. Role for CDR Service Account  - Assign edi-root cdr service account
# 2. Role for Dicom Config and S3 Access - Assign edi-root automation account for dicom onboarding 

data "hsdp_config" "iam" {
  service = "iam"
}

data "hsdp_iam_service" "cdr_service_identity" {
  service_id = var.cdr_service_identity
}

data "hsdp_iam_service" "dicom_s3_creds_service_identity" {
  service_id = var.dicom_s3_creds_service_identity
}

data "hsdp_iam_service" "edi_platform_service_identity" {
  service_id = var.edi_platform_service_identity
}

resource "hsdp_iam_role" "role_dicom_admin" {
  name        = "ROLE-DICOM-ADMINS-TF"
  description = "ROLE-DICOM-ADMINS-TF - Terraform managed"
  permissions = [
    "CP-CONFIG.ALL",
    "S3CREDS_POLICY.ALL",
  ]
  managing_organization = var.tenant_organization_id
}

resource "hsdp_iam_role" "role_dicom_cdr" {
  name        = "ROLE-DICOM-CDR-TF"
  description = "ROLE-DICOM-CDR-TF - Terraform managed"

  lifecycle {
    ignore_changes = [description]
  }

  permissions = [
    "CP-DICOM.ALL",
    "ALL.READ",
    "ALL.WRITE"
  ]
  managing_organization = var.tenant_organization_id
}

resource "hsdp_iam_role" "role_dicom_s3creds" {
  name        = "ROLE-DICOM-S3CREDS-TF"
  description = "ROLE-DICOM-S3CREDS-TF - Terraform managed"

  permissions = [
    "S3CREDS_ACCESS.GET"
  ]
  managing_organization = var.tenant_organization_id
}

resource "hsdp_iam_group" "grp_dicom_s3creds" {
  name                  = "GRP-DICOM-S3CREDS-TF"
  description           = "GRP-DICOM-S3CREDS-TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_dicom_s3creds.id]
  services              = [data.hsdp_iam_service.dicom_s3_creds_service_identity.id] //Assign s3_creds service account to the group and role in the tenants
  managing_organization = var.tenant_organization_id
}

resource "hsdp_iam_group" "grp_dicom_admin" {
  name                  = "GRP-DICOM-ADMIN-TF"
  description           = "GRP-DICOM-ADMIN-TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_dicom_admin.id]
  services              = [data.hsdp_iam_service.edi_platform_service_identity.id] //Assign EDI-Root automation account for objectstore and access policy permissions
  managing_organization = var.tenant_organization_id
}

resource "hsdp_iam_group" "grp_dicom_cdr" {
  name                  = "GRP-DICOM-CDR-TF"
  description           = "GRP-DICOM-CDR-TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_dicom_cdr.id]
  services              = [data.hsdp_iam_service.cdr_service_identity.id] //Assign cdr service account to the particular tenant group
  managing_organization = var.tenant_organization_id
}

#Tenant org onboarding 
resource "hsdp_dicom_object_store" "object_store" {

  depends_on = [hsdp_iam_group.grp_dicom_admin]

  config_url      = var.dss_config_url
  organization_id = var.tenant_organization_id
  force_delete    = var.force_delete_object_store

  s3creds_access {
    endpoint    = var.dicom_s3creds_bucket_endpoint
    product_key = var.dicom_s3creds_product_key
    bucket_name = var.dicom_s3creds_bucket_name
    folder_path = "${var.tenant_organization_id}/dicom/"
    service_account {
      service_id            = var.dicom_s3_creds_service_identity
      private_key           = replace(var.dicom_s3_creds_private_key, "\n", "")
      access_token_endpoint = "${data.hsdp_config.iam.url}/oauth2/access_token"
      token_endpoint        = "${data.hsdp_config.iam.url}/authorize/oauth2/token"
    }
  }
}

resource "hsdp_dicom_repository" "dicom_repository" {
  config_url      = var.dss_config_url
  organization_id = var.tenant_organization_id
  object_store_id = hsdp_dicom_object_store.object_store.id
}
