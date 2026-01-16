# volumes.tf
# Contient :
# - La définition des volumes Docker
# - Les volumes pour la base de données
# - Les volumes pour les logs
# - La persistance des données
resource "docker_volume" "vol_postgres" {
  name = "postgres_volume"

}


