# Docker for GLPI with Fusioninventory and ssmtp to send notification emails
Docker for GLPI with Fusioninventory and SSMTP.
For this environment you can set the Dockerfile to change Timezone and Language inside the glpi container.

![alternate text](https://raw.githubusercontent.com/glpi-project/glpi/master/pics/logos/logo-GLPI-250-black.png)

# About this Image
GLPI version: Tested with 9.4.3 (you need to extract GLPI files to path /glpi)

PHP version: 7.3.4

Web Server: Apache 2.4.25

OS: Debian Stretch

# How to use
__1 - Clone this repository__

__2 - Access the repository__

```sh
cd ambiente-glpi
```

__3 - Extract GLPI Files to path /glpi:__

__4 - Up the container:__

```sh
docker-compose up -d
```

__5 - Config the GLPI system in url:__
```
localhost:9898
```


# Verifying the environment

After loading the container it's time to check if GLPI is running normally.

If you have not changed the configuration of the __docker-compose.yml__ file then GLPI is running on port __9090__.
To access it put in your browser the address:

```
localhost:9898
```








## Tutorial to setup ssmtp for GLPI email notification
https://techexpert.tips/glpi/glpi-email-notification-setup/
