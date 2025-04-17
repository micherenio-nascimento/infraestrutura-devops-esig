FROM tomcat:9.0

WORKDIR /usr/local/tomcat

RUN curl -L -o /usr/local/tomcat/webapps/jenkins.war https://get.jenkins.io/war-stable/latest/jenkins.war

USER root
RUN apt-get update && \
    apt-get install -y git curl && \
    apt-get install -y apt-transport-https ca-certificates gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    groupadd docker && \
    useradd -m -s /bin/bash tomcat && \
    usermod -aG docker tomcat

RUN sed -i 's/8080/9190/g' /usr/local/tomcat/conf/server.xml

EXPOSE 9190 9010

CMD ["sh", "-c", "java \
  -Dcom.sun.management.jmxremote \
  -Dcom.sun.management.jmxremote.port=9010 \
  -Dcom.sun.management.jmxremote.rmi.port=9010 \
  -Dcom.sun.management.jmxremote.authenticate=false \
  -Dcom.sun.management.jmxremote.ssl=false \
  -Djava.rmi.server.hostname=jenkins \
  -jar /usr/local/tomcat/webapps/jenkins.war \
  --httpPort=9190"]
