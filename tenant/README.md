# Dicom Store Module

This is an internal private module for the EDI Platform Core module to provision the resources required for dicom store onboarding for particular tenant.

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0    |
| <a name="requirement_hsdp"></a> [hsdp](#requirement_hsdp)                | >= 0.18.2 |

## Providers

| Name                                                         | Version   |
| ------------------------------------------------------------ | --------- |
| <a name="provider_hsdp"></a> [hsdp](#provider_hsdp)          | >= 0.18.2 |

## Modules

| Name                                                                 | Source                | Version |
| -------------------------------------------------------------------- | --------------------- | ------- |
| <a name="module_proposition"></a> [tenant](#module_tenant)           | ./tenant              |         |

## Resources

| Name                                                                                                                                                                  | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [hsdp_iam_role.role_dicom_admin](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_role)                               | resource    |
| [hsdp_iam_role.role_dicom_cdr](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_role)                               | resource    |
| [hsdp_iam_role.role_dicom_s3creds](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_role)                               | resource    |
| [hsdp_iam_group.grp_dicom_s3creds](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_group)                               | resource    |
| [hsdp_iam_group.grp_dicom_admin](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_group)                               | resource    |
| [hsdp_iam_group.grp_dicom_cdr](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_group)                               | resource    |
| [hsdp_dicom_object_store.object_store](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/dicom_object_store)                               | resource    |
| [hsdp_dicom_repository.dicom_repository](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/dicom_repository)                                       | resource    |
| [hsdp_s3creds_policy.tenant_org_policy](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/s3creds_policy)                                       | resource    |

## Inputs

| Name                                                                                                                              | Description                                                                                                                                                                           | Type                                                               | Default | Required |
| --------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ | ------- | :------: |
| <a name="input_tenant_organization_id"></a> [tenant_organization_id](#input_tenant_organization_id)                               | The UUID of the tenant org to be onboarded to Dicom Store                                                                                                                                            | `string`                                                           | n/a     |   yes    |
| <a name="input_edi_platform_service_identity"></a> [edi_platform_service_identity](#input_edi_platform_service_identity)          | Service Identity of EDI Platform root IAM org  | `string`      | n/a     |   yes    |
| <a name="input_cdr_service_identity"></a> [edi_cdr_service_identity](#input_cdr_service_identity)                                 | CDR service account for background processing of data of Dicom Store  | `string`      | n/a     |   yes    |
| <a name="input_dicom_s3_creds_service_identity"></a> [dicom_s3_creds_service_identity](#input_dicom_s3_creds_service_identity)    | Dicom S3 service account accessing policies | `string`      | n/a     |   yes    |
| <a name="input_dicom_s3_creds_private_key"></a> [dicom_s3_creds_private_key](#input_dicom_s3_creds_private_key)                   | Dicom S3 service account's private key         | `string`      | n/a     |   yes    |
| <a name="input_dss_config_url"></a> [dss_config_url](#input_dss_config_url)                                                       | DICOM Store config URL (Should have received from Onboarding Request)  | `string`      | n/a     |   yes    |
| <a name="input_force_delete_object_store"></a> [force_delete_object_store](#input_force_delete_object_store)                      | This will delete the object store entry, you will not get the older data which was processed with this entry. Use this with caution.  | `string`      | n/a     |   yes    |
| <a name="input_dicom_s3creds_bucket_name"></a> [dicom_s3creds_bucket_name](#input_dicom_s3creds_bucket_name)                                                       | The S3Creds bucket name for Dicom Store  | `string`      | n/a     |   yes    |
| <a name="input_dicom_s3creds_product_key"></a> [dicom_s3creds_product_key](#input_dicom_s3creds_product_key)                                                       | The S3Creds product key for Dicom Store | `string`      | n/a     |   yes    |
| <a name="input_dicom_s3creds_bucket_endpoint"></a> [dicom_s3creds_bucket_endpoint](#input_dicom_s3creds_bucket_endpoint)                                                       | The S3Creds external Bucket endpoint for Dicom Store  | `string`      | n/a     |   yes    |                  |
