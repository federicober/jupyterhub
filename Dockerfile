FROM jupyterhub/jupyterhub:latest

COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip &&\
	pip install --no-cache -r /tmp/requirements.txt

COPY jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py