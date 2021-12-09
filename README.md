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

Пометка для доработки:
Задание 2
Вам же прямо пишет, что не удается создать сокет:
2021-12-08T15:36:18 [INFO/main] unable to create control socket because it already exists
2021-12-08T15:36:18 [INFO/main] check if another instance is running

Ван нужно либо правильно настроить сеть: www.vagrantup.com...te_network
Либо, как вариант, запустить саму две убунту как ВМ (например, VirtualBox), но для этого всё равно нужно настроить внутреннюю сеть.

С уважением,
Алексей

Ответ:
Как я и предполагал ранее, настройка сети помогла решить и получить ответ по LLDP neighbours:

    vagrant@vagrant:~$ lldpctl
    -------------------------------------------------------------------------------
    LLDP neighbors:
    -------------------------------------------------------------------------------
    Interface:    eth1, via: LLDP, RID: 1, Time: 0 day, 00:01:08
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
    PortID:       mac 08:00:27:f6:aa:d1
    PortDescr:    eth1
    TTL:          120
    PMD autoneg:  supported: yes, enabled: yes
      Adv:          10Base-T, HD: yes, FD: yes
      Adv:          100Base-TX, HD: yes, FD: yes
      Adv:          1000Base-T, HD: no, FD: yes
      MAU oper type: 1000BaseTFD - Four-pair Category 5 UTP, full duplex mode
    -------------------------------------------------------------------------------

    vagrant@vagrant:~$ lldpctl
    -------------------------------------------------------------------------------
    LLDP neighbors:
    -------------------------------------------------------------------------------
    Interface:    eth1, via: LLDP, RID: 1, Time: 0 day, 00:01:03
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
    PortID:       mac 08:00:27:ed:f7:b7
    PortDescr:    eth1
    TTL:          120
    PMD autoneg:  supported: yes, enabled: yes
      Adv:          10Base-T, HD: yes, FD: yes
      Adv:          100Base-TX, HD: yes, FD: yes
      Adv:          1000Base-T, HD: no, FD: yes
      MAU oper type: 1000BaseTFD - Four-pair Category 5 UTP, full duplex mode
    -------------------------------------------------------------------------------

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

Типы агрегации, или бондинга, в Linux:
- Mode-0(balance-rr) – Данный режим используется по умолчанию. Balance-rr обеспечивается балансировку нагрузки и отказоустойчивость. В данном режиме сетевые пакеты отправляются “по кругу”, от первого интерфейса к последнему. Если выходят из строя интерфейсы, пакеты отправляются на остальные оставшиеся.
- Mode-1(active-backup) – Один из интерфейсов работает в активном режиме, остальные в ожидающем. При обнаружении проблемы на активном интерфейсе производится переключение на ожидающий интерфейс. 
- Mode-2(balance-xor) – Передача пакетов распределяется по типу входящего и исходящего трафика по формуле ((MAC src) XOR (MAC dest)) % число интерфейсов. Режим дает балансировку нагрузки и отказоустойчивость. 
- Mode-3(broadcast) – Происходит передача во все объединенные интерфейсы, тем самым обеспечивая отказоустойчивость. Рекомендуется только для использования MULTICAST трафика. 
- Mode-4(802.3ad) – динамическое объединение одинаковых портов. В данном режиме можно значительно увеличить пропускную способность входящего так и исходящего трафика. Для данного режима необходима поддержка и настройка коммутатора/коммутаторов. 
- Mode-5(balance-tlb) – Адаптивная балансировки нагрузки трафика. Входящий трафик получается только активным интерфейсом, исходящий распределяется в зависимости от текущей загрузки канала каждого интерфейса. 
- Mode-6(balance-alb) – Адаптивная балансировка нагрузки. Отличается более совершенным алгоритмом балансировки нагрузки чем Mode-5). Обеспечивается балансировку нагрузки как исходящего так и входящего трафика. 

На моей машине нет возможности бондинга по причине наличия только одного сетевого интерфейса.
Поэтому пример взят из сети

    cat /etc/network/interfaces
    # The primary network interface
    auto bond0
    iface bond0 inet static
        address 192.168.1.150
        netmask 255.255.255.0    
        gateway 192.168.1.1
        dns-nameservers 192.168.1.1 8.8.8.8
        dns-search domain.local
            slaves eth0 eth1
            bond_mode 0
            bond-miimon 100
            bond_downdelay 200
            bound_updelay 200

5 . Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

6 (узловых) адресов. 32 подсети.
Примеры /29 подсетей внутри сети 10.10.10.0/24:

    10.10.10.249/29
    10.10.10.250/29
    10.10.10.252/29

Комментарий к доработке:
Почему сетей будет именно 25? Покажите расчеты.

Ответ: Изначальный ответ был неправильный, перепутал цифры.
В подсети /29 29 бит определяют маску, в сети /24 24 бита.
Следовательно, при делении сети /24 на подсети /29 берутся 5 бит, соответственно,
получается два в пятой степени количество подсетей. А это 32 подсети.

6 . Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.

Можно взять подсеть из диапазона 100.64.0.0 — 100.127.255.255 
(маска подсети: 255.192.0.0 или /10):

100.64.1.0/26

7 . Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?

Windows

    PS C:\Users\Oleg Lon> arp -a

    Interface: 192.168.56.1 --- 0x12
      Internet Address      Physical Address      Type
      192.168.56.255        ff-ff-ff-ff-ff-ff     static
      224.0.0.2             01-00-5e-00-00-02     static
      224.0.0.22            01-00-5e-00-00-16     static
      224.0.0.251           01-00-5e-00-00-fb     static
      224.0.0.252           01-00-5e-00-00-fc     static
      239.255.255.250       01-00-5e-7f-ff-fa     static
      255.255.255.255       ff-ff-ff-ff-ff-ff     static

Linux

    vagrant@vagrant:~$ sudo arp-scan --interface=eth0 --localnet
    Interface: eth0, type: EN10MB, MAC: 08:00:27:73:60:cf, IPv4: 10.0.2.15
    Starting arp-scan 1.9.7 with 256 hosts (https://github.com/royhills/arp-scan)
    10.0.2.2        52:54:00:12:35:02       QEMU
    10.0.2.3        52:54:00:12:35:03       QEMU
    10.0.2.4        52:54:00:12:35:04       QEMU

    3 packets received by filter, 0 packets dropped by kernel
    Ending arp-scan 1.9.7: 256 hosts scanned in 2.059 seconds (124.33 hosts/sec). 3 responded

    Очистить кэш arp:

Linux

    vagrant@vagrant:~$ sudo ip -s -s neigh flush all
    10.0.2.3 dev eth0 lladdr 52:54:00:12:35:03 used 394/196/153 probes 1 STALE
    10.0.2.2 dev eth0 lladdr 52:54:00:12:35:02 ref 1 used 9/0/6 probes 1 REACHABLE

    *** Round 1, deleting 2 entries ***

Windows
 
    netsh interface ip delete arpcache

Удалить один ip:

    arp -d <ip> (в моем дистрибутиве Ubuntu нет такой команды, та же команда в Windows)

    vagrant@vagrant:~$ sudo ip neighbour del dev eth0 10.0.2.2

8 . Установите эмулятор EVE-ng.

Инструкция по установке - https://github.com/svmyasnikov/eve-ng

Выполните задания на lldp, vlan, bonding в эмуляторе EVE-ng.












    