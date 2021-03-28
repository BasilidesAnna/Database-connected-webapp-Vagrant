#!/bin/bash
# Create your provisioning script here
sudo apt-get update
sudo apt-get install -y  openjdk-11-jre-headless
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
cd /tmp
sudo yes | cp -rf /vagrant/apache-tomcat-9.0.41.tar.gz ./
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1
cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+x /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/
sudo update-java-alternatives -l
sudo cat > /etc/systemd/system/tomcat.service <<EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
sudo systemctl status tomcat
sudo cat > /opt/tomcat/bin/setenv.sh <<EOF
export SPRING_DATASOURCE_url=jdbc:postgresql://192.168.56.102:5432/chinook
export SPRING_DATASOURCE_USERNAME=vagrant
export SPRING_DATASOURCE_PASSWORD=vagrant
EOF
cp /tmp/web.war /opt/tomcat/webapps/ROOT.war
rm -r /opt/tomcat/webapps/ROOT
systemctl restart tomcat
