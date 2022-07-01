FROM tomcat:9-jdk8
LABEL author="gopi"
ENV http_proxy http://host.docker.internal:3128
ENV https_proxy http://host.docker.internal:3128
RUN mv webapps webapps2 && mv webapps.dist/ webapps
COPY gameoflife.war /usr/local/tomcat/webapps/gameoflife.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
