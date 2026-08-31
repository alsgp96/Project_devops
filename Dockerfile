
FROM tomcat:latest
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY target/team1.war /usr/local/tomcat/webapps/ROOT.war
