#!/bin/bash
######################################################################
# Title   : Install Komga
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

read -p "Your Domain (domain.com)            : " domain
read -p "Your Cloudflare API token           : " CF_API_TOKEN
# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh
source /opt/ibracorp/ibramenu/MenuOptions/Submenu Networking/Dockerproxy/Dockerproxy.sh
# App Info
app="Traefik"                                  # App Name
title="Traefik"                                # Readable App Title
image="traefik:v3.0.0-beta2"     # Image and Tag
volumes="    volumes:
      - /opt/appdata/\${APP_NAME:?err}:/etc/traefik" # Volumes
tp_app=""                               # Theme Park App Name
porte=""                                    # External Port
porti=""                                    # Internal Port
extrapayload="    ports:
      - 443:443
      - 80:80
      -8080:8080
    labels:
      traefik.http.routers.api.rule: Host(`traefik.$domain`)    # Define the subdomain for the traefik dashboard.
      traefik.http.routers.api.entryPoints: https    # Set the Traefik entry point.
      traefik.http.routers.api.service: api@internal    # Enable Traefik API.
      traefik.enable: true   # Enable Traefik reverse proxy for the Traefik dashboard.
    command: --api.insecure=true --providers.docker
    environment:
      - CF_DNS_API_TOKEN=$CF_API_TOKEN
    depends_on:
      - Dockerproxy

    "                                 # Extra Payload to add to the Compose add 4 spance to the top group for example environment: and 6 for the childs (if copy and pasting you just need to add the space to the parent).


# Execute
app
touch "/opt/appdata/traefik/acme.json; chmod 600 /opt/appdata/traefik/acme.json"