# Dicom Store Module

This is an internal private module for the EDI Platform Core module to provision the resources required for a Dicom store onboarding.

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
| [hsdp_iam_application.app_dicom](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_application)                               | resource    |
| [hsdp_iam_proposition.prop_dicom](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_proposition)                               | resource    |
| [hsdp_iam_service.svc_dicom_cdr](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_service)                                       | resource    |
| [hsdp_iam_service.svc_dicom_s3creds](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_service)                                       | resource    |
| [hsdp_iam_role.role_service_admin](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_role)                               | resource    |
| [hsdp_iam_group.grp_service_admin](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/iam_group)                               | resource    |
| [hsdp_dicom_store_config.dicom](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/dicom_store_config)                                       | resource    |

## Inputs

| Name                                                                                                                              | Description                                                                                                                                                                           | Type                                                               | Default | Required |
| --------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ | ------- | :------: |
| <a name="input_edi_platform_org_id"></a> [edi_platform_org_id](#input_edi_platform_org_id)                                        | The UUID for the EDI Platform root IAM org                                                                                                                                            | `string`                                                           | n/a     |   yes    |
| <a name="input_iam_tenant_orgs"></a> [iam_tenant_orgs](#input_iam_tenant_orgs)                                                    | A list of tenant orgs to onboard onto the platform and automate.                                                                                                                      | <pre>list(object({<br> name = string<br> id = string<br> }))</pre> | n/a     |   yes    |
| <a name="input_edi_platform_service_identity"></a> [edi_platform_service_identity](#input_edi_platform_service_identity)          | Service Identity of EDI Platform root IAM org  | `string`      | n/a     |   yes    |
| <a name="input_dss_config_url"></a> [dss_config_url](#input_dss_config_url)                                                       | DICOM Store config URL (Should have received from Onboarding Request)  | `string`      | n/a     |   yes    |
| <a name="input_dicom_s3creds_bucket_name"></a> [dicom_s3creds_bucket_name](#input_dicom_s3creds_bucket_name)                                                       | The S3Creds bucket name for Dicom Store | `string`      | n/a     |   yes    |
| <a name="input_dicom_s3creds_product_key"></a> [dicom_s3creds_product_key](#input_dicom_s3creds_product_key)                                                       | The S3Creds product key for Dicom Store | `string`      | n/a     |   yes    |
| <a name="input_dicom_s3creds_bucket_endpoint"></a> [dicom_s3creds_bucket_endpoint](#input_dicom_s3creds_bucket_endpoint)                                                       | The S3Creds external Bucket endpoint for Dicom Store   | `string`      | n/a     |   yes    |

## Outputs

| Name                                                                                                        | Description                                                                         |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| <a name="output_dicom_store_endpoints"></a> [dicom_store_endpoints](#output_dicom_store_endpoints) | The Dicom store base urls - QIDO, WADO , STOW |
