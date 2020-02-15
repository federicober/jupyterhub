docker network create jupyterhub
docker build -t myjupyterhub .

docker pull jupyter/datascience-notebook
docker pull jupyter/tensorflow-notebook
docker pull jupyter/all-spark-notebook

docker run --rm -it --env-file env.list -v /var/run/docker.sock:/var/run/docker.sock --net jupyterhub --name jupyterhub -p8000:8000 myjupyterhub jupyterhub