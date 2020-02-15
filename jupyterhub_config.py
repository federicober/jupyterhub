import os

c = get_config()  # noqa

# launch with docker
c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'
# we need the hub to listen on all ips when it is in a container
c.JupyterHub.hub_ip = '0.0.0.0'
# the hostname/ip that should be used to connect to the hub
# this is usually the hub container's name
c.JupyterHub.hub_connect_ip = 'jupyterhub'
# tell the user containers to connect to our docker network
c.DockerSpawner.network_name = 'jupyterhub'
# delete containers when the stop
c.DockerSpawner.remove = True

# # pick a docker image. This should have the same version of jupyterhub
# # in it as our Hub.
# c.DockerSpawner.image = 'jupyter/datascience-notebook'

from dockerspawner import DockerSpawner

class DemoFormSpawner(DockerSpawner):

    def _options_form_default(self):
        default_stack = "jupyter/minimal-notebook"
        return """
        <label for="stack">Select your desired stack</label>
        <select name="stack" size="1">
        <option value="jupyter/tensorflow-notebook">Tensorflow</option>
        <option value="jupyter/datascience-notebook">Datascience</option>
        <option value="jupyter/all-spark-notebook">Spark</option>
        </select>
        """.format(stack=default_stack)

    def options_from_form(self, formdata):
        options = {}
        options['stack'] = formdata['stack']
        container_image = ''.join(formdata['stack'])
        print("SPAWN: " + container_image + " IMAGE" )
        self.container_image = container_image
        return options

c.JupyterHub.spawner_class = DemoFormSpawner




# # dummy for testing. Don't use this in production!
# c.JupyterHub.authenticator_class = 'dummyauthenticator.DummyAuthenticator'

# OAuth with GitHub
c.JupyterHub.authenticator_class = 'oauthenticator.GitHubOAuthenticator'

c.Authenticator.whitelist = whitelist = set()
c.Authenticator.admin_users = admin = set()

join = os.path.join
here = os.path.dirname(__file__)
with open(join(here, 'userlist')) as f:
    for line in f:
        if not line:
            continue
        parts = line.split()
        name = parts[0]
        whitelist.add(name)
        if len(parts) > 1 and parts[1] == 'admin':
            admin.add(name)

c.GitHubOAuthenticator.oauth_callback_url = os.environ['OAUTH_CALLBACK_URL']


# ssl config
ssl = join(here, 'ssl')
keyfile = join(ssl, 'ssl.key')
certfile = join(ssl, 'ssl.cert')
if os.path.exists(keyfile):
    c.JupyterHub.ssl_key = keyfile
if os.path.exists(certfile):
    c.JupyterHub.ssl_cert = certfile