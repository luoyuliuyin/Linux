#####---shadowsocks---#####;
yum install epel-release -y;yum update -y;yum install python-setuptools -y;easy_install pip;pip install shadowsocks;echo 'alias sslog="tail -f /var/log/shadowsocks.log"' >> /etc/bashrc;echo -e '/usr/bin/ssserver -s ::0 -p 443 -k feizong -m rc4-md5 --user nobody --workers 2 -d start' >> /etc/rc.local;

#####---net_speeder---#####;
yum install libnet libnet-devel libpcap-devel gcc -y;wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/net-speeder/net_speeder-v0.1.tar.gz -O -|tar -xzv -C /opt;cd /opt/net_speeder;sh build.sh -DCOOKED;cd;echo -e '/opt/net_speeder/net_speeder venet0 "ip"' >> /etc/rc.local;

#####—ttf---#####;
wget -P /usr/share/fonts/yahei https://raw.githubusercontent.com/yakumioto/YaHei-Consolas-Hybrid-1.12/master/YaHei%20Consolas%20Hybrid%201.12.ttf;

#####---vnc---#####;
yum install gnome-classic-session gnome-terminal gnome-system-monitor tigervnc-server firefox -y;sed -i 's/1024x768/1536x960/g' /usr/bin/vncserver;echo -e '/usr/sbin/runuser -l root -c "/usr/bin/vncserver %i"' >> /etc/rc.local;vncpasswd;