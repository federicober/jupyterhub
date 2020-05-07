FROM jupyterhub/jupyterhub:latest

COPY requirements.txt /tmp/requirements.txt
COPY secrets/adminlist /srv/jupyterhub/adminlist
COPY cull_idle_servers.py /srv/jupyterhub/cull_idle_servers.py
COPY jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py
COPY ssl/ /srv/jupyterhub/ssl/

RUN pip install --upgrade pip &&\
	pip install --no-cache -r /tmp/requirements.txt
