terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host    = "unix:///var/run/docker.sock"  # Update host to use Unix socket protocol
}

resource "docker_image" "solaris_docker_ubuntu_nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "solaris_docker_container_ubuntu_nginx" {
  image = docker_image.solaris_docker_ubuntu_nginx.image_id
  name  = "docked_at_solaris" #Initial name 
  # name = var.container_name # Modified with variable


  # add modificiations
  hostname = "solaris-terra-docker"

  ports {
    internal = 80
    # external = 8000
    external = 8080
  }
}