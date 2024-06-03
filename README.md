# homelab

L'objectif c'est de me faire un mini datacenter et de tester plein de trucs. Les idées que j'ai à l'heure où je commit :

En cours :

une machine master qui peut SSH les autres machines (et disable l'authentification SSH avec mot de passe)
un saltmaster pour gérer les configurations de toutes les machines
un pi-hole pour gérer la partie DNS + pubs dans mon réseau local. Possible d'ajouter les entrées DNS directement depuis /etc/pihole/custom.list
une machine stackstorm pour gérer les automatisations
une machine prometheus / alertmanager pour gérer le monitoring / alerting. Faire en sorte de rediriger ça vers un discord spécial alertes via webhooks ?
un serveur web parce que c'est cool et un homelab sans site web c'est nul ?
une machine CA qui gère les certificats SSL (openSSL)
une machine Vault pour stocker les secrets qui sont récupérables via SaltStack
une machine SMTP
Ce qui sera fait :

la partie cloud pour apprendre à gérer avec k8s, docker (cloud.homelab.lan)
la partie ansible (?)
la partie terraform (?)
