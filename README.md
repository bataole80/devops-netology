1 . 
    Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

    telnet route-views.routeviews.org
    Username: rviews
    show ip route x.x.x.x/32
    show bgp x.x.x.x/32

Ответ:

    vagrant@vagrant:~$ telnet route-views.routeviews.org
    Trying 128.223.51.103...
    Connected to route-views.routeviews.org.
    Escape character is '^]'.
    C
    **********************************************************************

                    RouteViews BGP Route Viewer
                    route-views.routeviews.org

     route views data is archived on http://archive.routeviews.org

     This hardware is part of a grant by the NSF.
     Please contact help@routeviews.org if you have questions, or
     if you wish to contribute your view.

     This router has views of full routing tables from several ASes.
     The list of peers is located at http://www.routeviews.org/peers
     in route-views.oregon-ix.net.txt

     NOTE: The hardware was upgraded in August 2014.  If you are seeing
     the error message, "no default Kerberos realm", you may want to
     in Mac OS X add "default unset autologin" to your ~/.telnetrc

     To login, use the username "rviews".

     **********************************************************************

    User Access Verification

    Username: rviews
    route-views>

    route-views>show ip route 109.184.55.145
    Routing entry for 109.184.0.0/17
      Known via "bgp 6447", distance 20, metric 0
      Tag 6939, type external
      Last update from 64.71.137.241 1w3d ago
      Routing Descriptor Blocks:
     * 64.71.137.241, from 64.71.137.241, 1w3d ago
      Route metric is 0, traffic share count is 1
      AS Hops 2
      Route tag 6939
      MPLS label: none
    route-views>

    route-views>show bgp 109.184.55.145
    BGP routing table entry for 109.184.0.0/17, version 1388583535
    Paths: (23 available, best #23, table default)
    Not advertised to any peer
    Refresh Epoch 1
    2497 12389
      202.232.0.2 from 202.232.0.2 (58.138.96.254)
        Origin IGP, localpref 100, valid, external
        path 7FE16938B8B0 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    20912 3257 3356 12389
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8070 3257:30515 3257:50001 3257:53900 3257:53902 20912:65004
      path 7FE0AE715280 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    4901 6079 3356 12389
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE0121167D0 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 3
    3303 12389
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external
      Community: 3303:1004 3303:1006 3303:1030 3303:3056
      path 7FE171248248 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    7660 2516 12389
    203.181.248.168 from 203.181.248.168 (203.181.248.168)
      Origin IGP, localpref 100, valid, external
      Community: 2516:1050 7660:9001
      path 7FE0F1974000 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    57866 3356 12389
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:901 3356:2065
      path 7FE11BF6AB70 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    7018 3356 12389
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin IGP, localpref 100, valid, external
      Community: 7018:5000 7018:37232
      path 7FE08D2E6CA8 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    3333 1103 12389
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      path 7FE1319EBAB8 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    49788 12552 12389
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin IGP, localpref 100, valid, external
      Community: 12552:12000 12552:12100 12552:12101 12552:22000
      Extended Community: 0x43:100:1
      path 7FE136B730D8 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    8283 1299 12389
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 1299:30000 8283:1 8283:101 8283:103
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x24
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001 0000 205B 0000 0005
              0000 0003
      path 7FE1678D2D88 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    3356 12389
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:901 3356:2065
      path 7FE172483708 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    1221 4637 12389
    203.62.252.83 from 203.62.252.83 (203.62.252.83)
      Origin IGP, localpref 100, valid, external
      path 7FE03908ABA0 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    852 3356 12389
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE038557FE0 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    20130 6939 12389
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external
      path 7FE0160E9DF0 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    701 1273 12389
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin IGP, localpref 100, valid, external
      path 7FE104D79FD0 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    3257 1299 12389
    89.149.178.10 from 89.149.178.10 (213.200.83.26)
      Origin IGP, metric 10, localpref 100, valid, external
      Community: 3257:8794 3257:30052 3257:50001 3257:54900 3257:54901
      path 7FE128C0A518 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    3549 3356 12389
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:901 3356:2065 3549:2581 3549:30840
      path 7FE0EF823D18 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    53767 14315 6453 6453 3356 12389
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external
      Community: 14315:5000 53767:5000
      path 7FE02119BAE0 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    101 3356 12389
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin IGP, localpref 100, valid, external
      Community: 101:20100 101:20110 101:22100 3356:2 3356:22 3356:100 3356:123 3356:501 3356:901 3356:2065
      Extended Community: RT:101:22100
      path 7FE0E59DBCF8 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    19214 3257 3356 12389
    208.74.64.40 from 208.74.64.40 (208.74.64.40)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8108 3257:30048 3257:50002 3257:51200 3257:51203
      path 7FE123526940 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    1351 6939 12389
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE120EA9A58 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    3561 3910 3356 12389
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7FE1260BE550 RPKI State valid
      rx pathid: 0, tx pathid: 0
    Refresh Epoch 1
    6939 12389
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external, best
      path 7FE1260C4250 RPKI State valid
      rx pathid: 0, tx pathid: 0x0
    route-views>

2 . Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

    
Добавить в конфигурацию

    root@vagrant:/home/vagrant# echo "dummy" >> /etc/modules
    root@vagrant:/home/vagrant# echo "options dummy numdummies=2" > /etc/modprobe.d/dummy.conf
    vagrant@vagrant:~$ cat /etc/network/interfaces.d/dummy.cfg
    auto dummy
    iface dummy0 inet static
    address 10.2.2.1/32
    pre-up ip link add dummy0 type dummy
    post-down ip link del dummy



    vagrant@vagrant:~$ sudo ip link add dummy0 type dummy
    vagrant@vagrant:/etc/network/interfaces.d$ sudo ip addr add 10.2.2.1/32 dev dummy0
    vagrant@vagrant:/etc/network/interfaces.d$ sudo ip link set dummy0 up
    vagrant@vagrant:/etc/network/interfaces.d$ ip l
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:73:60:cf brd ff:ff:ff:ff:ff:ff
    3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:ed:f7:b7 brd ff:ff:ff:ff:ff:ff
    4: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 6e:a9:21:74:37:64 brd ff:ff:ff:ff:ff:ff

    vagrant@vagrant:~$ sudo ip route add 169.255.0.0 dev dummy0
    vagrant@vagrant:~$ sudo ip route add 172.16.10.0/24 dev dummy0
    vagrant@vagrant:~$ ip r
    default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100
    default via 192.168.0.1 dev eth1 proto dhcp src 192.168.0.19 metric 100
    10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15
    10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100
    169.255.0.0 dev dummy0 scope link
    172.16.10.0/24 dev dummy0 scope link
    192.168.0.0/24 dev eth1 proto kernel scope link src 192.168.0.19
    192.168.0.1 dev eth1 proto dhcp scope link src 192.168.0.19 metric 100

3 . Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

    root@vagrant:/home/vagrant# netstat -atnlp
    Active Internet connections (servers and established)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
    tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/init
    tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      566/systemd-resolve
    tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      669/sshd: /usr/sbin
    tcp        0      0 10.0.2.15:22            10.0.2.2:55066          ESTABLISHED 1301/sshd: vagrant
    tcp6       0      0 :::111                  :::*                    LISTEN      1/init
    tcp6       0      0 :::22                   :::*                    LISTEN      669/sshd: /usr/sbin

Система инициализации/демон init, сервис systemd-resolve, демон sshd.

4 . Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

    root@vagrant:/home/vagrant# netstat -aunlp
    Active Internet connections (servers and established)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
    udp        0      0 127.0.0.53:53           0.0.0.0:*                           566/systemd-resolve
    udp        0      0 192.168.0.19:68         0.0.0.0:*                           1112/systemd-networ
    udp        0      0 10.0.2.15:68            0.0.0.0:*                           1112/systemd-networ
    udp        0      0 0.0.0.0:111             0.0.0.0:*                           1/init
    udp6       0      0 :::111                  :::*                                1/init

Система инициализации/демон init, сервис systemd-resolve, systemd-networkd.

5 . Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

![networkdiagram](diagram.png)



    
