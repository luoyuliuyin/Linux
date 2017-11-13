#!/bin/sh

#####---shadowsocks---#####;
yum install epel-release -y;yum update -y;yum install vim wget net-tools python-setuptools -y;easy_install pip;pip install shadowsocks;echo 'alias sss="tail -f /var/log/shadowsocks.log"' >> /etc/bashrc;echo -e '[Unit]\nDescription=Shadowsocks\n\n[Service]\nType=forking\nExecStart=/usr/bin/ssserver -s ::0 -p 444 -k pengfeixiong -m aes-256-cfb --user nobody --workers 5 -d start\n\n[Install]\nWantedBy=multi-user.target' >> /etc/systemd/system/shadowsocks.service;systemctl enable shadowsocks;

#####---net_speeder---#####;
yum install libnet libnet-devel libpcap-devel gcc -y;wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/net-speeder/net_speeder-v0.1.tar.gz -O -|tar -xzv -C /opt;cd /opt/net_speeder;sh build.sh -DCOOKED;cd;echo -e '[Unit]\nDescription=net_speeder\nAfter=network.service\n\n[Service]\nType=simple\nExecStart=/opt/net_speeder/net_speeder eth0 "ip"\n\n[Install]\nWantedBy=multi-user.target' >> /etc/systemd/system/net_speeder.service;systemctl enable net_speeder;

#####—ttf---#####;
wget -P /usr/share/fonts/yahei https://raw.githubusercontent.com/yakumioto/YaHei-Consolas-Hybrid-1.12/master/YaHei%20Consolas%20Hybrid%201.12.ttf;

#####---vnc---#####;
yum install gnome-classic-session gnome-terminal gnome-system-monitor tigervnc-server gedit expect firefox -y;sed -i 's/1024x768/1536x960/g' /usr/bin/vncserver;echo -e '[Unit]\nDescription=VNC\n\n[Service]\nType=simple\nExecStart=/usr/sbin/runuser -l root -c "/usr/bin/vncserver %i"\n\n[Install]\nWantedBy=multi-user.target' >> /etc/systemd/system/vncserver@:1.service;systemctl enable vncserver@:1.service;vncpasswd;
