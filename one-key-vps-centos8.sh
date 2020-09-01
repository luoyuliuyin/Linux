#!/bin/sh

#####---pre---#####;
yum update -y;
yum install vim wget unzip git -y;

#####---V2ray---#####;
bash <(curl -L -s https://install.direct/go.sh);
echo -e '{\n  "log": {\n    "access": "/var/log/v2ray/access.log",\n    "error": "/var/log/v2ray/error.log",\n    "loglevel": "warning"\n  },\n  "inbounds": [\n    {\n      "port": 608,\n      "protocol": "vmess",\n      "settings": {\n        "clients": [\n          {\n            "id": "5aaff639-6a7d-4461-b6b5-9d7a42958a65",\n            "level": 1,\n            "alterId": 64\n          }\n        ]\n      }\n    }\n  ],\n  "outbounds": [\n    {\n      "protocol": "freedom",\n      "settings": {}\n    }\n  ]\n}' > /etc/v2ray/config.json;
echo 'alias log="tail -f /var/log/v2ray/access.log"' >> /etc/bashrc;

#####—--spring-boot-tools---#####;
cd;
wget https://archive.apache.org/dist/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.zip;
unzip -d /opt apache-maven-3.6.2-bin.zip;
mv apache-maven-3.6.2 /opt;
rpm -ivh https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.rpm;
echo -e '# .bash_profile\n\n# Get the aliases and functions\nif [ -f ~/.bashrc ]; then\n        . ~/.bashrc\nfi\n\n# User specific environment and startup programs\nexport LC_ALL=en_US.UTF-8\nexport JAVA_HOME=/usr/java/default/\nexport MAVEN_HOME=/opt/apache-maven-3.6.2/\nPATH=$PATH:$HOME/bin:$JAVA_HOME/bin:$MAVEN_HOME/bin\n\nexport PATH' > /root/.bash_profile;
source /root/.bash_profile;
cd /opt;
git clone https://github.com/luoyuliuyin/spring-boot-tools.git;
cd /opt/spring-boot-tools;
mvn clean install;
echo -e '[Unit]\n	Description=spring-boot-tools\n\n[Service]\n	Type=simple\n	WorkingDirectory=/root\n	Restart=on-failure\n	ExecStart=/usr/bin/java -jar /opt/spring-boot-tools/target/spring-boot-tools.jar\n\n[Install]\n	WantedBy=multi-user.target' > /etc/systemd/system/spring-boot-tools.service;
systemctl enable spring-boot-tools;

#####---vnc---#####;
#yum install gnome-classic-session gnome-terminal gnome-system-monitor tigervnc-server gedit firefox -y;sed -i 's/1024x768/1536x960/g' /usr/bin/vncserver;echo -e '[Unit]\nDescription=VNC\n\n[Service]\nType=simple\nExecStart=/usr/sbin/runuser -l root -c "/usr/bin/vncserver"\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/vncserver.service;systemctl enable vncserver.service;vncpasswd;

#####---crontab---#####;
timedatectl set-timezone Asia/Shanghai;
echo '0 0 * * * root yum clean all' >> /etc/crontab;
echo '1 1 * * * root yum update -y' >> /etc/crontab;
echo '2 2 * * * root bash <(curl -L -s https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)' >> /etc/crontab;
echo '3 3 * * * root reboot' >> /etc/crontab;
echo '4 4 * * * root rm -rf /root/virt-sysprep-firstboot.log' >> /etc/crontab;

rm -f /root/*;
reboot;
