#!/bin/sh

#####---pre---#####;
yum update -y;
yum install vim wget unzip git -y;

#####---V2ray---#####;
bash <(curl -L -s https://install.direct/go.sh);
echo -e '{\n  "log": {\n    "access": "/var/log/v2ray/access.log",\n    "error": "/var/log/v2ray/error.log",\n    "loglevel": "warning"\n  },\n  "inbounds": [\n    {\n      "port": 43999,\n      "protocol": "vmess",\n      "settings": {\n        "clients": [\n          {\n            "id": "5aaff639-6a7d-4461-b6b5-9d7a42958a65",\n            "level": 1,\n            "alterId": 64\n          }\n        ]\n      }\n    }\n  ],\n  "outbounds": [\n    {\n      "protocol": "freedom",\n      "settings": {}\n    }\n  ]\n}' > /etc/v2ray/config.json;
echo 'alias log="tail -f /var/log/v2ray/access.log"' >> /etc/bashrc;

#####---shadowsocksr---#####;
#yum install python36 epel-release libsodium -y;
#cd /opt;
#git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git;
#cd /opt/shadowsocksr;
#bash initcfg.sh;
#echo -e '[Unit]\nDescription=Shadowsocksr\n\n[Service]\nType=forking\nExecStart=/usr/bin/python3 /opt/shadowsocksr/shadowsocks/server.py -p 4399 -k pengfeixiong -m chacha20 -O auth_aes128_md5 -o tls1.2_ticket_auth --workers 2 -d start\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/shadowsocksr.service;
#systemctl enable shadowsocksr;

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
echo -e '[Unit]\n	Description=spring-boot-tools\n\n[Service]\n	Type=forking\n	WorkingDirectory=/root\n	Restart=on-failure\n	ExecStart=/usr/bin/java -jar /opt/spring-boot-tools/target/spring-boot-tools.jar\n\n[Install]\n	WantedBy=multi-user.target' > /etc/systemd/system/spring-boot-tools.service;
systemctl enable spring-boot-tools;

#####—--ttf---#####;
#wget -P /usr/share/fonts/yahei https://raw.githubusercontent.com/yakumioto/YaHei-Consolas-Hybrid-1.12/master/YaHei%20Consolas%20Hybrid%201.12.ttf;

#####---vnc---#####;
#yum install gnome-classic-session gnome-terminal gnome-system-monitor tigervnc-server gedit firefox -y;sed -i 's/1024x768/1536x960/g' /usr/bin/vncserver;echo -e '[Unit]\nDescription=VNC\n\n[Service]\nType=simple\nExecStart=/usr/sbin/runuser -l root -c "/usr/bin/vncserver"\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/vncserver.service;systemctl enable vncserver.service;vncpasswd;

#####---reboot---#####;
timedatectl set-timezone Asia/Shanghai;
echo '0 2 * * * root yum upgrade -y' >> /etc/crontab;
echo '0 3 * * * root bash <(curl -L -s https://install.direct/go.sh)' >> /etc/crontab;
echo '0 4 * * * root reboot' >> /etc/crontab;

rm -f /root/*;
reboot;
