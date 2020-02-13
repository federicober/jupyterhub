docker network create jupyterhub
docker build -t myjupyterhub .
docker pull jupyter/base-notebook

call env.bat

docker run --rm -it --env-file env.list -v /var/run/docker.sock:/var/run/docker.sock --net jupyterhub --name jupyterhub -p8000:8000 myjupyterhub jupyterhub