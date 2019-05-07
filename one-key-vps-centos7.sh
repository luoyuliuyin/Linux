#!/bin/sh

#####---shadowsocks---#####;
yum update -y;yum install vim wget git -y;wget ftp://ftp.pbone.net/mirror/download.fedora.redhat.com/pub/fedora/epel/7/x86_64/Packages/l/libsodium-1.0.17-1.el7.x86_64.rpm;yum install libsodium-1.0.17-1.el7.x86_64.rpm -y;cd /opt;git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git;cd /opt/shadowsocksr;bash initcfg.sh;echo 'alias log="tail -f /var/log/shadowsocksr.log"' >> /etc/bashrc;echo -e '[Unit]\nDescription=Shadowsocksr\n\n[Service]\nType=forking\nExecStart=/usr/bin/python /opt/shadowsocksr/shadowsocks/server.py -p 4399 -k pengfeixiong -m chacha20 -O auth_aes128_md5 -o http_simple --workers 2 -d start\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/shadowsocksr.service;systemctl enable shadowsocksr;

#####---net_speeder---#####;
yum install libnet libnet-devel libpcap-devel gcc -y;wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/net-speeder/net_speeder-v0.1.tar.gz -O -|tar -xzv -C /opt;cd /opt/net_speeder;sh build.sh -DCOOKED;cd;echo -e '[Unit]\nDescription=net_speeder\nAfter=network.service\n\n[Service]\nType=simple\nExecStart=/opt/net_speeder/net_speeder eth0 "ip"\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/net_speeder.service;systemctl enable net_speeder;

#####—ttf---#####;
#wget -P /usr/share/fonts/yahei https://raw.githubusercontent.com/yakumioto/YaHei-Consolas-Hybrid-1.12/master/YaHei%20Consolas%20Hybrid%201.12.ttf;

#####---vnc---#####;
#yum install gnome-classic-session gnome-terminal gnome-system-monitor tigervnc-server gedit expect firefox -y;sed -i 's/1024x768/1536x960/g' /usr/bin/vncserver;echo -e '[Unit]\nDescription=VNC\n\n[Service]\nType=simple\nExecStart=/usr/sbin/runuser -l root -c "/usr/bin/vncserver %i"\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/vncserver@:1.service;systemctl enable vncserver@:1.service;vncpasswd;

cd;rm -f *;reboot;
