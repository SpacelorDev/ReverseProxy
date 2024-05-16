#!/bin/bash

# Vraag om het domein waarvan de reverse proxy moet worden verwijderd
echo "Welk (sub)domein wil je verwijderen van de reverse proxy? (Bijv. sub.domein.com)"
read ccdomain

# Verwijder de symbolische koppeling
rm /etc/nginx/sites-enabled/$ccdomain.conf

# Verwijder de configuratiebestanden
rm /etc/nginx/sites-available/$ccdomain.conf

# Herlaad Nginx om de wijzigingen toe te passen
systemctl reload nginx

# Verwijder de SSL-certificaten voor het domein
certbot delete --cert-name $ccdomain

echo "De reverse proxy voor $ccdomain is succesvol verwijderd."
