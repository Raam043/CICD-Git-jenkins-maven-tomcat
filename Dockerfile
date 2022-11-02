# Pull base image 
From tomcat:8-jre8 

# Maintainer 
MAINTAINER "Raam043@gmail.com" 
COPY ./webapp /usr/local/tomcat/webapps
