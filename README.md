Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2"

1 . Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

Linux

    vagrant@vagrant:~$ ip -br l
    lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>
    eth0             UP             08:00:27:73:60:cf <BROADCAST,MULTICAST,UP,LOWER_UP>

Windows

    PS C:\Users\Oleg Lon> ipconfig /all

    Windows IP Configuration
    ....
   
    Ethernet adapter Ethernet:

       Media State . . . . . . . . . . . : Media disconnected
       Connection-specific DNS Suffix  . :
       Description . . . . . . . . . . . : Realtek PCIe FE Family Controller
       Physical Address. . . . . . . . . : DC-4A-3E-E7-A4-EA
       DHCP Enabled. . . . . . . . . . . : Yes
       Autoconfiguration Enabled . . . . : Yes

    Ethernet adapter VirtualBox Host-Only Network:

       Connection-specific DNS Suffix  . :
       Description . . . . . . . . . . . : VirtualBox Host-Only Ethernet Adapter
       Physical Address. . . . . . . . . : 0A-00-27-00-00-12
       DHCP Enabled. . . . . . . . . . . : No
       Autoconfiguration Enabled . . . . : Yes
       Link-local IPv6 Address . . . . . : fe80::a47f:684:49d0:8c60%18(Preferred)
       IPv4 Address. . . . . . . . . . . : 192.168.56.1(Preferred)
       Subnet Mask . . . . . . . . . . . : 255.255.255.0
       Default Gateway . . . . . . . . . :
       DHCPv6 IAID . . . . . . . . . . . : 738852903
       DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-1D-FD-4F-D2-DC-4A-3E-E7-A4-EA
       DNS Servers . . . . . . . . . . . : fec0:0:0:ffff::1%1
                                           fec0:0:0:ffff::2%1
                                           fec0:0:0:ffff::3%1
    NetBIOS over Tcpip. . . . . . . . : Enabled

    Wireless LAN adapter Local Area Connection* 1:

       Media State . . . . . . . . . . . : Media disconnected
       Connection-specific DNS Suffix  . :
       Description . . . . . . . . . . . : Microsoft Wi-Fi Direct Virtual Adapter
       Physical Address. . . . . . . . . : E0-94-67-C9-25-03
       DHCP Enabled. . . . . . . . . . . : Yes
       Autoconfiguration Enabled . . . . : Yes
    ....
    Wireless LAN adapter WiFi:

       Connection-specific DNS Suffix  . :
       Description . . . . . . . . . . . : Intel(R) Dual Band Wireless-AC 3165
       Physical Address. . . . . . . . . : E0-94-67-C9-25-02
       DHCP Enabled. . . . . . . . . . . : Yes
       Autoconfiguration Enabled . . . . : Yes
       Link-local IPv6 Address . . . . . : fe80::f474:e689:391b:9bb%20(Preferred)
       IPv4 Address. . . . . . . . . . . : 192.168.0.17(Preferred)
       Subnet Mask . . . . . . . . . . . : 255.255.255.0
       Lease Obtained. . . . . . . . . . : 3 декабря 2021 г. 19:01:56
       Lease Expires . . . . . . . . . . : 4 декабря 2021 г. 19:06:56
       Default Gateway . . . . . . . . . : 192.168.0.1
       DHCP Server . . . . . . . . . . . : 192.168.0.1
       DHCPv6 IAID . . . . . . . . . . . : 65049703
       DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-1D-FD-4F-D2-DC-4A-3E-E7-A4-EA
       DNS Servers . . . . . . . . . . . : 192.168.0.1
       NetBIOS over Tcpip. . . . . . . . : Enabled

2 . Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

Протокол LLDP канального уровня. 
Пакеты lldpd, snmpd.

    root@vagrant:~# lldpd -d
    2021-12-03T18:19:46 [INFO/main] protocol LLDP enabled
    2021-12-03T18:19:46 [INFO/main] protocol CDPv1 disabled
    2021-12-03T18:19:46 [INFO/main] protocol CDPv2 disabled
    2021-12-03T18:19:46 [INFO/main] protocol SONMP disabled
    2021-12-03T18:19:46 [INFO/main] protocol EDP disabled
    2021-12-03T18:19:46 [INFO/main] protocol FDP disabled
    2021-12-03T18:19:46 [INFO/event] libevent 2.1.11-stable initialized with epoll method
    2021-12-03T18:19:46 [INFO/lldpctl] lldpd should resume operations

    root@vagrant:~# sudo service lldpd restart
    root@vagrant:~# lldpctl
    -------------------------------------------------------------------------------
    LLDP neighbors:
    -------------------------------------------------------------------------------
 
    root@vagrant:~# lldpcli
    [lldpcli] # show neighbors
    -------------------------------------------------------------------------------
    LLDP neighbors:
    -------------------------------------------------------------------------------
    [lldpcli] # show interfaces
    -------------------------------------------------------------------------------
    LLDP interfaces:
    -------------------------------------------------------------------------------
    Interface:    eth0, via: unknown, Time: 0 day, 00:03:26
      Chassis:
        ChassisID:    mac 08:00:27:73:60:cf
        SysName:      vagrant.vm
        SysDescr:     Ubuntu 20.04.2 LTS Linux 5.4.0-80-generic #90-Ubuntu SMP Fri Jul 9 22:49:44 UTC 2021 x86_64
        MgmtIP:       10.0.2.15
        MgmtIP:       fe80::a00:27ff:fe73:60cf
        Capability:   Bridge, off
        Capability:   Router, off
        Capability:   Wlan, off
        Capability:   Station, on
      Port:
        PortID:       mac 08:00:27:73:60:cf
        PortDescr:    eth0
      TTL:          120
    -------------------------------------------------------------------------------

Уважаемые методисты курса, не совсем понятно задание про команды и использование инструмента lldpd.
Помнится, мы устанавливали машину с помощью vagrant. Инструмент lldpd, насколько я понял, не покажет
соседей при использовании NAT подключения. А vagrant его использует по умолчанию.
Вот выдержка из документации: Vagrant assumes there is an available NAT device on eth0. This ensures that Vagrant always has a way of communicating with the guest machine. It is possible to change this manually (outside of Vagrant), however, this may lead to inconsistent behavior. Providers might have additional assumptions. For example, in VirtualBox, this assumption means that network adapter 1 is a NAT device.
Мне кажется, что при такой ситуации автор задания должен помочь студентам настроить среду должным образом.

3 . Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

Технология VLAN. Пакет vlan в Linux. 

Команды (опробованы из документации)
    vagrant@vagrant:~$ sudo modprobe 8021q
    vagrant@vagrant:~$ sudo ip link add link eth0 name eth0.10 type vlan id 10
    vagrant@vagrant:~$ sudo ip addr add 10.0.0.1/24 dev eth0.10
    vagrant@vagrant:~$ sudo ip link set up eth0.10
    
    vagrant@vagrant:~$ ip link
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
        link/ether 08:00:27:73:60:cf brd ff:ff:ff:ff:ff:ff
    3: eth0.10@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
        link/ether 08:00:27:73:60:cf brd ff:ff:ff:ff:ff:ff

4 . Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.




    