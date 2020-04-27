sudo docker build -t voronoiz .
sudo docker run -it -p 8888:8888 --rm --name voronoi0 -v /tmp/.X11-unix/:/tmp/.X11-unix voronoiz
#docker run -it --rm -e DISPLAY="172.17.0.1:0" -v /tmp/.X11-unix:/tmp/.X11-unix voronoiz