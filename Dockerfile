FROM jupyterhub/jupyterhub

RUN echo "Setup container to custom conf" &&\
	apt-get update &&\
	apt-get install sudo &&\
	sudo adduser --disabled-password --gecos "" user1 &&\
	(echo "user1:pass" | sudo chpasswd) &&\
	pip install --upgrade pip &&\
	pip install dockerspawner &&\
	# This line generates a dummy config file inside srv/jupyterhub/jupyterhub_config.py
	# jupyterhub --generate-config &&\
	echo "c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'" >> jupyterhub_config.py &&\
	ls && pwd && head -10 ./jupyterhub_config.py &&\
	echo "Done setup"