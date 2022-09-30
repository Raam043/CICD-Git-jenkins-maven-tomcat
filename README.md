#External tomcat server

Release Jenkins Server
and install jenkins 
commands for jenkins installation on ec2
==========================================
#!/bin/bash
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade
amazon-linux-extras install java-openjdk11 -y
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
===============================================

cd /opt
mkdir maven
cd maven
wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
chmod 777 apache-maven-3.8.6-bin.tar.gz
tar -xzvf apache-maven-3.8.6-bin.tar.gz
cd apache-maven-3.8.6/
pwd
/opt/maven/apache-maven-3.8.6
==================================
cd /root
==Edit Path environment (Java + Maven)===
vi .bash_profile
==============================================
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.16.0.8-1.amzn2.0.1.x86_64
M2_HOME=/opt/maven/apache-maven-3.8.6
M2=$M2_HOME/bin

PATH=$PATH:$JAVA_HOME:$M2_HOME:$M2:$HOME/bin
====================================================
__________________________________________________________________________________________________


Release Tomcat web server

Use commands
cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.67/bin/apache-tomcat-9.0.67.tar.gz
chmod 777 apache-tomcat-9.0.67.tar.gz
tar -xzvf apache-tomcat-9.0.67.tar.gz
cd apache-tomcat-9.0.67/
cd find / -name context.xml

==you will get 4 paths and select 3rd and 4th for edit==

vi /opt/apache-tomcat-9.0.67/webapps/host-manager/META-INF/context.xml
vi /opt/apache-tomcat-9.0.67/webapps/manager/META-INF/context.xml

-..edit and put "<!--" & "-->"

"<!--" before "<Valve ClassName (1st line beginning)

0:0:1" /> "-->" (2nd line end)

==Save and close====
cd conf
vi tomcat-users.xml

=paste below crediantials=
====================================================
          <role rolename="manager-gui"/>
          <role rolename="manager-script"/>
          <role rolename="manager-jmx"/>
          <role rolename="manager-status"/>
          <user username="ramesh" password="ramesh123" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
=================================================================
cd ..
cd webapps
mkdir RRR
cd RRR
pwd
/opt/apache-tomcat-9.0.67/webapps/RRR

==Save and close== IP:8080 (port can be customized)
_______________________________________________________________________________________________


Create jenkins Pipeline using Maven project

SCM > Git
Git repo = https://github.com/Raam043/CICD-Git-Jenkins-Tomcat.git
Branch = main

Build Triggers > Poll SCM
Schedule = * * * * *

Build >
Root POM = pom.xml
Goals and options = ""

Post-build Actions > Deploy war/ear to a container
WAR/EAR files = **/*.war
Containers> Selecy Tomcat 9.x Remote
Credentials = Tomcat webapp manager userID and Pass = "ramesh" + "ramesh123"
Tomcat URL = http://3.14.29.211:8080

Saven and Build now for sucessfull project
				   	 ..... all the best
						       #Ramesh_NB
