#EDI org onboarding - POST Deployment for Dedicated instance

//Create Dicom Proposition and application to accomodate cdr_dicom and s3_creds service account

locals {
  orgs = concat(var.iam_tenant_orgs, [{ name = "edi-platform", id = "${var.edi_platform_org_id}" }])
}

resource "hsdp_iam_proposition" "prop_dicom" {
  name            = "PROP-DICOM-TF"
  description     = "PROP-DICOM-TF - Terraform managed"
  organization_id = var.edi_platform_org_id
}

resource "hsdp_iam_application" "app_dicom" {
  name           = "APP-DICOM-TF"
  description    = "APP-DICOM-TF - Terraform managed"
  proposition_id = hsdp_iam_proposition.prop_dicom.id
}

// The groups and roles will be assigned to this service account for each tenant.
resource "hsdp_iam_service" "svc_dicom_cdr" {
  name           = "SVC-DICOM-CDR-TF"
  description    = "SVC-DICOM-CDR-TF - Terraform managed"
  application_id = hsdp_iam_application.app_dicom.id
  validity       = 36
  scopes         = ["openid"]
  default_scopes = ["openid"]
}

// Create S3 creds service account which will be used for all the tenants
resource "hsdp_iam_service" "svc_dicom_s3creds" {
  name           = "SVC-DICOM-S3CREDS-TF"
  description    = "SVC-DICOM-S3CREDS-TF - Terraform managed"
  application_id = hsdp_iam_application.app_dicom.id
  validity       = 36
  scopes         = ["openid"]
  default_scopes = ["openid"]
}

resource "hsdp_iam_role" "role_service_admin" {
  name        = "ROLE-SERVICE-ADMIN-TF"
  description = "ROLE-SERVICE-ADMIN-TF - Terraform managed"
  permissions = [
    "CP-CONFIG.ALL",
    "CP-CONFIG.SERVICEADMIN"
  ]
  managing_organization = var.edi_platform_org_id
}

data "hsdp_iam_service" "edi_platform_service_identity" {
  service_id = var.edi_platform_service_identity
}

resource "hsdp_iam_group" "grp_service_admin" {
  name                  = "GRP-SERVICE-ADMIN-TF"
  description           = "GRP-SERVICE-ADMIN-TF - Terraform managed"
  roles                 = [hsdp_iam_role.role_service_admin.id]
  services              = [data.hsdp_iam_service.edi_platform_service_identity.id] //Assign EDI-Root automation account for objectstore and access policy permissions
  managing_organization = var.edi_platform_org_id
}


//Add CDR service account to the dicom store config
resource "hsdp_dicom_store_config" "dicom" {

  depends_on = [hsdp_iam_group.grp_service_admin]

  config_url      = var.dss_config_url
  organization_id = var.edi_platform_org_id

  cdr_service_account {
    service_id  = hsdp_iam_service.svc_dicom_cdr.service_id
    private_key = replace(hsdp_iam_service.svc_dicom_cdr.private_key, "\n", "")
  }

}

module "dicomstore_tenant_orgs_onboard" {
  source = "./tenant"

  for_each = {
    for tenant in local.orgs :
    tenant.id => tenant
  }

  dss_config_url                  = var.dss_config_url
  tenant_organization_id          = each.key
  edi_platform_service_identity   = var.edi_platform_service_identity
  cdr_service_identity            = hsdp_iam_service.svc_dicom_cdr.service_id
  dicom_s3_creds_service_identity = hsdp_iam_service.svc_dicom_s3creds.service_id
  dicom_s3_creds_private_key      = hsdp_iam_service.svc_dicom_s3creds.private_key
  dicom_s3creds_bucket_name       = var.dicom_s3creds_bucket_name
  dicom_s3creds_product_key       = var.dicom_s3creds_product_key
  dicom_s3creds_bucket_endpoint   = var.dicom_s3creds_bucket_endpoint
  force_delete_object_store       = false
}