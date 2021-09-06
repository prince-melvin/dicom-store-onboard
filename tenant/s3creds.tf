resource "hsdp_s3creds_policy" "tenant_org_policy" {
  product_key = var.dicom_s3creds_product_key

  depends_on = [hsdp_iam_group.grp_dicom_admin]

  policy = <<POLICY
{
  "conditions": {
    "managingOrganizations": [ "${var.tenant_organization_id}" ],  
    "groups": [ "${hsdp_iam_group.grp_dicom_s3creds.name}" ]
  },
  "allowed": {
    "resources": [ "${var.tenant_organization_id}/dicom/*" ],
    "actions": [
      "ALL_BUCKET",
      "GET",
      "PUT",
      "LIST",
      "DELETE"
    ]
  }
}
POLICY
}
