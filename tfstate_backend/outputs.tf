output "backend_bucket_name" {
  value       = google_storage_bucket.backend.name
  description = "Customer backend bucket name"
}
