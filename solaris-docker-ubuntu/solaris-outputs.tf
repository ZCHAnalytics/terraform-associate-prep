output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.solaris_docker_container_ubuntu_nginx.id
}

output "image_id" {
  description = "ID of the Docker image"
  value       = docker_image.solaris_docker_ubuntu_nginx.id
}
