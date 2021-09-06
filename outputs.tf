output "dicom_store_endpoints" {
  value       = [hsdp_dicom_store_config.dicom.qido_url, hsdp_dicom_store_config.dicom.wado_url, hsdp_dicom_store_config.dicom.stow_url]
  description = "Dicom Store Base urls"
}
