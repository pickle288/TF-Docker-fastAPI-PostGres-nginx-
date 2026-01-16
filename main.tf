#Contient Les providers utilisés / ressources principales / configurations globales

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
  }
}

provider "docker" {} 

#image ngnix
resource "docker_image" "nginx" {
  name = "nginx:stable-perl"
}

#image fastapi
resource "docker_image" "fastapi" {
  name = "tiangolo/uvicorn-gunicorn-fastapi:python3.10"
}

#image postgres
resource "docker_image" "postgres" {
  name = "postgres:15"
}