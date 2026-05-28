output "website_url" {
  value = "http://${aws_instance.website_server.public_ip}:8080"
}
