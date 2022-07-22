# AutoRestartScript

Pour faire fonctionner le script il faut installer crontab et ajouter cette ligne :

```* * * * * <user> cd <app folder>; /bin/bash <app folder>/AutoRestart.sh```

à la fin du fichier `/etc/crontab`

(il faut bien sur modifier `<user>` par le nom d'utilisateur qui va lancer l'application et `<app folder>` par le prepertoire ou se trouve `AutoRestart.sh` et `AutoRestartConfig`)

`AutoRestart.sh` et `AutoRestartConfig` doivent etre dans le meme dossier.
