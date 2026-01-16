# Contient :
# - La définition des conteneurs Docker
# - Les images utilisées
# - Les ports exposés
# - Les variables d'environnement
# - Les connexions au réseau
# - Les dépendances entre services


#container Nginx
resource "docker_container" "cont_nginx" {
  name  = "nginx_container"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }
  networks_advanced {
    name = docker_network.network.name
  }
  volumes {
    host_path      = "C:/Users/m.potier/OneDrive - pellencst.com/Bureau/vscode/tf-docker/nginx.conf"
    container_path = "/etc/nginx/nginx.conf"
  }
  depends_on = [docker_image.nginx]
}

#container postgres
resource "docker_container" "cont_postgres" {
  name  = "postgres_container"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=${var.postgres_db}"
  ]
  volumes {
    volume_name    = docker_volume.vol_postgres.name
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name = docker_network.network.name
  }
}

resource "docker_container" "cont_fastapi" {
  name  = "fastapi_container"
  image = docker_image.fastapi.image_id
  env = [
    "DATABASE_HOST=postgres_container",
    "DATABASE_PORT=5432",
    "DATABASE_USER=${var.postgres_user}",
    "DATABASE_PASSWORD=${var.postgres_password}",
    "DATABASE_NAME=${var.postgres_db}"
  ]
  networks_advanced {
    name = docker_network.network.name
  }

  volumes {
    host_path      = "C:/Users/m.potier/OneDrive - pellencst.com/Bureau/vscode/tf-docker/backend"
    container_path = "/app/"
  }

  command = [
    "bash",
    "-c",
    "pip install -r /app/requirements.txt && uvicorn main:app --host 0.0.0.0 --port 80"
  ]

  depends_on = [docker_image.fastapi, docker_container.cont_postgres]
} 