# Jupyterhub with Docker Spawner and Google OAuth

This is a the github repo for ustom JupyterHub using [DockerSpawner](https://github.com/jupyterhub/dockerspawner) and [OAuthenticator](https://github.com/jupyterhub/oauthenticator) with Google.

This is not meant for production environments, mainly for small teams or formations.

The Jupyterhub offers several types of Jupyter Notebook, all inspired from the Jupyter Docker core stacks.

## Install
Copy the git repo and create a secrets dir inside:
```
mkdir -p secrets
```

Inside this directory you need to create two files `adminlist` and `oauth.env`.

The `adminlist` should contain one line per admin of the platform.
The Hub does not have a user whitelist, because e allow everyone inside our domain to use the service by using Google Oauth.
The adminlist should look like:
```
admin1@domain.com
admin2@domain.com
```

The `oauth.env` should look like this:
```
CLIENT_ID=...
CLIENT_SECRET=...
OAUTH_CALLBACK_URL=...
```

Further configuration can be achieved by modifying the `.env` file or overriding the variables in the shell.

## Acknowledgement
Inspired different examples from Jupyter:
- [`cull_idle`](https://github.com/jupyterhub/jupyterhub/tree/master/examples/cull-idle) for closing idle containers.
- [`jupyterhub-deploy-docker`](https://github.com/jupyterhub/jupyterhub-deploy-docker)
