FROM anapsix/alpine-java:jdk8

ENV HOME /home/netbeans

RUN adduser -D netbeans && \
apk update && \
apk add libxext libxtst libxrender && \
rm -rf /tmp/* && \
rm -rf /var/cache/apk/*

RUN mkdir -m 700 /data && \
mkdir -m 700 $HOME/.netbeans && \
mkdir -m 700 $HOME/NetBeansProjects && \
chown -R netbeans:netbeans /data $HOME/.netbeans $HOME/NetBeansProjects && \
chmod 777 -R $HOME/.netbeans $HOME/NetBeansProjects /data

VOLUME /data
#VOLUME ~/.netbeans
#VOLUME ~/NetBeansProjects


ENV MAVEN_VERSION 3.5.0
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

#COPY apache-tomcat $HOME/tomcat
#RUN chown -R netbeans:netbeans $HOME/tomcat

USER netbeans
COPY netbeans/netbeans.zip $HOME

# RUN wget http://download.netbeans.org/netbeans/8.2/final/zip/netbeans-8.2-201609300101-javaee.zip -O ~/netbeans.zip -q && \
RUN unzip ~/netbeans.zip -q -d ~ && \
rm ~/netbeans.zip

WORKDIR /data
CMD ~/netbeans/bin/netbeans
