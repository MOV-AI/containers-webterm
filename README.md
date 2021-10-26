![MOVAI-SHELL](static/webshell.png)
# MOV.AI Web SSH Terminal

A simple NodeJS SSH terminal based on [Wetty](https://github.com/butlerx/wetty)

## Description

The container expose a webservice on port 3000 to get access to `movai-shell` via a Web Browser

## Build

    docker build -t movai-shell .

## Usage

This container must be used behind a HTTPS proxy (Nginx or HAProxy)

For example, with HAProxy it needs following configuration sections :

    frontend ha-frontend-http
        mode http
        bind :80
	    bind :443 ssl crt /etc/ssl/private/proxy.pem

        use_backend ha-backend-webshell if { path -i -m beg /shell }

        errorfile 503 /etc/503-movai.http

    backend ha-backend-webshell
        mode http
        server container-frontend 127.0.0.1 disabled


Then on a running robot :

    docker run -d --network MovaiNetwork-${ROBOTNAME}-movai --name frontend-${ROBOTNAME}-movai movai-shell
