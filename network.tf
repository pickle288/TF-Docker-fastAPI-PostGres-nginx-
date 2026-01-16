#Contient la config réseau et la communication entre les ressources
resource "docker_network" "network" {
  name = "network"
  driver = "bridge"
}