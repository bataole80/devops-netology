Домашнее задание к занятию "3.5. Файловые системы"

1 . Узнайте о sparse (разряженных) файлах.

Разрежённый файл (англ. sparse file) — файл, в котором последовательности нулевых байтов[1] заменены на информацию об этих последовательностях (список дыр).
Преимущества:

- экономия дискового пространства. Использование разрежённых файлов считается одним из способов сжатия данных на уровне файловой системы;
- отсутствие временных затрат на запись нулевых байт;
    увеличение срока службы запоминающих устройств.

Недостатки:

- накладные расходы на работу со списком дыр;
- фрагментация файла при частой записи данных в дыры;
- невозможность записи данных в дыры при отсутствии свободного места на диске;
- невозможность использования других индикаторов дыр, кроме нулевых байт.

Разрежённые файлы используются для хранения контейнеров, например:

- образов дисков виртуальных машин;
- резервных копий дисков и/или разделов, созданных спец. ПО.
    
Создание разрежённого файла размером 200 Гб:

    dd if=/dev/zero of=./sparse-file bs=1 count=0 seek=200G
    
    
2 . Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Нет. Жесткие ссылки указывает на тот же inode, а эта информация содержится в inode. Права доступа и владелец одни и те же. Жесткие ссылки создаются, когда пользователь уже является владелбцем файла.
Но есть одно - насколько я понимаю, можно модифицировать следующий параметр - /proc/sys/fs/protected_hardlinks для обхода этого правила. Но это означает потенциальные проблемы с безопасностью.
Так лучше не делать.

3 . Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим.
Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.

    PS C:\Users\Oleg\Documents\TRAINING\DEVOPS\NETOLOGY\vagrantfiles> vagrant up
    Bringing machine 'default' up with 'virtualbox' provider...
    ==> default: Importing base box 'bento/ubuntu-20.04'...
    ==> default: Matching MAC address for NAT networking...
    ==> default: Checking if box 'bento/ubuntu-20.04' version '202107.28.0' is up to date...
    ==> default: Setting the name of the VM: vagrantfiles_default_1637874796842_16910
    ==> default: Clearing any previously set network interfaces...
    ==> default: Preparing network interfaces based on configuration...
        default: Adapter 1: nat
    ==> default: Forwarding ports...
        default: 22 (guest) => 2222 (host) (adapter 1)
    ==> default: Running 'pre-boot' VM customizations...
    ==> default: Booting VM...
    ==> default: Waiting for machine to boot. This may take a few minutes...
        default: SSH address: 127.0.0.1:2222
        default: SSH username: vagrant
        default: SSH auth method: private key
        default:
        default: Vagrant insecure key detected. Vagrant will automatically replace
        default: this with a newly generated keypair for better security.
        default:
        default: Inserting generated public key within guest...
        default: Removing insecure key from the guest if it's present...
        default: Key inserted! Disconnecting and reconnecting using new SSH key...
    ==> default: Machine booted and ready!
    ==> default: Checking for guest additions in VM...
    ==> default: Mounting shared folders...
        default: /vagrant => C:/Users/Oleg/Documents/TRAINING/DEVOPS/NETOLOGY/vagrantfiles
        
4 . Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

    vagrant@vagrant:~$ sudo fdisk -l
    Disk /dev/sda: 64 GiB, 68719476736 bytes, 134217728 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x3f94c461

    Device     Boot   Start       End   Sectors  Size Id Type
    /dev/sda1  *       2048   1050623   1048576  512M  b W95 FAT32
    /dev/sda2       1052670 134215679 133163010 63.5G  5 Extended
    /dev/sda5       1052672 134215679 133163008 63.5G 8e Linux LVM


    Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x1780df80

    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdb1          2048 4196351 4194304    2G 83 Linux
    /dev/sdb2       4196352 5242879 1046528  511M 83 Linux


    
5 . Используя sfdisk, перенесите данную таблицу разделов на второй диск.

    vagrant@vagrant:~$ sudo sfdisk -d /dev/sdb > partitions
    vagrant@vagrant:~$ cat partitions
    label: dos
    label-id: 0x1780df80
    device: /dev/sdb
    unit: sectors

    /dev/sdb1 : start=        2048, size=     4194304, type=83
    /dev/sdb2 : start=     4196352, size=     1046528, type=83
    vagrant@vagrant:~$ sudo sfdisk /dev/sdc < partitions
    Checking that no-one is using this disk right now ... OK

    Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes

    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Created a new DOS disklabel with disk identifier 0x1780df80.
    /dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
    /dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
    /dev/sdc3: Done.

    New situation:
    Disklabel type: dos
    Disk identifier: 0x1780df80

    Device     Boot   Start     End Sectors  Size Id Type
    /dev/sdc1          2048 4196351 4194304    2G 83 Linux
    /dev/sdc2       4196352 5242879 1046528  511M 83 Linux

    The partition table has been altered.
    Calling ioctl() to re-read partition table.
    Syncing disks.
    
    vagrant@vagrant:~$ lsblk -f
    NAME                 FSTYPE      LABEL UUID                                   FSAVAIL FSUSE% MOUNTPOINT
    sda
    ├─sda1               vfat              7D3B-6BE4                                 511M     0% /boot/efi
    ├─sda2
    └─sda5               LVM2_member       Mx3LcA-uMnN-h9yB-gC2w-qm7w-skx0-OsTz9z
    ├─vgvagrant-root   ext4              b527b79c-7f45-4e2b-a90f-1a4e9cb477c2     56.8G     2% /
    └─vgvagrant-swap_1 swap              fad91b1f-6eed-4e4b-8dbf-913ba5bcacc7                  [SWAP]
    sdb
    ├─sdb1
    └─sdb2
    sdc
    ├─sdc1
    └─sdc2
    
    
6 . Соберите mdadm RAID1 на паре разделов 2 Гб.

    vagrant@vagrant:~$ sudo mdadm --create --verbose /dev/md0 --level=mirror --raid-devices=2 /dev/sdb1 /dev/sdc1
    mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
    mdadm: size set to 2094080K
    Continue creating array? yes
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md0 started.
    vagrant@vagrant:~$ cat /proc/mdstat
    Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
    md0 : active raid1 sdc1[1] sdb1[0]
       2094080 blocks super 1.2 [2/2] [UU]
      [===================>.]  resync = 97.8% (2048576/2094080) finish=0.0min speed=157582K/sec

    unused devices: <none>
    
7 . Соберите mdadm RAID0 на второй паре маленьких разделов.

    vagrant@vagrant:~$ sudo mdadm --create --verbose /dev/md1 --level=stripe --raid-devices=2 /dev/sdb2 /dev/sdc2
    mdadm: chunk size defaults to 512K
    mdadm: Defaulting to version 1.2 metadata
    mdadm: array /dev/md1 started.
    vagrant@vagrant:~$ cat /proc/mdstat
    Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
    md1 : active raid0 sdc2[1] sdb2[0]
          1042432 blocks super 1.2 512k chunks

    md0 : active raid1 sdc1[1] sdb1[0]
          2094080 blocks super 1.2 [2/2] [UU]

    unused devices: <none>
    
8 . Создайте 2 независимых PV на получившихся md-устройствах.

    vagrant@vagrant:~$ sudo pvcreate -t -v /dev/md0
      TEST MODE: Metadata will NOT be updated and volumes will not be (de)activated.
      Wiping signatures on new PV /dev/md0.
      Set up physical volume for "/dev/md0" with 4188160 available sectors.
      Zeroing start of device /dev/md0.
      Writing physical volume data to disk "/dev/md0".
      Physical volume "/dev/md0" successfully created.
    vagrant@vagrant:~$ sudo pvcreate -v /dev/md0
      Wiping signatures on new PV /dev/md0.
      Set up physical volume for "/dev/md0" with 4188160 available sectors.
      Zeroing start of device /dev/md0.
      Writing physical volume data to disk "/dev/md0".
      Physical volume "/dev/md0" successfully created.

    vagrant@vagrant:~$ sudo pvcreate -t -v /dev/md1
      TEST MODE: Metadata will NOT be updated and volumes will not be (de)activated.
      Wiping signatures on new PV /dev/md1.
      Set up physical volume for "/dev/md1" with 2084864 available sectors.
      Zeroing start of device /dev/md1.
      Writing physical volume data to disk "/dev/md1".
      Physical volume "/dev/md1" successfully created.
    vagrant@vagrant:~$ sudo pvcreate -v /dev/md1
      Wiping signatures on new PV /dev/md1.
      Set up physical volume for "/dev/md1" with 2084864 available sectors.
      Zeroing start of device /dev/md1.
      Writing physical volume data to disk "/dev/md1".
      Physical volume "/dev/md1" successfully created.
    vagrant@vagrant:~$

    vagrant@vagrant:~$ sudo pvs
    PV         VG        Fmt  Attr PSize    PFree
      /dev/md0             lvm2 ---    <2.00g   <2.00g
      /dev/md1             lvm2 ---  1018.00m 1018.00m
      /dev/sda5  vgvagrant lvm2 a--   <63.50g       0

9 . Создайте общую volume-group на этих двух PV.

    vagrant@vagrant:~$ sudo vgcreate my_vg /dev/md0 /dev/md1
      Volume group "my_vg" successfully created
    vagrant@vagrant:~$ sudo vgdisplay
      ....
     --- Volume group ---
      VG Name               my_vg
      System ID
      Format                lvm2
      Metadata Areas        2
      Metadata Sequence No  1
      VG Access             read/write
      VG Status             resizable
      MAX LV                0
      Cur LV                0
      Open LV               0
      Max PV                0
      Cur PV                2
      Act PV                2
      VG Size               <2.99 GiB
      PE Size               4.00 MiB
      Total PE              765
      Alloc PE / Size       0 / 0
      Free  PE / Size       765 / <2.99 GiB
      VG UUID               igs2Yn-elb8-L3oM-aUBy-BCRL-P6at-n8nm2v

10 . Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

    vagrant@vagrant:~$ sudo lvcreate -L 100M -n lv100 my_vg /dev/md1
      Logical volume "lv100" created.
    vagrant@vagrant:~$
  
    vagrant@vagrant:~$ sudo lvdisplay
    ....
     --- Logical volume ---
      LV Path                /dev/my_vg/lv100
      LV Name                lv100
      VG Name                my_vg
      LV UUID                ZUpLP3-JsC2-8hGd-RGXz-enlg-p8AD-jvArQ6
      LV Write Access        read/write
      LV Creation host, time vagrant, 2021-11-27 20:56:52 +0000
      LV Status              available
      # open                 0
      LV Size                100.00 MiB
      Current LE             25
      Segments               1
      Allocation             inherit
      Read ahead sectors     auto
      - currently set to     4096
      Block device           253:2

    vagrant@vagrant:~$ sudo lsblk
    NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    sda                    8:0    0   64G  0 disk
    ├─sda1                 8:1    0  512M  0 part  /boot/efi
    ├─sda2                 8:2    0    1K  0 part
    └─sda5                 8:5    0 63.5G  0 part
      ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
      └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
    sdb                    8:16   0  2.5G  0 disk
    ├─sdb1                 8:17   0    2G  0 part
    │ └─md0                9:0    0    2G  0 raid1
    └─sdb2                 8:18   0  511M  0 part
      └─md1                9:1    0 1018M  0 raid0
        └─my_vg-lv100    253:2    0  100M  0 lvm
    sdc                    8:32   0  2.5G  0 disk
    ├─sdc1                 8:33   0    2G  0 part
    │ └─md0                9:0    0    2G  0 raid1
    └─sdc2                 8:34   0  511M  0 part
      └─md1                9:1    0 1018M  0 raid0
        └─my_vg-lv100    253:2    0  100M  0 lvm

11 . Создайте mkfs.ext4 ФС на получившемся LV.

    vagrant@vagrant:~$ sudo mkfs.ext4 /dev/my_vg/lv100
    mke2fs 1.45.5 (07-Jan-2020)
    Creating filesystem with 25600 4k blocks and 25600 inodes

    Allocating group tables: done
    Writing inode tables: done
    Creating journal (1024 blocks): done
    Writing superblocks and filesystem accounting information: done

12 . Смонтируйте этот раздел в любую директорию, например, /tmp/new.

    vagrant@vagrant:~$ lsblk --fs
    NAME                 FSTYPE            LABEL     UUID                                   FSAVAIL FSUSE% MOUNTPOINT
    sda
    ├─sda1               vfat                        7D3B-6BE4                                 511M     0% /boot/efi
    ├─sda2
    └─sda5               LVM2_member                 Mx3LcA-uMnN-h9yB-gC2w-qm7w-skx0-OsTz9z
      ├─vgvagrant-root   ext4                        b527b79c-7f45-4e2b-a90f-1a4e9cb477c2     56.7G     2% /
      └─vgvagrant-swap_1 swap                        fad91b1f-6eed-4e4b-8dbf-913ba5bcacc7                  [SWAP]
    sdb
    ├─sdb1               linux_raid_member vagrant:0 6b47ef77-2edc-f00d-0ce7-a06e38be97a9
    │ └─md127            LVM2_member                 OuORlc-s53g-YkC6-T8Fb-cjXX-ydaR-CYdY23
    └─sdb2               linux_raid_member vagrant:1 c99f8592-df0b-08ce-2754-771ec9b201a8
      └─md126            LVM2_member                 YAb6Mt-yDgx-HYaX-f5R6-2Rrg-DYIt-SY3ycn
        └─my_vg-lv100    ext4                        86f3543d-fe5f-43cc-9bda-ba631808b2ed
    sdc
    ├─sdc1               linux_raid_member vagrant:0 6b47ef77-2edc-f00d-0ce7-a06e38be97a9
    │ └─md127            LVM2_member                 OuORlc-s53g-YkC6-T8Fb-cjXX-ydaR-CYdY23
    └─sdc2               linux_raid_member vagrant:1 c99f8592-df0b-08ce-2754-771ec9b201a8
      └─md126            LVM2_member                 YAb6Mt-yDgx-HYaX-f5R6-2Rrg-DYIt-SY3ycn
        └─my_vg-lv100    ext4                        86f3543d-fe5f-43cc-9bda-ba631808b2ed
    vagrant@vagrant:~$ mkdir /tmp/new
    vagrant@vagrant:~$ sudo mount /dev/mapper/my_vg-lv100 /tmp/new
    vagrant@vagrant:~$ df -kh
    Filesystem                  Size  Used Avail Use% Mounted on
    udev                        447M     0  447M   0% /dev
    tmpfs                        99M  712K   98M   1% /run
    /dev/mapper/vgvagrant-root   62G  1.5G   57G   3% /
    tmpfs                       491M     0  491M   0% /dev/shm
    tmpfs                       5.0M     0  5.0M   0% /run/lock
    tmpfs                       491M     0  491M   0% /sys/fs/cgroup
    /dev/sda1                   511M  4.0K  511M   1% /boot/efi
    tmpfs                        99M     0   99M   0% /run/user/1000
    /dev/mapper/my_vg-lv100      93M   72K   86M   1% /tmp/new

13 . Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.

    vagrant@vagrant:/tmp/new$ sudo wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
    --2021-11-28 12:01:26--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
    Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183
    Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 22540872 (21M) [application/octet-stream]
    Saving to: ‘/tmp/new/test.gz’

    /tmp/new/test.gz                       100%[============================================================================>]  21.50M  2.84MB/s    in 8.7s

    2021-11-28 12:01:34 (2.47 MB/s) - ‘/tmp/new/test.gz’ saved [22540872/22540872] 
    vagrant@vagrant:/tmp/new$ ls -l
    total 22032
    drwx------ 2 root root    16384 Nov 28 11:36 lost+found
    -rw-r--r-- 1 root root 22540872 Nov 28 06:02 test.gz

14 . Прикрепите вывод lsblk.

    vagrant@vagrant:/tmp/new$ lsblk
    NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    sda                    8:0    0   64G  0 disk
    ├─sda1                 8:1    0  512M  0 part  /boot/efi
    ├─sda2                 8:2    0    1K  0 part
    └─sda5                 8:5    0 63.5G  0 part
      ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
      └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
    sdb                    8:16   0  2.5G  0 disk
    ├─sdb1                 8:17   0    2G  0 part
    │ └─md127              9:127  0    2G  0 raid1
    └─sdb2                 8:18   0  511M  0 part
      └─md126              9:126  0 1018M  0 raid0
        └─my_vg-lv100    253:2    0  100M  0 lvm   /tmp/new
    sdc                    8:32   0  2.5G  0 disk
    ├─sdc1                 8:33   0    2G  0 part
    │ └─md127              9:127  0    2G  0 raid1
    └─sdc2                 8:34   0  511M  0 part
      └─md126              9:126  0 1018M  0 raid0
        └─my_vg-lv100    253:2    0  100M  0 lvm   /tmp/new

15 . Протестируйте целостность файла:

    vagrant@vagrant:/tmp/new$ gzip -t /tmp/new/test.gz
    vagrant@vagrant:/tmp/new$ ls
    lost+found  test.gz
    vagrant@vagrant:/tmp/new$ echo $?
    0
    vagrant@vagrant:/tmp/new$

16 . Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

    vagrant@vagrant:/tmp/new$ sudo pvmove /dev/md126 /dev/md127
      /dev/md126: Moved: 16.00%
      /dev/md126: Moved: 100.00%

    vagrant@vagrant:/tmp/new$ lsblk
    NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    sda                    8:0    0   64G  0 disk
    ├─sda1                 8:1    0  512M  0 part  /boot/efi
    ├─sda2                 8:2    0    1K  0 part
    └─sda5                 8:5    0 63.5G  0 part
      ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
      └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
    sdb                    8:16   0  2.5G  0 disk
    ├─sdb1                 8:17   0    2G  0 part
    │ └─md127              9:127  0    2G  0 raid1
    │   └─my_vg-lv100    253:2    0  100M  0 lvm   /tmp/new
    └─sdb2                 8:18   0  511M  0 part
     └─md126              9:126  0 1018M  0 raid0
    sdc                    8:32   0  2.5G  0 disk
    ├─sdc1                 8:33   0    2G  0 part
    │ └─md127              9:127  0    2G  0 raid1
    │   └─my_vg-lv100    253:2    0  100M  0 lvm   /tmp/new
    └─sdc2                 8:34   0  511M  0 part
      └─md126              9:126  0 1018M  0 raid0

17 . Сделайте --fail на устройство в вашем RAID1 md.

    vagrant@vagrant:/tmp/new$ sudo mdadm --fail /dev/md127 /dev/sdb1
    mdadm: set /dev/sdb1 faulty in /dev/md127

18 . Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.

    vagrant@vagrant:/tmp/new$ dmesg | grep md127
    [    3.214819] md/raid1:md127: active with 2 out of 2 mirrors
    [    3.214864] md127: detected capacity change from 0 to 2144337920
    [ 3343.152245] md/raid1:md127: Disk failure on sdb1, disabling device.
                   md/raid1:md127: Operation continuing on 1 devices.
    vagrant@vagrant:/tmp/new$

19 . Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

    vagrant@vagrant:/tmp/new$ gzip -t /tmp/new/test.gz
    vagrant@vagrant:/tmp/new$ echo $?
    0
    vagrant@vagrant:/tmp/new$

20 . Погасите тестовый хост, vagrant destroy.

    PS C:\Users\Oleg Lon\Documents\TRAINING\DEVOPS\NETOLOGY\vagrantfiles> vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
    ==> default: Forcing shutdown of VM...
    ==> default: Destroying VM and associated drives...