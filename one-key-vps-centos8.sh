#!/bin/sh

#####---shadowsocks---#####;
yum update -y;
yum install vim wget unzip git python36 -y;
wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/l/libsodium-1.0.18-1.el7.x86_64.rpm;
yum install libsodium-1.0.18-1.el7.x86_64.rpm -y;
cd /opt;
git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git;
cd /opt/shadowsocksr;
bash initcfg.sh;
echo 'alias log="tail -f /var/log/shadowsocksr.log"' >> /etc/bashrc;
echo -e '[Unit]\nDescription=Shadowsocksr\n\n[Service]\nType=forking\nExecStart=/usr/bin/python3 /opt/shadowsocksr/shadowsocks/server.py -p 4399 -k pengfeixiong -m chacha20 -O auth_aes128_md5 -o tls1.2_ticket_auth --workers 2 -d start\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/shadowsocksr.service;
systemctl enable shadowsocksr;

#####---net_speeder---#####;
#yum install libnet libnet-devel libpcap-devel gcc -y;wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/net-speeder/net_speeder-v0.1.tar.gz -O -|tar -xzv -C /opt;cd /opt/net_speeder;sh build.sh -DCOOKED;cd;echo -e '[Unit]\nDescription=net_speeder\nAfter=network.service\n\n[Service]\nType=simple\nExecStart=/opt/net_speeder/net_speeder eth0 "ip"\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/net_speeder.service;systemctl enable net_speeder;

#####—--spring-boot-tools---#####;
cd;
wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.zip;
unzip apache-maven-3.6.2-bin.zip;
mv apache-maven-3.6.2 /opt;
wget https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.rpm;
yum install jdk-8u212-linux-x64.rpm -y;
echo -e '# .bash_profile\n\n# Get the aliases and functions\nif [ -f ~/.bashrc ]; then\n        . ~/.bashrc\nfi\n\n# User specific environment and startup programs\nexport LC_ALL=en_US.UTF-8\nexport JAVA_HOME=/usr/java/default/\nexport MAVEN_HOME=/opt/apache-maven-3.6.2/\nPATH=$PATH:$HOME/bin:$JAVA_HOME/bin:$MAVEN_HOME/bin\n\nexport PATH' > /root/.bash_profile;
source /root/.bash_profile;
cd /opt;
git clone https://github.com/luoyuliuyin/spring-boot-tools.git;
cd spring-boot-tools;
mvn clean install;
echo -e '[Unit]\n	Description=spring-boot-tools\n\n[Service]\n	Type=forking\n	WorkingDirectory=/root\n	Restart=always\n	RestartSec=1\n	ExecStart=/usr/bin/java -jar /opt/spring-boot-tools/target/spring-boot-tools.jar\n\n[Install]\n	WantedBy=multi-user.target' > /etc/systemd/system/spring-boot-tools.service;
systemctl enable spring-boot-tools;

#####—--ttf---#####;
#wget -P /usr/share/fonts/yahei https://raw.githubusercontent.com/yakumioto/YaHei-Consolas-Hybrid-1.12/master/YaHei%20Consolas%20Hybrid%201.12.ttf;

#####---vnc---#####;
#yum install gnome-classic-session gnome-terminal gnome-system-monitor tigervnc-server gedit firefox -y;sed -i 's/1024x768/1536x960/g' /usr/bin/vncserver;echo -e '[Unit]\nDescription=VNC\n\n[Service]\nType=simple\nExecStart=/usr/sbin/runuser -l root -c "/usr/bin/vncserver"\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/vncserver.service;systemctl enable vncserver.service;vncpasswd;

cd;
rm -f *;
reboot;
