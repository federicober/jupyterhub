FROM jupyterhub/jupyterhub:latest

COPY requirements.txt /tmp/requirements.txt
COPY secrets/userlist /srv/jupyterhub/userlist
COPY cull_idle_servers.py /srv/jupyterhub/cull_idle_servers.py
COPY jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py

RUN pip install --upgrade pip &&\
	pip install --no-cache -r /tmp/requirements.txt
