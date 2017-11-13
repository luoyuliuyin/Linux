#!/bin/sh

#####---shadowsocks---#####;
yum install epel-release -y;yum update -y;yum install python-setuptools -y;easy_install pip;pip install shadowsocks;echo 'alias sslog="tail -f /var/log/shadowsocks.log"' >> /etc/bashrc;echo -e '/usr/bin/ssserver -s ::0 -p 444 -k pengfeixiong -m aes-256-cfb --user nobody --workers 2 -d start' >> /etc/rc.local;

#####---net_speeder---#####;
yum install libnet libnet-devel libpcap-devel gcc -y;wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/net-speeder/net_speeder-v0.1.tar.gz -O -|tar -xzv -C /opt;cd /opt/net_speeder;sh build.sh -DCOOKED;cd;echo -e '/opt/net_speeder/net_speeder eth0 "ip"' >> /etc/rc.local;

#####—ttf---#####;
wget -P /usr/share/fonts/yahei https://raw.githubusercontent.com/yakumioto/YaHei-Consolas-Hybrid-1.12/master/YaHei%20Consolas%20Hybrid%201.12.ttf;

#####---vnc---#####;
yum install gnome-desktop gnome-session gnome-panel gnome-terminal gnome-system-monitor chkconfig tigervnc-server -y;sed -i 's/1024x768/2561x1600/g' /usr/bin/vncserver;echo -e 'gnome-session &\nvncconfig -iconic &' >> /root/.vnc/xstartup;chkconfig vncserver on --level 345;vncpasswd;
