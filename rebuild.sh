docker stop opinionate
docker rm opinionate

docker build -t opinionate-img .

docker run -d --restart=always --net=host --name opinionate -p 3000:3000 -v `pwd`:/app opinionate-img

