FROM jupyterhub/jupyterhub

RUN echo "Setup container to custom conf" &&\
	# apt-get update &&\
	# This line generates a dummy config file inside srv/jupyterhub/jupyterhub_config.py
	# jupyterhub --generate-config &&\
	pip install --upgrade pip &&\
	# Use the dummy auth only while dev
	pip install jupyterhub-dummyauthenticator && echo "c.JupyterHub.authenticator_class = 'dummyauthenticator.DummyAuthenticator'" >> jupyterhub_config.py &&\
	pip install dockerspawner &&\
	echo "c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'" >> jupyterhub_config.py &&\
	head -10 ./jupyterhub_config.py &&\
	echo "Done setup"