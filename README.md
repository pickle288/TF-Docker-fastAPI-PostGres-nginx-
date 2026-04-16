# Infrastructure Docker + Terraform

Infrastructure Docker provisionnée via Terraform permettant de déployer une stack complète composée de Nginx, d’une API FastAPI et d’une base de données PostgreSQL.

Cette infrastructure expose une API permettant d’interagir avec la base de données via des requêtes HTTP.

---

## Prérequis

- Terraform installé  
- Docker installé  

---

## Déploiement de l’infrastructure

### 1. Cloner le repository
git clone "URL repo"
cd "Chemin\repo"

### 2. Initilalisation & Déploiement 
terraform init
terraform plan
terraform apply

Accès à l’API

Une fois les conteneurs démarrés, accéder à la documentation FastAPI : http://<IP_FASTAPI>:8080/docs
