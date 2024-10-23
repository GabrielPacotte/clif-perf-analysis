# CLIF - Tests de performance d'un serveur


## Introduction

Ce repo git regroupe les fichiers nécessaire à la reproduction des résultats obtenus pour un TP d'école d'ingénieur Ensimag en "Test des Systèmes Logiciel".

> Ces fichiers correspondent à du prototypage, et ne sont absolument pas destiné à de la production.

## Reproduction

1. [Installez Java 8](https://www.oracle.com/fr/java/technologies/javase/javase8u211-later-archive-downloads.html)
2. [Installez CLIF](https://clif.ow2.io/clif-proactive/download/)
3. [Installez Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
4. [Installez le CLI AWS](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
5. Lancez le script `/deploy/deploy.sh` qui:
   1. Déploie l'infrastructure avec `Terraform`.
   2. Configure le serveur avec `Ansible`.
6. Placez-vous dans le dossier `/calctest`
7. En local depuis votre machine, lancez l'exécution des tests avec `clifcmd launch calcudp <fichier_test.ctp> <id_du_test>`.
8. Affichez les résultats avec `clifcmd quickstats`.